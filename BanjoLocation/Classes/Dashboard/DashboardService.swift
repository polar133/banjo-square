//
//  DashboardService.swift
//  Pods
//
//  Created by Carlos Jimenez on 9/10/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum DashboardAPI {
    static let venues = "/venues/explore"
}

protocol DashboardServiceLogic: class {
    func fetchLocations(position: String, radius: String, section: String?, callback: @escaping (VenuesResponse?) -> Void)
}

class DashboardService: DashboardServiceLogic {

    private let urlSession = URLSession.shared

    func fetchLocations(position: String, radius: String, section: String?, callback: @escaping (VenuesResponse?) -> Void) {
        let baseURL = "\(BanjoAPI.baseURL)\(DashboardAPI.venues)"

        let params = [
            "client_id": "TEST",
            "client_secret": "TEST",
            "v": Date.getCurrentDate(),
            "ll": position,
            "radius": radius,
            "section": section ?? "topPicks"
        ]

        guard var url = URLComponents(string: baseURL) else {
            callback(nil)
            return
        }
        url.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        url.percentEncodedQuery = url.percentEncodedQuery?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        guard let urlRequest = url.url else {
            callback(nil)
            return
        }

        urlSession.dataTask(with: urlRequest, completionHandler: { data, response, _ in
            if let data = data, let response = response as? HTTPURLResponse, (200..<299).contains(response.statusCode) {
                do {
                    let values = try JSONDecoder().decode(VenuesResponse.self, from: data)
                    callback(values)
                } catch {
                    callback(nil)
                }
            } else {
                callback(nil)
            }
        }).resume()
    }
}
