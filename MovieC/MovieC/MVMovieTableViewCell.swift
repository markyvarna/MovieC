//
//  MVMovieTableViewCell.swift
//  MovieC
//
//  Created by Markus Varner on 9/14/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class MVMovieTableViewCell: UITableViewCell {

     //MARK: - Properties
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var descriptionTextView: UITextView!
    
    //Property Observer
    var movie: MVMovie?{
        didSet{
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func updateView() {
        
        guard let movie = movie else {return}
        titleLabel.text = movie.title
        ratingLabel.text = "rating: \(movie.rating)"
        descriptionTextView.text = movie.overview
        //fetch image
        MVMovieClient.shared().fetchImage(for: movie) { (image) in
            DispatchQueue.main.async {
                self.movieImageView.image = image
            }
            
        }
        
        
        
    }
    
}
