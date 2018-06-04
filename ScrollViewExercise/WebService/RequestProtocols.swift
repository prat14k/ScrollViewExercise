//
//  RequestProtocols.swift
//  ScrollViewExercise
//
//  Created by Prateek Sharma on 5/28/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import Foundation
import FacebookCore


protocol URLProtocol {
    static var route: String { get }
}


protocol FBGetProtocol: URLProtocol {
    static var basicFields: String { get }
}
extension FBGetProtocol {
    static func get(fields: String = basicFields) -> GraphRequest {
        return GraphRequest(graphPath: route, parameters: [StringLiterals.graphRequestRequiredField: fields])
    }
}
