//
//  PhotoSlidingViewController.swift
//  ScrollViewExercise
//
//  Created by Prateek Sharma on 5/25/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class PhotoSlidingViewController: UIViewController {
    
    var userPhotos = [PhotoModel]()
    @IBOutlet weak private var photosBrowserCollectionView: UICollectionView!
    
}

extension PhotoSlidingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUserPhotosList()
    }
    
    func fetchUserPhotosList()
    {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] () -> () in
            PhotosRequester.requestData { (photos, error) in
                if error != nil {
                    // error processing
                    print(error!)
                } else if let photos = photos {
                    self?.userPhotos = photos
                    DispatchQueue.main.async {
                        self?.photosBrowserCollectionView.reloadData()
                    }
                }
            }
        }        
    }
    
}




extension PhotoSlidingViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        photoCell.setup(imageURL: ImageAssets.DefaultPhoto)
        return photoCell
    }
    
}

extension PhotoSlidingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: photosBrowserCollectionView.frame.width, height: photosBrowserCollectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
}


