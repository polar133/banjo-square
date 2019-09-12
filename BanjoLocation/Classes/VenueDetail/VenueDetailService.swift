//
//  VenueDetailService.swift
//  Pods
//
//  Created by Carlos Jimenez on 9/11/19.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum VenueDetailAPI {
    static let venue = "/venues/"
}

protocol VenueDetailServiceLogic: class {
    func fetchVenue(id: String, callback: @escaping (VenueDetailResponse?) -> Void)
}

class VenueDetailService: VenueDetailServiceLogic {

    private let urlSession = URLSession.shared

    func fetchVenue(id: String, callback: @escaping (VenueDetailResponse?) -> Void) {
        let baseURL = "\(BanjoAPI.baseURL)\(VenueDetailAPI.venue)\(id)"

        let params = [
            "client_id": APITokens.ClientID,
            "client_secret": APITokens.ClientSecret,
            "v": Date.getCurrentDate()
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
                    let values = try JSONDecoder().decode(VenueDetailResponse.self, from: data)
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
