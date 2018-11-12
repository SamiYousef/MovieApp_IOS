//
//  ReviewCell.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/21/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    lazy var reviewAuthor: UILabel = {
        let reviewAuthor = UILabel()
        reviewAuthor.textColor = .darkGray
        reviewAuthor.font = UIFont.boldSystemFont(ofSize: 17)
        reviewAuthor.numberOfLines = 1
        reviewAuthor.translatesAutoresizingMaskIntoConstraints = false
        return reviewAuthor
    }()

    lazy var reviewContent: UILabel = {
        let reviewContent = UILabel()
        reviewContent.textColor = .darkGray
        reviewContent.numberOfLines = 2
        reviewContent.translatesAutoresizingMaskIntoConstraints = false
        return reviewContent
    }()

    var reviewItem: ReviewObj? {
        didSet {
            guard let review = reviewItem else { return }
            reviewAuthor.text = review.author
            reviewContent.text = review.content
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
        addSubview(reviewAuthor)
        addSubview(reviewContent)

        NSLayoutConstraint.activate([
            reviewAuthor.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            reviewAuthor.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            reviewAuthor.topAnchor.constraint(equalTo: topAnchor, constant: 8)
            ])

        NSLayoutConstraint.activate([
            reviewContent.leadingAnchor.constraint(equalTo: reviewAuthor.leadingAnchor),
            reviewContent.trailingAnchor.constraint(equalTo: reviewAuthor.trailingAnchor),
            reviewContent.topAnchor.constraint(equalTo: reviewAuthor.bottomAnchor),
            reviewContent.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
    }

}
