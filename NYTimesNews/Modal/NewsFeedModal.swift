//
//  NewsFeedModal.swift
//  NYTimesNews
//
//  Created by Yahia Mosaad on 03/01/2021.
//

import Foundation
struct NewsFeedModal: Codable {
    let status: String?
    let copyright: String?
    let results: [NewsFeedDataModal]?
}
