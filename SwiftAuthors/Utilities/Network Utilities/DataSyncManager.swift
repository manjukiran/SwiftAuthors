//
//  DataSyncManager.swift
//  SwiftAuthors
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//

import UIKit


/// Generic Data Fetch Completion block with expectations from classes to inject the Class of the data to be decoded
typealias genericDataFetchHandler<T:Codable>  = (Result<T, DownloadError>) -> Void

/**
 Main API Data retrieval utility that is used by all Models/View models to retrieve data and decode (into Codables)
 
 - important: This is a generic utility that depends on the referring class to pass in the the type of codable to de-code
 - This is class is injected with a <URLDataFetching> object to aid in testing
 
 Whilst being light weight, it depends on the NetworkDataUtility class to fetch data via URLSession
 */

class DataSyncManager {
    
    private let networkDataUtility: URLDataFetching
    required init(networkDataUtility: URLDataFetching){
        self.networkDataUtility  = networkDataUtility
    }
    
    /// Primary function of the class - Uses the NetworkDataUtility class to retrieve data and decodes into a native iOS object
    ///
    /// - Parameters:
    ///   - urlString: URL of the API endpoint to hit
    ///   - completion: Completion block that is injected;
    /// - Expectation :
    ///   Completion block expects the Data type of the class to be decoded ; this class MUST conform to CODABLE protocols
    ///   This is a SWIFT 5 result block that provides the result (success/failure) along with response (data/error)
    public func retrieveData<T: Codable>(urlString: String , completion: @escaping genericDataFetchHandler<T>)  {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidRequest))
            return
        }
        self.networkDataUtility.fetchDataWithURL(url: url) { (result) in
            switch result {
            case .success (let data) :
                completion(self.decode(data: data, type: T.self))
            case .failure (let error) :
                completion(.failure(error))
            }
        }
    }
    
    
    /// Uses the NetworkDataUtility class to retrieve image data and creates a UIImage object
    /// - Parameters:
    ///   - urlString: URL of the image to be retrieved
    ///   - completion: Completion block that is injected;
    /// - Expectation :
    ///   This is a SWIFT 5 result block that provides the result (success/failure) along with response (image/error)
    public func retrieveImageData(urlString: String , completion: @escaping imageHandler)  {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidRequest))
            return
        }
        self.networkDataUtility.fetchImageDataWithUrl(url: url) { result in
            completion(result)
        }
    }
    
    
    /// Used to decode the data retrieved from the API into the data object
    ///
    /// - Parameters:
    ///   - data: data retrieved from the API
    ///   - type: Class of the data to be decoded into
    /// - Returns: Swift 5 Result type -> either a (Success+DecodedData) //OR// (Failure+Error) tuple
    private func decode<T: Codable>(data: Data, type: T.Type) -> Result<T,DownloadError> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)

        do {
            let decodedObject = try jsonDecoder.decode(T.self, from: data)
            return(.success(decodedObject))
        } catch let error {
            print (error.localizedDescription)
            return(.failure(.badData))
        }
    }
}
