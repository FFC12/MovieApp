//
//  ProfileViewController.swift
//  MovieApp
//
//  Created by Furkan Fatih Cetindil
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ProfileViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        viewModel = ProfileViewModel()
         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Watched"
        case 1:
            cell.textLabel?.text = "Favourite"
        default:
            break
        }
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieListViewController()
        
        switch indexPath.row {
        case 0:
            let movies = viewModel?.getWatchedMovies() as? [[String:String]]
            vc.movieListDelegate = movies
        case 1:
            let movies = viewModel?.getFavouriteMovies() as? [[String:String]]
            vc.movieListDelegate = movies
        default:
            break
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
