//
//  MovieDetailController.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/20/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import UIKit

enum TableCellType {
    case movieDetailCell
    case movieTraillersCell
}

class MovieDetailController: UITableViewController {

    var movieItem: MovieObj?
    private var traillerList: [TraillerObj] = []
    private var reviewList: [ReviewObj] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(MovieDetailsCell.self, forCellReuseIdentifier: .movieDetailcellId)
        self.tableView.register(MovieOverviewCell.self, forCellReuseIdentifier: .movieOverviewCellId)
        self.tableView.register(MovieTraillersCell.self, forCellReuseIdentifier: .movieTraillersCellId)
        self.tableView.register(MovieReviewsCell.self, forCellReuseIdentifier: .movieReviewsCellId)
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView()

        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        loadTraillers()
        loadReviews()
    }

    @objc private func orientationChanged() {
        self.tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        var sectionNum = 2
        if !traillerList.isEmpty { sectionNum += 1 }
        if !reviewList.isEmpty { sectionNum += 1 }
        return sectionNum
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: .movieDetailcellId, for: indexPath) as? MovieDetailsCell else { return UITableViewCell() }
            cell.movieItem = self.movieItem
            tableView.rowHeight = 320
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: .movieOverviewCellId, for: indexPath) as? MovieOverviewCell else { return UITableViewCell() }
            let detailsLabel = cell.movieDetails
            let detailsLabelWidth = self.view.frame.width - 32
            detailsLabel.text = movieItem?.overview
            tableView.rowHeight = (detailsLabel.text?.height(withConstrainedWidth: detailsLabelWidth,
                                                             font: detailsLabel.font) ?? 0) + 44
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: .movieTraillersCellId, for: indexPath) as? MovieTraillersCell else { return UITableViewCell() }
            cell.traillerList = self.traillerList
            tableView.rowHeight = 200
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: .movieReviewsCellId, for: indexPath) as? MovieReviewsCell else { return UITableViewCell() }
            cell.reviewList = self.reviewList
            tableView.rowHeight = CGFloat(self.reviewList.count * 80 + 44)
            return cell
        default:
            return UITableViewCell()
        }
    }

    private func loadTraillers() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        GetTraillers(movieId: String(movieItem?.id ?? -1)).excute(onSuccess: { (response: TraillerResponse) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.traillerList = response.traillerList
            self.tableView?.reloadData()
        }) { (error: Error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            print(error)
        }
    }

    private func loadReviews() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        GetReviews(movieId: String(movieItem?.id ?? -1)).excute(onSuccess: { (response: ReviewResponse) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.reviewList = response.results
            self.tableView?.reloadData()
        }) { (error: Error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            print(error)
        }
    }

}


fileprivate extension String {
    static let movieDetailcellId = "MovieDetailsCell"
    static let movieOverviewCellId = "MovieOverviewCell"
    static let movieTraillersCellId = "MovieTraillersCellId"
    static let movieReviewsCellId = "MovieReviewsCell"
}
