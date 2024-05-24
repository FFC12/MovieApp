//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Furkan Fatih Cetindil
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchViewModel = SearchViewModel()
    var searchText: String = ""
    var movies: [MovieSearchResult] = []
    var moviesCount: Int = 0
    var isLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        self.searchBar.showsBookmarkButton = false
        self.searchBar.searchBarStyle = .minimal
        self.searchBar.setImage(UIImage(named: "slider.vertical.3"), for: .bookmark, state: [.highlighted, .selected, .focused, .application, .disabled, .normal])
        
        let cellNib = UINib(nibName: "MovieCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "MovieCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.movies.removeAll()
        self.moviesCount = 0
        self.tableView.reloadData()
        
        // dismiss keyboard
        self.searchBar.endEditing(true)
        
        self.searchViewModel.next(keyword: self.searchText) { (movies) in
            DispatchQueue.main.async {
                self.movies.append(contentsOf: movies)
                self.moviesCount = movies.count
                self.tableView.reloadData()
                
                // go to top
                self.tableView.setContentOffset(.zero, animated: true)
            }
        }
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("Bookmark Clicked")
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = self.movies[indexPath.row]
        cell.initMovieCell(poster: movie.poster,title: movie.title, author: movie.year, plot: movie.type)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviesCount
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoriteAction = UIContextualAction(style: .normal, title: "Favorite") {
            (action, view, completion) in
            completion(true)
            self.searchViewModel.addFavourite(id: self.movies[indexPath.row].imdbID, url: self.movies[indexPath.row].poster.absoluteString, title: self.movies[indexPath.row].title)
            self.showToast(message: "Added to 'favourite' list")
        }
        
        favoriteAction.backgroundColor = .systemPurple
        
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let shareAction = UIContextualAction(style: .normal, title: "Watched") {
            (action, view, completion) in
            completion(true)
            self.searchViewModel.addWatched(id: self.movies[indexPath.row].imdbID, url: self.movies[indexPath.row].poster.absoluteString, title: self.movies[indexPath.row].title)
            
            self.showToast(message: "Added to 'watched' list")
        }
        shareAction.backgroundColor = .systemGreen
        
        return UISwipeActionsConfiguration(actions: [shareAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Selected \(indexPath.row)")
        let vc = MovieDetailsViewController()
        vc.movieId = self.movies[indexPath.row].imdbID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.moviesCount <= 0 { return }
        let position = scrollView.contentOffset.y
        
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            guard !self.isLoading else { return }
            self.isLoading = true
            
            self.searchViewModel.loadMore(keyword: self.searchText) { (movies) in
                if movies.count == 0 { return }
                DispatchQueue.main.async {
                    self.movies.append(contentsOf: movies)
                    self.moviesCount += movies.count
                    self.tableView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
}
