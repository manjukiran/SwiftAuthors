//
//  NetworkMockUtility.swift
//  SwiftAuthors Tests
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//

import Foundation
import UIKit
@testable import SwiftAuthors

enum NetworkMockUtility {
    
    struct SuccessfulNetworkFetch : URLDataFetching {
        let data: Data
        
        func fetchDataWithURL(url: URL, completionHandler: @escaping dataHandler) {
            completionHandler(.success(data))
        }
        
        func fetchImageDataWithUrl(url: URL, completionHandler: @escaping imageHandler) {
            if let image = UIImage(data: data){
                completionHandler(.success(image))
            }
        }
    }
    
    struct FailedNetworkFetch : URLDataFetching {
        
        func fetchDataWithURL(url: URL, completionHandler: @escaping dataHandler) {
            completionHandler(.failure(DownloadError.serverError))
        }
        func fetchImageDataWithUrl(url: URL, completionHandler: @escaping imageHandler) {
            completionHandler(.failure(ImageError.badImageData))
        }
    }    
}





