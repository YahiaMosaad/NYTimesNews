//
//  NewsFeedDataModal.swift
//  NYTimesNews
//
//  Created by Yahia Mosaad on 03/01/2021.
//

import Foundation

struct NewsFeedDataModal: Codable {
    let title: String
    let publishedDate: String
    let identifier: Int
    let abstract: String
    let media: [NewsFeedMediaModal]?
    var thumbnailURL: String? {
        let thumnailMedia = getMediaInfo(format: "square320")
        guard thumnailMedia != nil else {
            return nil
        }
        return thumnailMedia!.url
    }
    var jumboImageURL: String? {
        let thumnailMedia = getMediaInfo(format: "Jumbo")
        guard thumnailMedia != nil else {
            return nil
        }
        return thumnailMedia!.url
    }
    func getMediaInfo (format: String) -> NewsFeedMediaInfoModal? {
        guard media != nil, media!.count > 0 else {
            return nil
        }
        let firstMediaInfo = media![0]
        let metadata = firstMediaInfo.metadata
        guard firstMediaInfo.type == "image", metadata != nil, metadata!.count > 0 else {
            return nil
        }
        return firstMediaInfo.metadata?.first
    }
    private enum CodingKeys: String, CodingKey {
        case  title, publishedDate = "published_date", identifier = "id", abstract, media
    }
}
