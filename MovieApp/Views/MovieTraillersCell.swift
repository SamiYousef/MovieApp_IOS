//
//  MovieTraillersCell.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/21/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import UIKit

class MovieTraillersCell: UITableViewCell {

    lazy var traillersTitle: UILabel = {
        let traillersTitle = UILabel()
        traillersTitle.textColor = .darkGray
        traillersTitle.font = UIFont.boldSystemFont(ofSize: 20)
        traillersTitle.numberOfLines = 1
        traillersTitle.text = "Traillers"
        traillersTitle.translatesAutoresizingMaskIntoConstraints = false
        return traillersTitle
    }()

    lazy var collectionviewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()

    lazy var traillorCollection: UICollectionView = {
        let traillorCollection = UICollectionView(frame: .zero, collectionViewLayout: collectionviewLayout)
        traillorCollection.backgroundColor = .white
        traillorCollection.delegate = self
        traillorCollection.dataSource = self
        traillorCollection.register(TraillerCell.self, forCellWithReuseIdentifier: .traillerCellId)
        traillorCollection.translatesAutoresizingMaskIntoConstraints = false
        return traillorCollection
    }()

    var traillerList: [TraillerObj]? {
        didSet {
            self.traillorCollection.reloadData()
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(traillersTitle)
        addSubview(traillorCollection)

        NSLayoutConstraint.activate([
            traillersTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            traillersTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            traillersTitle.topAnchor.constraint(equalTo: topAnchor, constant: 16)
            ])

        NSLayoutConstraint.activate([
            traillorCollection.leadingAnchor.constraint(equalTo: traillersTitle.leadingAnchor),
            traillorCollection.trailingAnchor.constraint(equalTo: traillersTitle.trailingAnchor),
            traillorCollection.topAnchor.constraint(equalTo: traillersTitle.bottomAnchor),
            traillorCollection.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}

extension MovieTraillersCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return traillerList?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .traillerCellId, for: indexPath) as? TraillerCell else { return UICollectionViewCell() }
        cell.traillerItem = self.traillerList?[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = 100.0
        return CGSize(width: height * 16/9, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

fileprivate extension String {
    static let traillerCellId = "TraillerCell"
}
