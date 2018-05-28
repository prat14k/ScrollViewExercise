//
//  PhotoCollectionViewCell.swift
//  ScrollViewExercise
//
//  Created by Prateek Sharma on 5/25/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit
import AlamofireImage
import SVProgressHUD

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "photoIdentifier"
    
    private let zoomScaleDifference: CGFloat = 1.5
    private var minimumScale: CGFloat!
    private var photo: PhotoModel!
    
//    private var isImageLoading = false
    
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var photoImageView: UIImageView!
    @IBOutlet weak private var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak private var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak private var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak private var imageViewTrailingConstraint: NSLayoutConstraint!
    
}

extension PhotoCollectionViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateMinZoomScaleForSize(bounds.size)
    }
    func setup(photo: PhotoModel) {
        self.photo = photo
        if let photoURL = URL(string: photo.urlString) {
//            isImageLoading = true
            SVProgressHUD.show(withStatus: "Loading")
            photoImageView.af_setImage(withURL: photoURL, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: true) { [weak self] (response) in
                if let ref = self {
//                    ref.isImageLoading = false
                    ref.updateConstraintsForSize(ref.bounds.size)
                    ref.updateMinZoomScaleForSize(ref.bounds.size)
                }
                SVProgressHUD.dismiss()
            }
        }
    }
    
}

extension PhotoCollectionViewCell {
    
    private func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / photoImageView.bounds.width
        let heightScale = size.height / photoImageView.bounds.height
        minimumScale = min(widthScale, heightScale)
        scrollView.minimumZoomScale = minimumScale
        scrollView.maximumZoomScale = (minimumScale + zoomScaleDifference)
        scrollView.zoomScale = minimumScale
        scrollView.contentSize = scrollView.bounds.size
        layoutIfNeeded()
    }
    private func updateConstraintsForSize(_ size: CGSize) {
        let yOffset = max(0, (size.height - photoImageView.frame.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        let xOffset = max(0, (size.width - photoImageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        layoutIfNeeded()
    }

}

extension PhotoCollectionViewCell: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(bounds.size)
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if scale == minimumScale {
            scrollView.contentSize = scrollView.bounds.size
        }
    }
    
}
