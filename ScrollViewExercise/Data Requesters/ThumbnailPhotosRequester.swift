//
//  PhotosRequester.swift
//  ScrollViewExercise
//
//  Created by Prateek Sharma on 5/28/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import Foundation
import FBSDKCoreKit


struct ThumbnailPhotosRequester {
    
    static func requestData(completionHandler: @escaping ([PhotoModel]? , Error?) -> Void) {
        GraphPaths.Photos.get().start { (connection, result, error) in
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

extension ThumbnailPhotosRequester: GraphAPIResponseValidation {
    
    typealias ResponseType = Any?
    typealias ReturnedResponseType = [PhotoModel]
    
    static func parse(response: ResponseType) throws -> ReturnedResponseType {
        guard let resultData = (response as! [String:Any])["data"] as? [Any]
        else {
            throw GraphAPIError.request(error: StringLiterals.RequestedDataNotFound)
        }
        var photos = [PhotoModel]()
        for case let dict as [String:String] in resultData {
            guard let photoID = dict["id"] , let photoURL = dict["picture"] else { continue }
            photos.append(PhotoModel(id: photoID, urlString: photoURL))
        }
        return photos
    }
}




