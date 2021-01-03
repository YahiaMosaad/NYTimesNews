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
    var standradThumbnailURL: String? {
        let standradThumbnail = getMediaInfo(format: "Standard Thumbnail")
        guard standradThumbnail != nil else {
            return nil
        }
        return standradThumbnail!.url
    }
    var largeImageURL: String? {
        let largeImage = getMediaInfo(format: "mediumThreeByTwo440")
        guard getMediaInfo(format: "mediumThreeByTwo440") != nil else {
            return nil
        }
        return largeImage!.url
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
        return metadata?.filter { $0.format == format}.first
    }
    private enum CodingKeys: String, CodingKey {
        case  title, publishedDate = "published_date", identifier = "id", abstract, media
    }
}
