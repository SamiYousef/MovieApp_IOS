//
//  MovieReviewsCell.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/21/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import UIKit

class MovieReviewsCell: UITableViewCell {

    lazy var reviewsTitle: UILabel = {
        let reviewsTitle = UILabel()
        reviewsTitle.textColor = .darkGray
        reviewsTitle.font = UIFont.boldSystemFont(ofSize: 20)
        reviewsTitle.numberOfLines = 1
        reviewsTitle.text = "Reviews"
        reviewsTitle.translatesAutoresizingMaskIntoConstraints = false
        return reviewsTitle
    }()

    lazy var reviewsTableView: UITableView = {
        let reviewsTableView = UITableView()
        reviewsTableView.delegate = self
        reviewsTableView.dataSource = self
        reviewsTableView.register(ReviewCell.self, forCellReuseIdentifier: .ReviewCellId)
        reviewsTableView.tableFooterView = UIView()
        reviewsTableView.separatorStyle = .none
        reviewsTableView.translatesAutoresizingMaskIntoConstraints = false
        return reviewsTableView
    }()

    var reviewList: [ReviewObj]? {
        didSet {
            self.reviewsTableView.reloadData()
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(reviewsTitle)
        addSubview(reviewsTableView)

        NSLayoutConstraint.activate([
            reviewsTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            reviewsTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            reviewsTitle.topAnchor.constraint(equalTo: topAnchor, constant: 16)
            ])

        NSLayoutConstraint.activate([
            reviewsTableView.leadingAnchor.constraint(equalTo: reviewsTitle.leadingAnchor),
            reviewsTableView.trailingAnchor.constraint(equalTo: reviewsTitle.trailingAnchor),
            reviewsTableView.topAnchor.constraint(equalTo: reviewsTitle.bottomAnchor),
            reviewsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

}

extension MovieReviewsCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .ReviewCellId, for: indexPath) as? ReviewCell else { return UITableViewCell() }
        cell.reviewItem = reviewList?[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

fileprivate extension String {
    static let ReviewCellId = "ReviewCell"
}
