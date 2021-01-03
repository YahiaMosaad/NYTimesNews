//
//  NewsFeedView+PresenterDelegate.swift
//  NYTimesNews
//
//  Created by Yahia Mosaad on 03/01/2021.
//

import Foundation

extension NewsFeedView: NewsView, Popupable, Loadable {
    
    func showIndicator() {
        newsTableView.isHidden = true
        showLoadingIndicator()
    }
    func hideIndicator() {
        if newsTableView != nil {
            newsTableView.isHidden = false
        }
        hideLoadingIndicator()
    }
    func fetchingDataSuccess() {
        newsTableView.reloadData()
    }
    func showError(error: String) {
        print(error)
    }
    func showEmptyView(message: String) {
        newsTableView.isHidden = true
        emptyView.isHidden = false
        emptyViewLabel.text = message
    }
    func navigateToNewsDetailsScreen(newsFeed: NewsFeedDataModal) {
        let newsDetailsView = assembleNewsDetails(newsFeed: newsFeed)
        self.navigationController?.pushViewController(newsDetailsView, animated: true)
    }
    func assembleNewsDetails(newsFeed: NewsFeedDataModal) -> NewsFeedDetailsView {
        let view: NewsFeedDetailsView = (self.storyboard?.instantiateViewController(
            withIdentifier: "newsDetailsView") as? NewsFeedDetailsView)!
        let presenter = NewsFeedDetailsPresenter(view: view)

        presenter.newsFeedInfo = newsFeed
        view.presenter = presenter
        return view
    }
}
