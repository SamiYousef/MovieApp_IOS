//
//  ViewController.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/18/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import UIKit

class MovieListController: UICollectionViewController {

    private var movieList = [MovieObj]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "MovieApp"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.backgroundColor = .white
        self.collectionView?.register(MovieCell.self, forCellWithReuseIdentifier: .movieCellId)
        fetchMovieList()
    }

    private func fetchMovieList() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        GetMovieList().excute(onSuccess: { (movieResponse: MovieResponse) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.movieList = movieResponse.results
            self.collectionView?.reloadData()
        }) { (error: Error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            print(error)
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .movieCellId, for: indexPath) as? MovieCell else { return UICollectionViewCell() }
        cell.movieItem = movieList[indexPath.row]
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = MovieDetailController()
        detailController.movieItem = movieList[indexPath.row]
        self.navigationController?.pushViewController(detailController, animated: true)
    }

}

extension MovieListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let movieCellWidth = self.view.frame.width / 3 - 8
        let movieCellHeight = (movieCellWidth * 16) / 9
        return CGSize(width: movieCellWidth, height: movieCellHeight)
    }
}

fileprivate extension String {
    static let movieCellId = "movieCellId"
}
