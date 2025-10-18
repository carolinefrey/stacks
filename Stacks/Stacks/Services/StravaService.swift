//
//  StravaService.swift
//  Stacks
//
//  Created by Caroline Frey on 9/30/25.
//

import Foundation

struct StravaActivity: Codable {
    var id: Int
    var name: String?
    var distance: Double?
    var movingTime: Int?
    var type: String?
    var startDate: Date?
    var averageHeartrate: Double?
}

struct TokenResponse: Codable {
    let access_token: String
    let refresh_token: String
    let expires_at: Int
}

func refreshAccessToken(refreshToken: String, completion: @escaping (String?, String?, Int?, Error?) -> Void) {
    guard let url = URL(string: "https://www.strava.com/oauth/token") else { return }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"

    let parameters = [
        "client_id": Secrets.clientId,
        "client_secret": Secrets.clientSecret,
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
            Secrets.stravaAccessToken = tokenResponse.access_token
            Secrets.stravaRefreshToken = tokenResponse.refresh_token
            Secrets.stravaExpiresAt = tokenResponse.expires_at
        } catch {
            completion(nil, nil, nil, error)
        }
    }.resume()
}

func fetchActivities(completion: @escaping ([Workout]?, Error?) -> Void) {
    
// ‼️ Use this block to pull current week only
    let afterTimestamp = Date().startOfCurrentWeekEpoch()
    guard let url = URL(string: "https://www.strava.com/api/v3/athlete/activities?&after=\(afterTimestamp)") else {
        return
    }
    
// ‼️ Use this block to pull all workouts
//    guard let url = URL(string: "https://www.strava.com/api/v3/athlete/activities") else { return }

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
                    id: result.id,
                    title: result.name ?? "Untitled Workout",
                    type: WorkoutType(stravaType: result.type ?? "Workout"),
                    date: result.startDate ?? Date(),
                    duration: result.movingTime ?? 0,
                    formattedDuration: formatDurationMetric(result.movingTime ?? 0),
                    averageHeartrate: result.averageHeartrate ?? 0,
                    distance: result.distance,
                    formattedDistance: formatDistanceMetric(fromMeters: result.distance ?? 0)
                )
            }

            completion(workouts, nil)
        } catch {
            completion(nil, error)
            print("Error: \(error.localizedDescription)")
        }
    }.resume()
}

func fetchActivitiesWithAutoRefresh(storedRefreshToken: String, storedAccessToken: String, storedExpiresAt: Int, completion: @escaping ([Workout]?, Error?) -> Void) {
    let currentTime = Int(Date().timeIntervalSince1970)
    if currentTime < storedExpiresAt {
        // Token valid, fetch activities directly
        fetchActivities { workouts, error in
            completion(workouts, error)
        }
    } else {
        // Token expired, refresh first
        refreshAccessToken(refreshToken: storedRefreshToken) { newAccessToken, newRefreshToken, newExpiresAt, error in
            guard let accessToken = newAccessToken, let expiresAt = newExpiresAt, error == nil else {
                completion(nil, error)
                return
            }
            fetchActivitiesWithAccessToken(accessToken: accessToken, completion: completion)
        }
    }
}

func fetchActivitiesWithAccessToken(accessToken: String, completion: @escaping ([Workout]?, Error?) -> Void) {
    
//     ‼️ Use this block to pull current week only
    let afterTimestamp = Date().startOfCurrentWeekEpoch()
    guard let url = URL(string: "https://www.strava.com/api/v3/athlete/activities?&after=\(afterTimestamp)") else {
        return
    }
    
//     ‼️ Use this block to pull all workouts
//    guard let url = URL(string: "https://www.strava.com/api/v3/athlete/activities") else { return }

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

    URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        guard let data, error == nil else { return }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            
            let results = try decoder.decode([StravaActivity].self, from: data)
            
            let workouts = results.map { result in
                Workout(
                    id: result.id,
                    title: result.name ?? "Untitled Workout",
                    type: WorkoutType(stravaType: result.type ?? "Workout"),
                    date: result.startDate ?? Date(),
                    duration: result.movingTime ?? 0,
                    formattedDuration: formatDurationMetric(result.movingTime ?? 0),
                    averageHeartrate: result.averageHeartrate ?? 0,
                    distance: result.distance,
                    formattedDistance: formatDistanceMetric(fromMeters: result.distance ?? 0)
                )
            }

            completion(workouts, nil)
        } catch {
            completion(nil, error)
            print("Error: \(error.localizedDescription)")
        }
    }.resume()
}

func fetchActivityDetails(for workout: Workout, completion: @escaping (WorkoutDetails?, Error?) -> Void) {
    guard let url = URL(string: "https://www.strava.com/api/v3/activities/\(workout.id)") else {
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
            
            let result = try decoder.decode(WorkoutDetails.self, from: data)
            
            let workoutDetails = WorkoutDetails(
                    name: result.name,
                    calories: result.calories,
                    averageHeartrate: result.averageHeartrate,
                    maxHeartrate: result.maxHeartrate
                )
            completion(workoutDetails, nil)
        } catch {
            completion(nil, error)
            print("Error: \(error.localizedDescription)")
        }
    }.resume()
}
