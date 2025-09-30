//
//  StravaService.swift
//  Stacks
//
//  Created by Caroline Frey on 9/30/25.
//

import Foundation

class StravaService {
    private var clientId: String
    private var clientSecret: String
    
    init() {
        guard let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let dict = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any],
              let id = dict["ClientId"] as? String,
              let secret = dict["ClientSecret"] as? String
        else {
            fatalError("Missing or invalid Secrets.plist")
        }
        
        self.clientId = id
        self.clientSecret = secret
    }
    
    struct Activity: Decodable {
        let id: Int
        let name: String
        let distance: Double
        let movingTime: Int
        let type: String
        
        private enum CodingKeys: String, CodingKey {
            case id, name, distance
            case movingTime = "moving_time"
            case type
        }
    }
    
    struct TokenResponse: Decodable {
        let access_token: String
        let refresh_token: String
        let expires_at: Int
    }
    
    func refreshAccessToken(refreshToken: String) async throws -> String {
        guard let url = URL(string: "https://www.strava.com/oauth/token") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let bodyParams = [
            "client_id": clientId,
            "client_secret": clientSecret,
            "grant_type": "refresh_token",
            "refresh_token": refreshToken
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: bodyParams)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
        return tokenResponse.access_token
    }
    
    func fetchActivities(accessToken: String) async throws -> [Activity] {
        guard let url = URL(string: "https://www.strava.com/api/v3/athlete/activities") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        let activities = try JSONDecoder().decode([Activity].self, from: data)
        return activities
    }
}
