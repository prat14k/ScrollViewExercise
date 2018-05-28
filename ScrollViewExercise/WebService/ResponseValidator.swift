//
//  ResponseValidator.swift
//  ScrollViewExercise
//
//  Created by Prateek Sharma on 5/28/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import Foundation
import FBSDKCoreKit


enum GraphAPIError: Error {
    case request(error: Any)
    case response(code: Int, message: String, traceID: String, type: String)
}


protocol ResponseValidation {
    associatedtype ResponseType
    associatedtype ReturnedResponseType
    
    static func validate(response: ResponseType) throws
    static func fetchData(from response: ResponseType) throws -> ReturnedResponseType
    static func parse(response: ResponseType) throws -> ReturnedResponseType
}


protocol GraphAPIResponseValidation: ResponseValidation { }

extension GraphAPIResponseValidation {
    
    static func fetchData(from response: ResponseType) throws -> ReturnedResponseType {
        try validate(response: response)
        return try parse(response: response)
    }
    static func validate(response: ResponseType) throws {
        guard let response = response as? [String:Any]  else { throw GraphAPIError.request(error: StringLiterals.WrongResponseFormat) }
        if let error = response["error"] as? [String:Any] {
            guard let code = error["code"] as? Int,
                let message = error["message"] as? String,
                let traceID = error["fbtrace_id"] as? String,
                let type = error["type"] as? String
                else { throw GraphAPIError.request(error: error) }
            throw GraphAPIError.response(code: code, message: message, traceID: traceID, type: type)
        }
    }
    
}
