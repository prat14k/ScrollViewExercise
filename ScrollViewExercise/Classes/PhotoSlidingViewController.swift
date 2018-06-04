//
//  PhotoSlidingViewController.swift
//  ScrollViewExercise
//
//  Created by Prateek Sharma on 5/25/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit

class PhotoSlidingViewController: UIViewController {
    
    private var userPhotos = [PhotoModel]()
    @IBOutlet weak private var photosBrowserCollectionView: UICollectionView!
    
}

extension PhotoSlidingViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserPhotosList()
    }
    
    private func fetchUserPhotosList()
    {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] () -> () in
            PhotosRequester.requestData { (photosResponse, error) in
                if error != nil {
                    // error processing
                    print(error!)
                }
                guard let photos = photosResponse, photos.count > 0  else { return }
                self?.updatePhotos(collection: photos)
                DispatchQueue.main.async {
                    self?.photosBrowserCollectionView.reloadData()
                    self?.photosBrowserCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .left, animated: false)
                }
            }
        }        
    }
    
    private func updatePhotos(collection: [PhotoModel]){
        userPhotos.removeAll()
        userPhotos.append(collection[collection.count - 1])
        userPhotos.append(contentsOf: collection)
        userPhotos.append(collection[0])
    }
    
}


extension PhotoSlidingViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPhotos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        photoCell.setup(photo: userPhotos[indexPath.row % userPhotos.count])
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

extension PhotoSlidingViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard userPhotos.count > 0  else { return }
        let contentOffsetWhenFullyScrolledRight = scrollView.bounds.width * CGFloat(self.userPhotos.count - 1)
        if (scrollView.contentOffset.x == contentOffsetWhenFullyScrolledRight) {
            photosBrowserCollectionView.scrollToItem(at: IndexPath(item:1, section:0), at: .left, animated: false)
        } else if (scrollView.contentOffset.x == 0)  {
            photosBrowserCollectionView.scrollToItem(at: IndexPath(item:(self.userPhotos.count - 2), section:0), at: .left, animated: false)
        }
    }

}








