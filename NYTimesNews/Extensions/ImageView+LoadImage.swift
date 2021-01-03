//
//  ImageView+LoadImage.swift
//  NYTimesNews
//
//  Created by Yahia Mosaad on 03/01/2021.
//

import UIKit

extension UIImageView {
    var imageCache: NSCache<NSString, UIImage> {
        return CasheManager.shared.imageCahser
    }
    func loadImageFromCache(withUrl urlString: String) {
        let url = URL(string: urlString)
        self.image = nil
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, _, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    self.imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
        }).resume()
    }
    func loadImageFromCache(withUrl urlString: String, cellIndexPathRow: Int) {
        let url = URL(string: urlString)
        self.image = nil
        // check cached image is already fetched
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, _, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if self.tag != cellIndexPathRow {
                    return
                }
                if let image = UIImage(data: data!) {
                    self.imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
        }).resume()
    }
}

class CasheManager {
    static let shared = CasheManager()
    let imageCahser: NSCache<NSString, UIImage>
    private init() {
        self.imageCahser = NSCache<NSString, UIImage>()
    }
}
