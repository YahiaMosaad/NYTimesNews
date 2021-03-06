//
//  NewsFeedView.swift
//  NYTimesNews
//
//  Created by Yahia Mosaad on 03/01/2021.
//

import UIKit
protocol NewsFeedLogic: class {
  func displayFetchedData(viewModelArray: [NewsFeedDataModal])
}
class NewsFeedView: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!

    // MARK: - Instances
    var presenter: NewsFeedPresenter!
    override func viewDidLoad() {
       setup()
    }
    private func setup() {
        super.viewDidLoad()
        presenter = NewsFeedPresenter(view: self)
        presenter.viewController = self
        presenter.viewDidLoad()
        errorView.isHidden = true
        setupTableView()
    }
    func setupTableView() {
        self.retryButton.isHidden = true
        self.newsTableView.isHidden = true
        newsTableView.dataSource = self
        newsTableView.delegate = self
    }
    @IBAction func retryBtnTapped(sender: UIButton) {
        setup()
    }
}
extension NewsFeedView: NewsFeedLogic {
    // MARK: - Fetch NewsFeedData
    func displayFetchedData(viewModelArray: [NewsFeedDataModal]) {
        guard newsTableView == nil else {
            newsTableView.isHidden = false
            newsTableView.reloadData()
            return
        }
    }
}

extension NewsFeedView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifiers.newsFeedTableViewCellIdentifier,
                                                 for: indexPath) as? NewsFeedCell
        presenter.configure(cell: cell!, for: indexPath.row)
        return cell!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNewssCount()
    }
}
extension NewsFeedView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //            let newsFeedInfo = newsFeedsData[indexPath.row]
        presenter.didSelectRow(index: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190.0
    }
}
