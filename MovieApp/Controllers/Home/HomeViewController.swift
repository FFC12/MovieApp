//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Furkan Fatih Cetindil
//

import UIKit

class HomeViewController: UIViewController {
    var viewModel: HomeViewModel?
    
    var movieCount: Int = 0
    var movies: [MovieSearchResult] = []
    
    var isLoading: Bool = false
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var moviesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        
        viewModel = HomeViewModel()
        
        viewModel?.next { (movies) in
            DispatchQueue.main.async {
                self.movieCount = movies.count
                self.movies = movies
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
     
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = self.movies[indexPath.row]
        cell.initMovieCell(poster: movie.poster,title: movie.title, author: movie.year, plot: movie.type)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoriteAction = UIContextualAction(style: .normal, title: "Favorite") {
            (action, view, completion) in
            completion(true)
            self.viewModel?.addFavourite(id: self.movies[indexPath.row].imdbID, url: self.movies[indexPath.row].poster.absoluteString, title: self.movies[indexPath.row].title)
            self.showToast(message: "Added to 'favourite' list")
        }
        
        favoriteAction.backgroundColor = .systemPurple
        
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let shareAction = UIContextualAction(style: .normal, title: "Watched") {
            (action, view, completion) in
            completion(true)
            self.viewModel?.addWatched(id: self.movies[indexPath.row].imdbID, url: self.movies[indexPath.row].poster.absoluteString, title: self.movies[indexPath.row].title)
            self.showToast(message: "Added to 'watched' list")
        }
        shareAction.backgroundColor = .systemGreen
        
        return UISwipeActionsConfiguration(actions: [shareAction])
    }
    
    // when click the cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = MovieDetailsViewController()
        vc.movieId = self.movies[indexPath.row].imdbID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.movieCount <= 0 { return }
        let position = scrollView.contentOffset.y
        
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            guard !self.isLoading else { return }
            self.isLoading = true
             
            viewModel?.loadMore { (movies) in
                if movies.isEmpty { return }
                DispatchQueue.main.async {
                    self.movieCount += movies.count
                    self.movies.append(contentsOf: movies)
                    self.tableView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
}
