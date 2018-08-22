//
//  TraillerCell.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/21/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import UIKit

class TraillerCell: UICollectionViewCell {


    lazy var traillerImage: ImageLoader = {
        let traillerImage = ImageLoader()
        traillerImage.contentMode = .scaleAspectFit
        traillerImage.backgroundColor = .black
        traillerImage.translatesAutoresizingMaskIntoConstraints = false
        return traillerImage
    }()

    lazy var playImage: UIImageView = {
        let playImage = UIImageView()
        playImage.contentMode = .scaleAspectFill
        playImage.image = #imageLiteral(resourceName: "play")
        playImage.backgroundColor = .clear
        playImage.translatesAutoresizingMaskIntoConstraints = false
        return playImage
    }()

    var traillerItem : TraillerObj? {
        didSet {
            guard let trailler = traillerItem else { return }
            if var urlComponents = URLComponents(string: .youtube) {
                urlComponents.path.append(trailler.key + "/mqdefault.jpg")
                if let url = urlComponents.url {
                    traillerImage.loadImageWithUrl(url)
                }
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(traillerImage)
        traillerImage.addSubview(playImage)

        NSLayoutConstraint.activate([
            traillerImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            traillerImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            traillerImage.topAnchor.constraint(equalTo: topAnchor),
            traillerImage.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])

        NSLayoutConstraint.activate([
            playImage.centerXAnchor.constraint(equalTo: traillerImage.centerXAnchor),
            playImage.centerYAnchor.constraint(equalTo: traillerImage.centerYAnchor)
            ])
    }

}

fileprivate extension String {
    static let youtube = "https://img.youtube.com/vi/"
}
