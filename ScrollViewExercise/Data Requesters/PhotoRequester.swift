//
//  LargeSizePhotoRequester.swift
//  ScrollViewExercise
//
//  Created by Prateek Sharma on 5/28/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import Foundation


struct PhotosRequester {
    static func requestData(completionHandler: @escaping ([PhotoModel]? , Error?) -> Void) {
        GraphPaths.Photos.get(fields: "id,images{source}").start { (connection, result, error) in
            if error != nil {
                completionHandler(nil, error!)
            } else {
                do {
                    let photos = try fetchData(from: result)
                    completionHandler(photos,nil)
                } catch {
                    completionHandler(nil,error)
                }
            }
        }
    }
}

extension PhotosRequester: GraphAPIResponseValidation {
    typealias ResponseType = Any?
    typealias ReturnedResponseType = [PhotoModel]
    
    static func parse(response: ResponseType) throws -> ReturnedResponseType {
        guard let resultData = (response as! [String:Any])["data"] as? [Any]  else {
            throw GraphAPIError.request(error: StringLiterals.RequestedDataNotFound)
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
