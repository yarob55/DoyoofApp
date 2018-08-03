//
//  Service.swift
//  Portal World
//
//  Created by يعرب المصطفى on 8/2/18.
//  Copyright © 2018 yarob. All rights reserved.
//

import Foundation
import Alamofire

class Service{
    static func changeStatus(statusType : Int, _ completion: @escaping (Error?)->Void)
    {
        let url = "https://hajjhackathon.herokuapp.com/api/changestatus/1/\(statusType)"
        Alamofire.request(url, method: .put, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result{
            case .failure :
                print("failure")
            case .success:
                completion(nil)
            }
        }
    }
    
    //https://hajjhackathon.herokuapp.com/api/volunteerarrived
    
    static func arrival(_ completion: @escaping (Error?)->Void)
    {
        let url = "https://hajjhackathon.herokuapp.com/api/volunteerarrived"
        Alamofire.request(url, method: .put, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result{
            case .failure :
                print("failure")
            case .success:
                completion(nil)
            }
        }
    }
    
}
