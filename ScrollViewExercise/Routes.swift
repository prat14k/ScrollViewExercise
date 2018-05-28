//
//  Routes.swift
//  ScrollViewExercise
//
//  Created by Prateek Sharma on 5/28/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import Foundation


struct GraphPaths {
    public struct Photos: FBGetProtocol {
        static var basicFields: String { return "id,picture" }
        static var route: String { return "me/photos" }
    }
}
