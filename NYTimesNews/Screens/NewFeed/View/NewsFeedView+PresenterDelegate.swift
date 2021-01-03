//
//  NewsFeedView+PresenterDelegate.swift
//  NYTimesNews
//
//  Created by Yahia Mosaad on 03/01/2021.
//

import Foundation

extension NewsFeedView: NewsView, Popupable, Loadable {
    func showRetryButton() {
        retryButton.isHidden = false
    }
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
    }
    func showErrorView(message: String) {
        newsTableView.isHidden = true
        errorView.isHidden = false
        retryButton.isHidden = false
        errorLabel.text = message
    }
    func navigateToNewsDetailsScreen(newsFeed: NewsFeedDataModal) {
        let newsDetailsView = assembleNewsDetails(newsFeed: newsFeed)
        self.navigationController?.pushViewController(newsDetailsView, animated: true)
    }
    func assembleNewsDetails(newsFeed: NewsFeedDataModal) -> NewsFeedDetailsView {
        let view: NewsFeedDetailsView = (self.storyboard?.instantiateViewController(
                                            withIdentifier: ViewsIdentifiers.newsDetailsViewIdentifier)
                                            as? NewsFeedDetailsView)!
        let presenter = NewsFeedDetailsPresenter(view: view)

        presenter.newsFeedInfo = newsFeed
        view.presenter = presenter
        return view
    }
}
