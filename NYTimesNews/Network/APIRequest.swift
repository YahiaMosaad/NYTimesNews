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
