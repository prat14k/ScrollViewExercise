//
//  RequestProtocols.swift
//  ScrollViewExercise
//
//  Created by Prateek Sharma on 5/28/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import Foundation
import FBSDKCoreKit


protocol URLProtocol {
    static var route: String { get }
}


protocol FBGetProtocol: URLProtocol {
    static var basicFields: String { get }
}
extension FBGetProtocol {
    static func get(fields: String = basicFields) -> FBSDKGraphRequest {
        return FBSDKGraphRequest(graphPath: route, parameters: [StringLiterals.GraphRequestRequiredField: fields])
    }
}
