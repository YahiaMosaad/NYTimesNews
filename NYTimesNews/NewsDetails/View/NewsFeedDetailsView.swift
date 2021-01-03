//
//  NewsFeedDetailsViewViewController.swift
//  NYTimesNews
//
//  Created by Yahia Mosaad on 03/01/2021.
//

import UIKit
class NewsFeedDetailsView: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var newFeedImageView: UIImageView!
    @IBOutlet weak var newFeedTitleLabel: UILabel!
    @IBOutlet weak var newFeedDetailsTextView: UITextView!
    // MARK: Instance
    var presenter: NewsFeedDetailsPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension NewsFeedDetailsView: NewsDetailsView {
    func showIndicator() {
    }
    func hideIndicator() {
    }
    func showNewsImageFrom(imageURL: String) {
        newFeedImageView.loadImageFromCache(withUrl: imageURL)
    }
    func showNewsTitle(title: String) {
        newFeedTitleLabel.text = title
    }
    func showNewsDetails(newsDetails: String) {
        newFeedDetailsTextView.text = newsDetails
    }
}
