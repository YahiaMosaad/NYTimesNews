//
//  NYTimesNewsTests.swift
//  NYTimesNewsTests
//
//  Created by Yahia Mosaad on 03/01/2021.
//

import XCTest
@testable import NYTimesNews

class NYTimesNewsTests: XCTestCase {
    var testingSession: URLSession!
    var sut: NewsFeedView!

    override func setUp() {
        testingSession = URLSession(configuration: URLSessionConfiguration.default)
        setupNewsFeedViewController()
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        testingSession = nil
    }
    func setupNewsFeedViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(
            withIdentifier: "NewsFeedView") as?
            NewsFeedView
        sut.loadView()
        sut.viewDidLoad()
    }
    func testDataTask() {
        // Moking the full url with correct key
        let baseURL = "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/"
        let url = URL(string: "\(baseURL)7.json?api-key=xkNY5aV5vNaAC3bWJ9vrBLfGrkpfHpEF")
        // 1
        let promise = expectation(description: "Status code: 200")
        // when
        let dataTask = testingSession.dataTask(with: url!) { _, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        waitForExpectations(timeout: 10, handler: nil)
    }
    func testNewsFeedControllerHasTableView() {
        if sut != nil {
            sut.loadViewIfNeeded()
            XCTAssertNotNil(sut.newsTableView,
                            "Controller should have a tableview")
        } else {
            return XCTFail("Could not instantiate ViewController from main storyboard")
        }
    }
    func testTableViewHasDelegate() {
        XCTAssertNotNil(sut.newsTableView.delegate)
    }
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(sut.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:didSelectRowAt:))))
    }
    func testTableViewHasDataSource() {
        XCTAssertNotNil(sut.newsTableView.dataSource)
    }
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(sut.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:cellForRowAt:))))
    }
    func testTableViewCellHasReuseIdentifier() {
        // Given
        let news1 = NewsFeedDataModal(title: "News title1", publishedDate: "2021-01-01",
                                identifier: 3000, abstract: "that was a great news to announce", media: nil)
        let news2 = NewsFeedDataModal(title: "News title2", publishedDate: "2021-01-02",
                                 identifier: 3001, abstract: "that was a great news to announce", media: nil)
        let news3 = NewsFeedDataModal(title: "News title3", publishedDate: "2021-01-03",
                                 identifier: 3002, abstract: "that was a great news to announce 2", media: nil)
        let news4 = NewsFeedDataModal(title: "News title4", publishedDate: "2021-01-03",
                                 identifier: 3003, abstract: "that was a great news to announce 3", media: nil)
        let news5 = NewsFeedDataModal(title: "News title5", publishedDate: "2021-01-04",
                                 identifier: 3004, abstract: "that was a great news to announce 4", media: nil)
        sut.presenter.newsArray = [news1, news2, news3, news4, news5]
        // When
        let cell = sut.tableView(sut.newsTableView,
                                 cellForRowAt: IndexPath(row: 0, section: 0)) as? NewsFeedCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "NewsFeedCellID"
        // Then
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
    func testShouldDisplayFetchedCitiesWeather() {
        // Given
        let tableViewSpy = TableViewSpy()
        sut.newsTableView = tableViewSpy
        // When
        let news1 = NewsFeedDataModal(title: "News title1", publishedDate: "2021-01-03",
                                     identifier: 3000, abstract: "that was a great news to announce", media: nil)
        let news2 = NewsFeedDataModal(title: "News title2", publishedDate: "2021-01-02",
                                 identifier: 3001, abstract: "that was a great news to announce", media: nil)
        sut.displayFetchedData(viewModelArray: [news1, news2])
        XCTAssert(tableViewSpy.reloadDataCalled, "Displaying fetched weather should reload the table view")
    }
}

class TableViewSpy: UITableView {
  // MARK: Method call expectations
  var reloadDataCalled = false
  // MARK: Spied methods
  override func reloadData() {
    reloadDataCalled = true
  }
}
