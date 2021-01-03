//
//  NewsFeedInteractor.swift
//  NYTimesNews
//
//  Created by Yahia Mosaad on 03/01/2021.
//

import Foundation
struct NYTimesViewMostFeedsRequest: APIRequest {
    var paramters: [String: Any]?
    var baseURL: String = APIURLConstants.NYTimesAPIBaseURL
    var method: RestMethod = .get
    var endPointName = Endpoints.mostviewedAllSections.name
    init(withParamters paramters: [String: Any]?) {
        self.paramters = paramters
    }
}
class NewsFeedInteractor: NetworkLayer {
    func fetchNewFeed(period: NewsPeriod,
                      success: (([NewsFeedDataModal]?) -> Void)?,
                      failure: ((NetworkError) -> Void)? ) {
        let newsFeedRequest: NYTimesViewMostFeedsRequest = NYTimesViewMostFeedsRequest(withParamters:
                                    [period.rawValue + APIParametersKey.json.key: ""])
        execute(request: newsFeedRequest, withModel: NewsFeedModal.self, success: { (result) in
            success!(result.results)
        }, failure: { (error) in
            failure!(error)
        })
    }
}
