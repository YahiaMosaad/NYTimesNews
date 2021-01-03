//
//  NewsFeedPresenter.swift
//  NYTimesNews
//
//  Created by Yahia Mosaad on 03/01/2021.
//
import Foundation

protocol NewsView: class {
    func showIndicator()
    func hideIndicator()
    func fetchingDataSuccess()
    func showError(error: String)
    func showErrorView(message: String)
    func showRetryButton()
    func navigateToNewsDetailsScreen(newsFeed: NewsFeedDataModal)
}
protocol newsCellView {
    func displayTitle(title: String)
    func displayDescription(desciption: String)
    func displayDate(date: String)
    func displayImage(imageURL: String, indexForRow: Int)
    func setNewsImageViewTag(index: Int)
}
class NewsFeedPresenter {
    private weak var view: NewsView?
    weak var viewController: NewsFeedLogic?

    private let interactor = NewsFeedInteractor()
     var newsArray = [NewsFeedDataModal]()
    init(view: NewsView) {
        self.view = view
    }
    func viewDidLoad() {
        getMostViewedNews()
    }
    func getMostViewedNews() {
        view?.showIndicator()
        interactor.fetchNewFeed(period: .week) { (news) in
            guard let newsFeed = news else { return }
            self.view?.hideIndicator()
            self.newsArray = newsFeed
            self.viewController?.displayFetchedData(viewModelArray: newsFeed)

        } failure: { (error) in
            self.view?.hideIndicator()
            switch error {
            case .noInternetConnection:
                self.view?.showRetryButton()
                self.view?.showErrorView(message: StringConstants.noInternetMessage)
            case .parsingError:
                self.view?.showError(error: error.localizedDescription)
            case .unexpectedError:
                self.view?.showError(error: error.localizedDescription)
            case .invaildURL:
                self.view?.showErrorView(message: StringConstants.noDataMessage)
            case .badRequest:
                self.view?.showErrorView(message: error.localizedDescription)
            case .noDataFound:
                self.view?.showErrorView(message: StringConstants.noDataMessage)            }
        }

    }
    func getNewssCount() -> Int {
        return newsArray.count
    }
    func configure(cell: newsCellView, for index: Int) {
        let newFeed = newsArray[index]
        cell.displayTitle(title: newFeed.title)
        cell.displayDescription(desciption: newFeed.abstract)
        cell.displayDate(date: newFeed.publishedDate)
        cell.setNewsImageViewTag(index: index)
        if let thumnailURL = newFeed.standradThumbnailURL {
            cell.displayImage(imageURL: thumnailURL, indexForRow: index)
        } else {
        }
    }
    func didSelectRow(index: Int) {
         let newFeed = newsArray[index]
        view?.navigateToNewsDetailsScreen(newsFeed: newFeed)
    }
}
