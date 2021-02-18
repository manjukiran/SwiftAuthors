//
//  Constants.swift
//  SwiftAuthors
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//

import Foundation

enum Constants {
    
    /// Theme Color
    static let themeColorHex = "F5732A"

    /// Color to indicate that UI element is tappable
    static let actionItemColor = "0080AF" // Inverse of themeColorHex ^^

    /// URL String For Fetching JSON Data
    static let baseURL = "https://api.github.com/repositories/44838949/commits?per_page=100&sha=f45309246584ebdbc0cd6f4960c3f2103ff76a76"
    
    // MARK: - Format Constants
    public enum Formats: String {
        case serverDate = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case displayDate = "dd-MM-yyyy"
    }


}

// MARK: - URL Constants

/// Individual Endpoints for each URL
enum APIEndpoint : String {
    
    private static let pagingCount = "100"
    private static let sha = "f45309246584ebdbc0cd6f4960c3f2103ff76a76"
    
    case commitList = "commits"
    
    /// Returns the full URL for the requested endpoint
    func urlString() -> String? {
        return self.urlComponents()?.string
    }
    
    private func path() -> String {
        return self.rawValue
    }
    
    private func urlComponents() -> URLComponents? {
        guard var urlComponent = URLComponents(string: Constants.baseURL + path()) else { return nil }
        var queryItems: [URLQueryItem] = [URLQueryItem]()
        switch self {
        case .commitList:
            queryItems.append(URLQueryItem(name: "per_page", value: APIEndpoint.pagingCount))
            queryItems.append(URLQueryItem(name: "sha", value: APIEndpoint.sha))
        }
        urlComponent.queryItems = queryItems
        return urlComponent
    }
    
    
    
}

// MARK: - Error Constants

/// String ENUMs to help guage the error code based on server response
enum DownloadError: String, Error {
    case badData = "Data is invalid"
    case redirectionError  = "Server Redirection error"
    case clientError = "Client not responding as expected"
    case serverError = "Server Error"
    case invalidRequest = "Request is invalid"
    case unknownError = "Unknown Error"
}

enum ImageError: String, Error {
    case invalidRequest = "Request is invalid"
    case badImageData = "Image Data is invalid"
}

/// Intervals
public enum Intervals : TimeInterval {
    case networkTimeoutInterval  = 30.0
    case imageCacheValidity = 86400.0 /// Image Cache validity - 24 hrs
}

/// Utility to get debug mode to crash the app whilst production apps function with a log.
/// We could instead change the non-debug macro to log data into a logger that can upload information for us instead.
#if DEBUG
func debugLog(_ string: String) {
    fatalError(string)
}
#else
func debugLog(_ string: String) {
    print(string)
}
#endif
