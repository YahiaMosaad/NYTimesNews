//
//  NewsFeedMediaModal.swift
//  NYTimesNews
//
//  Created by Yahia Mosaad on 03/01/2021.
//

import Foundation
struct NewsFeedMediaModal: Codable {
    let type: String
    let metadata: [NewsFeedMediaInfoModal]?
    private enum CodingKeys: String, CodingKey {
        case  type, metadata = "media-metadata"
    }
}
