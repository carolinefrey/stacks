//
//  StravaService.swift
//  Stacks
//
//  Created by Caroline Frey on 9/30/25.
//

import Foundation

struct WorkoutResults: Codable {
    var results: [StravaActivity]
}

struct StravaActivity: Codable {
    var name: String?
    var distance: Double?
    var movingTime: Int?
    var type: String?
    var startDate: Date?
}

struct TokenResponse: Codable {
    let access_token: String
    let refresh_token: String
    let expires_at: Int
}

func fetchActivities(completion: @escaping ([Workout]?, Error?) -> Void) {
    guard let url = URL(string: "https://www.strava.com/api/v3/athlete/activities") else {
        return
    }

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    urlRequest.setValue("Bearer \(Secrets.stravaAccessToken)", forHTTPHeaderField: "Authorization")

    URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        guard let data, error == nil else { return }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            
            let results = try decoder.decode([StravaActivity].self, from: data)
            
            let workouts = results.map { result in
                Workout(
                    title: result.name ?? "Untitled Workout",
                    type: WorkoutType(stravaType: result.type ?? "Workout"),
                    date: result.startDate ?? Date(),
                    duration: formatDurationMetric(result.movingTime ?? 0)
                )
            }

            completion(workouts, nil)
        } catch {
            completion(nil, error)
            print("Error: \(error.localizedDescription)")
        }
    }.resume()
}

func refreshAccessToken(refreshToken: String, completion: @escaping (String?, String?, Int?, Error?) -> Void) {
    guard let url = URL(string: "https://www.strava.com/oauth/token") else { return }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"

    let parameters = [
        "client_id": "YOUR_CLIENT_ID",
        "client_secret": "YOUR_CLIENT_SECRET",
        "grant_type": "refresh_token",
        "refresh_token": refreshToken
    ]
    
    request.httpBody = "client_id=\(parameters["client_id"]!)&client_secret=\(parameters["client_secret"]!)&grant_type=refresh_token&refresh_token=\(parameters["refresh_token"]!)".data(using: .utf8)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            completion(nil, nil, nil, error)
            return
        }

        do {
            let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
            completion(tokenResponse.access_token, tokenResponse.refresh_token, tokenResponse.expires_at, nil)
        } catch {
            completion(nil, nil, nil, error)
        }
    }.resume()
}

//func fetchActivitiesWithAutoRefresh(storedRefreshToken: String, storedAccessToken: String, storedExpiresAt: Int, completion: @escaping ([Workout]?, Error?) -> Void) {
//    let currentTime = Int(Date().timeIntervalSince1970)
//    if currentTime < storedExpiresAt {
//        // Token valid, fetch activities directly
//        fetchActivities { workouts, error in
//            completion(workouts, error)
//        }
//    } else {
//        // Token expired, refresh first
//        refreshAccessToken(refreshToken: storedRefreshToken) { newAccessToken, newRefreshToken, newExpiresAt, error in
//            guard let accessToken = newAccessToken, let expiresAt = newExpiresAt, error == nil else {
//                completion(nil, error)
//                return
//            }
//            // Use the new access token to fetch activities
//            // Update the authorization header inside fetchActivities function or create a variant that accepts access token
//            // Here, we create a variant of fetchActivities that accepts access token
//            
//            fetchActivitiesWithAccessToken(accessToken: accessToken, completion: completion)
//        }
//    }
//}

//func fetchActivitiesWithAccessToken(accessToken: String, completion: @escaping ([Workout]?, Error?) -> Void) {
//    guard let url = URL(string: "https://www.strava.com/api/v3/athlete/activities") else {
//        completion(nil, URLError(.badURL))
//        return
//    }
//
//    var urlRequest = URLRequest(url: url)
//    urlRequest.httpMethod = "GET"
//    urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//
//    URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//        guard let data = data, error == nil else {
//            completion(nil, error)
//            return
//        }
//
//        do {
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            let results = try decoder.decode([Result].self, from: data)
//
//            let workouts = results.map { result in
//                Workout(
//                    title: result.name ?? "Untitled Workout",
//                    type: WorkoutType(rawValue: result.type ?? "") ?? .crossFit,
//                    date: Date.fromStravaDay(result.date) ?? Date(),
//                    duration: String(result.movingTime ?? 0)
//                )
//            }
//
//            completion(workouts, nil)
//        } catch {
//            completion(nil, error)
//            print("StravaService Error: \(error.localizedDescription)")
//        }
//    }.resume()
//}

