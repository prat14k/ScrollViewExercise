//
//  ResponseValidator.swift
//  ScrollViewExercise
//
//  Created by Prateek Sharma on 5/28/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import Foundation
import FacebookCore


enum GraphAPIError: Error {
    case request(error: Any)
    case response(code: Int, message: String, traceID: String, type: String)
}


protocol Parser {
    associatedtype ResponseType
    associatedtype ReturnedResponseType
    
    static func parse(response: ResponseType) throws -> ReturnedResponseType
}


protocol Validator {
    associatedtype ResponseType
    
    static func validate(response: ResponseType) throws
}

protocol ResponseRequester: Validator, Parser {
    static func fetchData(from response: ResponseType) throws -> ReturnedResponseType
}


protocol GraphAPIResponseRequester: ResponseRequester { }

extension GraphAPIResponseRequester {
    
    static private var mainDataKey: String { return "data" }
    
    static func fetchData(from response: ResponseType) throws -> ReturnedResponseType {
        try validate(response: response)
        return try parse(response: response)
    }
    
    static func validate(response: ResponseType) throws {
        guard let response = response as? [String:Any]  else { throw GraphAPIError.request(error: StringLiterals.wrongResponseFormat) }
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



//    static func parse<T>(response: ResponseType) throws -> [T] {
//        guard let resultData = (response as! [String:Any])[mainDataKey] as? [Any]  else {
//            throw GraphAPIError.request(error: StringLiterals.requestedDataNotFound)
//        }
//        var data = [T]()
//        for case let dict as [String:Any] in resultData {
//            guard let photoID = dict["id"] as? String,
//                let mainImageInfo = (dict["images"] as? [Any])?.first as? [String:String],
//                let imageURL = mainImageInfo["source"]
//                else { continue }
//            photos.append(PhotoModel(id: photoID, urlString: imageURL))
//        }
//        return photos
//    }

