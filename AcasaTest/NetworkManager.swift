//
//  NetworkManager.swift
//  AcasaTest
//
//  Created by Natuka on 27/01/2018.
//  Copyright © 2018 Natalia. All rights reserved.
//

import Foundation
import Alamofire

typealias NetworkSuccessBlock = (Any) -> (Void)
typealias NetworkErrorBlock = (Error) -> (Void)

class NetworkManager {
    
    func getJSON(with url: String,
                 success: @escaping NetworkSuccessBlock,
                 failure: @escaping NetworkErrorBlock) {
        
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
