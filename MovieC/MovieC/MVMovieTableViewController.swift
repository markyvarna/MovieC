//
//  MVMovieTableViewController.swift
//  MovieC
//
//  Created by Markus Varner on 9/14/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class MVMovieTableViewController: UITableViewController, UISearchBarDelegate {
    
     //MARK: - Outlets
    @IBOutlet var movieSearchBar: UISearchBar!
    
    //MARK: - Properties
    
    //Source of Truth
    var movies: [MVMovie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieSearchBar.delegate = self
       
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MVMovieTableViewCell

        let movie = movies[indexPath.row]
        cell?.movie = movie
        

        return cell ?? UITableViewCell()
    }
    
    //MARK: - Search Bar Action Method
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text else {return}
        self.resignFirstResponder()
       
            MVMovieClient.shared().fetchMovie(bySearchTerm: searchTerm) { (movies) in
                //assign the movies that come back to the source of truth
                let movies =  movies
                
                DispatchQueue.main.async {
                    self.movies = movies
                    self.tableView.reloadData()
                }
            }
        
    }

   

}
