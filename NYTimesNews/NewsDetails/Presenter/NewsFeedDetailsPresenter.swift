//
//  NewsFeedDetailsPresenter.swift
//  NYTimesNews
//
//  Created by Yahia Mosaad on 03/01/2021.
//

import Foundation

protocol NewsDetailsView: class {
    func showIndicator()
    func hideIndicator()
    func showNewsImageFrom(imageURL: String)
    func showNewsTitle(title: String)
    func showNewsDetails(newsDetails: String)
}

class NewsFeedDetailsPresenter {
    private weak var view: NewsDetailsView?
    var newsFeedInfo: NewsFeedDataModal?
    init(view: NewsDetailsView) {
        self.view = view
    }
    func viewDidLoad() {
        guard newsFeedInfo != nil else {
            return
        }
        view?.showNewsTitle(title: newsFeedInfo!.title)
        view?.showNewsDetails(newsDetails: newsFeedInfo!.abstract)
        if let jumboImageURL = newsFeedInfo!.jumboImageURL {
            view?.showNewsImageFrom(imageURL: jumboImageURL)
        }
    }
}
