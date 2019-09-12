//
//  BanjoAPI.swift
//  BanjoLocation
//
//  Created by Carlos Jimenez on 9/10/19.
//

import Foundation

enum BanjoAPI {
    static let baseURL = "https://api.foursquare.com/v2"
}

enum APITokens {

    fileprivate static var baseConfigurationDictionary: [String: Any] {
        let bundle = Bundle.main
        guard let resourcePath = bundle.url(forResource: "tokens", withExtension: "plist"), let data = try? Data(contentsOf: resourcePath) else {
            return [:]
        }
        do {
            return try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] ?? [:]
        } catch {
            return [:]
        }
    }

    fileprivate static func configurationValueForKeyAndSubKey(key: String, subKey: String, baseConfigurationDictionary: [String: Any]) -> String {
        return baseConfigurationDictionary[key] as? String ?? ""
    }

    static var ClientID: String {
        return configurationValueForKeyAndSubKey(key: "client_id", subKey: "", baseConfigurationDictionary: baseConfigurationDictionary)
    }

    static var ClientSecret: String {
        return configurationValueForKeyAndSubKey(key: "client_secret", subKey: "", baseConfigurationDictionary: baseConfigurationDictionary)
    }
}
