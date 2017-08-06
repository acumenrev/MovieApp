//
//  MAMovieTableViewCell.swift
//  Movies
//
//  Created by admin on 8/5/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import UIKit

class MAMovieTableViewCell: UITableViewCell {

    @IBOutlet private weak var lblTitle : UILabel!
    @IBOutlet private weak var imgBackground : UIImageView!
    @IBOutlet private weak var lblRating : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        MAAppUtils.cancelDownloadingRemoteImage(on: imgBackground)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMovie(_ movie : MAMovieModel) {
        lblTitle.text = movie.title
        if let poster = movie.posterPath {
            MAAppUtils.loadRemoteImage(fromURL: MAAPIConstants.Common.imageUrl(withFileName: poster), onView: imgBackground)
        } else if let backdrop = movie.backdropPath {
            MAAppUtils.loadRemoteImage(fromURL: MAAPIConstants.Common.imageUrl(withFileName: backdrop), onView: imgBackground)
        }
        
        lblRating.text = movie.voteAverage?.string
    }
    
}
