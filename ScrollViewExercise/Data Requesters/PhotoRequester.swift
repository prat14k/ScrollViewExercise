//
//  LargeSizePhotoRequester.swift
//  ScrollViewExercise
//
//  Created by Prateek Sharma on 5/28/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import Foundation
import FacebookCore

struct PhotosRequester {
    static func requestData(completionHandler: @escaping ([PhotoModel]? , Error?) -> Void) {
        GraphPaths.Photos.get().start { (response, result) in
            switch result {
            case .failed(let error):
                completionHandler(nil, error)
            case .success(let response):
                do {
                    let photos = try fetchData(from: response.dictionaryValue)
                    completionHandler(photos,nil)
                } catch {
                    completionHandler(nil,error)
                }
            }
        }
    }
}
            

extension PhotosRequester: GraphAPIResponseRequester {
    typealias ResponseType = Any?
    typealias ReturnedResponseType = [PhotoModel]
    
    static func parse(response: ResponseType) throws -> ReturnedResponseType {
        guard let resultData = (response as! [String:Any])["data"] as? [Any]  else {
            throw GraphAPIError.request(error: StringLiterals.requestedDataNotFound)
        }
        var photos = [PhotoModel]()
        for case let dict as [String:Any] in resultData {
            guard let photoID = dict["id"] as? String,
                let mainImageInfo = (dict["images"] as? [Any])?.first as? [String:String],
                let imageURL = mainImageInfo["source"]
                else { continue }
            photos.append(PhotoModel(id: photoID, urlString: imageURL))
        }
        return photos
    }
}
