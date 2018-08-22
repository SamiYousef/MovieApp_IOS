//
//  MovieCell.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/18/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {


    lazy var movieImage: ImageLoader = {
        let image = ImageLoader()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var movieTitle: UILabel = {
        let movieName = UILabel()
        movieName.text = "Domo text"
        movieName.numberOfLines = 3
        movieName.textColor = .white
        movieName.font = UIFont.boldSystemFont(ofSize: 16)
        movieName.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        movieName.translatesAutoresizingMaskIntoConstraints = false
        return movieName
    }()

    var movieItem: MovieObj? {
        didSet {
            guard let movie = movieItem else { return }
            movieTitle.text = movie.title
            if var imageUrl = URL(string: .baseImageUrl) {
                imageUrl.appendPathComponent(movie.poster_path)
                movieImage.loadImageWithUrl(imageUrl)
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
        addSubview(movieImage)
        movieImage.addSubview(movieTitle)

        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: topAnchor),
            movieImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            movieImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        NSLayoutConstraint.activate([
            movieTitle.bottomAnchor.constraint(equalTo: movieImage.bottomAnchor),
            movieTitle.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor),
            movieTitle.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor)
            ])
    }

}

fileprivate extension String {
    static let baseImageUrl = "http://image.tmdb.org/t/p/w185/"
}

