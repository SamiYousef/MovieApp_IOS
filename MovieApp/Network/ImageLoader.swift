//
//  ImageLoader.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/19/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: UIImageView {

    private var imageURL: URL?
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
         indicator.color = .orange
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    func loadImageWithUrl(_ url: URL) {

        // setup activityIndicator...
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])

        imageURL = url
        image = nil
        activityIndicator.startAnimating()

        // retrieves image if already available in cache
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            activityIndicator.stopAnimating()
            return
        }

        // image does not available in cache.. so retrieving it from url...
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

            if error != nil {
                print(error as Any)
                self.activityIndicator.stopAnimating()
                return
            }

            DispatchQueue.main.async {
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    if self.imageURL == url {
                        self.image = imageToCache
                    }
                    imageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
                self.activityIndicator.stopAnimating()
            }
        }).resume()
    }
}
