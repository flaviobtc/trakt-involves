//
//  URLRequest+Additions.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation

enum URLRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

extension URLRequest {
    
    static let contentType = "Content-Type"
    static let jsonHeader = "application/json"
    static let traktApiKey = "trakt-api-key"
    static let traktApiVersion = "trakt-api-version"
    static let authorization = "Authorization"
    static let tokenHeader = "Bearer \(AuthenticationManager.accessToken ?? "")"
    
    static func getURLRequest(with url: URL, body: [String: Any]? = nil, andMethod method: URLRequestMethod) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(jsonHeader, forHTTPHeaderField: contentType)
        urlRequest.setValue(API.clientId, forHTTPHeaderField: traktApiKey)
        urlRequest.setValue("2", forHTTPHeaderField: traktApiVersion)
        if AuthenticationManager.accessToken != nil {
            urlRequest.setValue(tokenHeader, forHTTPHeaderField: authorization)
        }
        if let httpBody = body {
            urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: httpBody)
        }
        return urlRequest
    }
    
    static let imageApiKey = "api-key"
    
    static func getImageURLRequest(with url: URL, body: [String: Any]? = nil, andMethod method: URLRequestMethod) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(jsonHeader, forHTTPHeaderField: contentType)
        urlRequest.setValue(ImageSourceAPI.apiKey, forHTTPHeaderField: imageApiKey)

        if let httpBody = body {
            urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: httpBody)
        }
        return urlRequest
    }
}
