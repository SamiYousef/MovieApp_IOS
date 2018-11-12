//
//  MovieDetailsCell.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/20/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import UIKit

class MovieDetailsCell: UITableViewCell {

    private let posterWidth: CGFloat = 140

    lazy var backDropImage: ImageLoader = {
        let image = ImageLoader()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var posterImage: ImageLoader = {
        let poster = ImageLoader()
        poster.contentMode = .scaleAspectFill
        poster.clipsToBounds = true
        poster.layer.cornerRadius = posterWidth / 2
        poster.translatesAutoresizingMaskIntoConstraints = false
        return poster
    }()

    lazy var posterOuterView: UIView = {
        let outerView = UIView()
        outerView.layer.cornerRadius = posterWidth / 2
        outerView.layer.shadowColor = UIColor.white.cgColor
        outerView.layer.shadowOffset = CGSize(width: 0, height: -3)
        outerView.layer.shadowOpacity = 20
        outerView.backgroundColor = .white
        outerView.translatesAutoresizingMaskIntoConstraints = false
        return outerView
    }()


    lazy var movieTitle: UILabel = {
        let title = UILabel()
        title.textColor = .darkGray
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.numberOfLines = 2
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    lazy var movieVote: UILabel = {
        let movieVote = UILabel()
        movieVote.textColor = .darkGray
        movieVote.numberOfLines = 1
        movieVote.translatesAutoresizingMaskIntoConstraints = false
        return movieVote
    }()

    lazy var movieRate: UILabel = {
        let movieRate = UILabel()
        movieRate.textColor = .darkGray
        movieRate.numberOfLines = 1
        movieRate.translatesAutoresizingMaskIntoConstraints = false
        return movieRate
    }()

    lazy var movieReleaseDate: UILabel = {
        let movieReleaseDate = UILabel()
        movieReleaseDate.textColor = .darkGray
        movieReleaseDate.numberOfLines = 1
        movieReleaseDate.translatesAutoresizingMaskIntoConstraints = false
        return movieReleaseDate
    }()

    lazy var movieLanguage: UILabel = {
        let movieLanguage = UILabel()
        movieLanguage.textColor = .darkGray
        movieLanguage.numberOfLines = 1
        movieLanguage.translatesAutoresizingMaskIntoConstraints = false
        return movieLanguage
    }()

    var movieItem: MovieObj? {
        didSet {
            guard let movie = movieItem else { return }
            movieTitle.text = movie.title
            movieRate.set(image: #imageLiteral(resourceName: "star"), with: "\(movie.vote_average)/10")
            movieVote.set(image: #imageLiteral(resourceName: "vote"), with: "\(movie.vote_count) votes")
            movieLanguage.set(image: #imageLiteral(resourceName: "language"), with: movie.original_language)
            movieReleaseDate.set(image: #imageLiteral(resourceName: "calender"), with: movie.release_date)

            if var imageUrl = URL(string: .BackDropImageUrl) {
                imageUrl.appendPathComponent(movie.backdrop_path ?? "")
                backDropImage.loadImageWithUrl(imageUrl)
            }

            if var imageUrl = URL(string: .BaseImageUrl) {
                imageUrl.appendPathComponent(movie.poster_path)
                posterImage.loadImageWithUrl(imageUrl)
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(backDropImage)
        addSubview(posterOuterView)
        posterOuterView.addSubview(posterImage)
        addSubview(movieTitle)
        addSubview(movieRate)
        addSubview(movieVote)
        addSubview(movieReleaseDate)
        addSubview(movieLanguage)

        NSLayoutConstraint.activate([
            backDropImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backDropImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backDropImage.topAnchor.constraint(equalTo: topAnchor),
            backDropImage.heightAnchor.constraint(equalToConstant: frame.width * 0.6)
            ])

        NSLayoutConstraint.activate([
            posterOuterView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            posterOuterView.topAnchor.constraint(equalTo: backDropImage.bottomAnchor, constant: -posterWidth / 2),
            posterOuterView.widthAnchor.constraint(equalToConstant: posterWidth),
            posterOuterView.heightAnchor.constraint(equalToConstant: posterWidth)
            ])

        NSLayoutConstraint.activate([
            posterImage.leadingAnchor.constraint(equalTo: posterOuterView.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: posterOuterView.trailingAnchor),
            posterImage.topAnchor.constraint(equalTo: posterOuterView.topAnchor),
            posterImage.bottomAnchor.constraint(equalTo: posterOuterView.bottomAnchor)
            ])

        NSLayoutConstraint.activate([
            movieTitle.leadingAnchor.constraint(equalTo: posterOuterView.trailingAnchor, constant: 8),
            movieTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            movieTitle.topAnchor.constraint(equalTo: backDropImage.bottomAnchor, constant: 8)
            ])

        NSLayoutConstraint.activate([
            movieRate.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor),
            movieRate.trailingAnchor.constraint(equalTo: movieTitle.trailingAnchor),
            movieRate.topAnchor.constraint(equalTo: movieTitle.bottomAnchor),
            ])

        NSLayoutConstraint.activate([
            movieVote.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor),
            movieVote.trailingAnchor.constraint(equalTo: movieTitle.trailingAnchor),
            movieVote.topAnchor.constraint(equalTo: movieRate.bottomAnchor),
            ])

        NSLayoutConstraint.activate([
            movieReleaseDate.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor),
            movieReleaseDate.trailingAnchor.constraint(equalTo: movieTitle.trailingAnchor),
            movieReleaseDate.topAnchor.constraint(equalTo: movieVote.bottomAnchor),
            ])

        NSLayoutConstraint.activate([
            movieLanguage.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor),
            movieLanguage.trailingAnchor.constraint(equalTo: movieTitle.trailingAnchor),
            movieLanguage.topAnchor.constraint(equalTo: movieReleaseDate.bottomAnchor)
            ])

    }

}

fileprivate extension String {
    static let BackDropImageUrl = "http://image.tmdb.org/t/p/w500/"
    static let BaseImageUrl = "http://image.tmdb.org/t/p/w185/"
}
