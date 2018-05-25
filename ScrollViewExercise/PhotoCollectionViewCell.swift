//
//  PhotoCollectionViewCell.swift
//  ScrollViewExercise
//
//  Created by Prateek Sharma on 5/25/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "photoIdentifier"
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoImageView: UIImageView!
    
}

extension PhotoCollectionViewCell {
    
    func setup(imageURL: String) {
        
        photoImageView.image = UIImage(named: imageURL)
        
    }
    
}
