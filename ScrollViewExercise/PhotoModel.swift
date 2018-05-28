//
//  PhotoModel.swift
//  ScrollViewExercise
//
//  Created by Prateek Sharma on 5/27/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import Foundation

struct PhotoModel {
    let id: String
    let urlString: String
    
    init(id: String, urlString: String) {
        self.id = id
        self.urlString = urlString
    }

}
