//
//  APIRequest.swift
//  NYTimesNews
//
//  Created by Yahia Mosaad on 03/01/2021.
//

import Foundation
protocol APIRequest {
    var paramters: [String: Any]? {get}
    var baseURL: String {get}
    var method: RestMethod {get}
    var endPointName: String {get}
}
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
            return NetworkConstants.NYTimesAPIBaseURL + name
        case .mostviewedAllSections:
            return NetworkConstants.NYTimesAPIBaseURL + name
        }
    }
}

enum APIParametersKey {
    case NYTimesAPIKey
    case json
    var key: String {
        switch self {
        case .NYTimesAPIKey:
            return "api-key="
        case .json:
            return ".json?"
        }
    }
}
enum APIParametersValue {
    case NYTimesAPIValue
  
    var value: String {
        switch self {
        case .NYTimesAPIValue:
            return "xkNY5aV5vNaAC3bWJ9vrBLfGrkpfHpEF"
        }
    }
}

enum NewsPeriod: String {
    case day = "1"
    case week = "7"
    case month = "30"
}
