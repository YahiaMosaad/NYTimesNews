//
//  NewsFeedCell.swift
//  NYTimesNews
//
//  Created by Yahia Mosaad on 03/01/2021.
//

import UIKit

class NewsFeedCell: UITableViewCell, newsCellView {
    // MARK: - Outlets
    @IBOutlet weak var newFeedImageView: UIImageView!
    @IBOutlet weak var newFeedTitleLabel: UILabel!
    @IBOutlet weak var newFeedDescriptionLabel: UILabel!
    @IBOutlet weak var newFeeddateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        newFeedImageView.layer.borderWidth = 1
        newFeedImageView.layer.masksToBounds = false
        newFeedImageView.layer.borderColor = UIColor.lightGray.cgColor
        newFeedImageView.layer.cornerRadius = newFeedImageView.frame.height/2
        newFeedImageView.clipsToBounds = true
    }

    func displayTitle(title: String) {
        newFeedTitleLabel.text = title
    }
    func displayDescription(desciption: String) {
        newFeedDescriptionLabel.text = desciption
    }
    func displayDate(date: String) {
        newFeeddateLabel.text = date
    }
    func setNewsImageViewTag(index: Int) {
        newFeedImageView.tag = index
    }
    func displayImage(imageURL: String, indexForRow: Int) {
        newFeedImageView.loadImageFromCache(withUrl: imageURL, cellIndexPathRow: indexForRow)
    }
}
