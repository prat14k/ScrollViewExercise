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
    
    private let maximumZoomScale: CGFloat = 2.0
    private var photoName: String?
    private var image: UIImage!
    
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
        image = UIImage(named: ImageAssets.DefaultPhoto)
        photoImageView.image = image
    }
    
}

extension PhotoCollectionViewCell {
    
    private func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / photoImageView.bounds.width
        let heightScale = size.height / photoImageView.bounds.height
        let minScale = min(widthScale, heightScale)
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = maximumZoomScale
        scrollView.zoomScale = minScale
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
    
}
