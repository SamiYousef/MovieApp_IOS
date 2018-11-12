//
//  MovieOverviewCell.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/21/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import UIKit

class MovieOverviewCell: UITableViewCell {

    lazy var detailsTitle: UILabel = {
        let detailsTitle = UILabel()
        detailsTitle.textColor = .darkGray
        detailsTitle.font = UIFont.boldSystemFont(ofSize: 20)
        detailsTitle.numberOfLines = 1
        detailsTitle.text = "Overview"
        detailsTitle.translatesAutoresizingMaskIntoConstraints = false
        return detailsTitle
    }()

    lazy var movieDetails: UILabel = {
        let movieDetails = UILabel()
        movieDetails.textColor = .darkGray
        movieDetails.numberOfLines = 0
        movieDetails.translatesAutoresizingMaskIntoConstraints = false
        return movieDetails
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(detailsTitle)
        addSubview(movieDetails)

        NSLayoutConstraint.activate([
            detailsTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            detailsTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            detailsTitle.topAnchor.constraint(equalTo: topAnchor, constant: 16)
            ])

        NSLayoutConstraint.activate([
            movieDetails.leadingAnchor.constraint(equalTo: detailsTitle.leadingAnchor),
            movieDetails.trailingAnchor.constraint(equalTo: detailsTitle.trailingAnchor),
            movieDetails.topAnchor.constraint(equalTo: detailsTitle.bottomAnchor)
            ])
    }

}
