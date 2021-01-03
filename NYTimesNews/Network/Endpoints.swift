//
//  Endpoints.swift
//  NYTimesNews
//
//  Created by Yahia Mosaad on 04/01/2021.
//

import Foundation
enum Endpoints {
    case mostviewed
    case mostviewedAllSections
     var name: String {
        switch self {
        case .mostviewed:
            return "mostviewed/"
        case .mostviewedAllSections:
            return "mostviewed/all-sections/"
        }
    }
    var url: String {
        switch self {
        case .mostviewed:
            return APIURLConstants.NYTimesAPIBaseURL + name
        case .mostviewedAllSections:
            return APIURLConstants.NYTimesAPIBaseURL + name
        }
    }
}
