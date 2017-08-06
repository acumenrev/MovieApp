//
//  MAMovieDetailHeaderTableViewCell.swift
//  Movies
//
//  Created by admin on 8/5/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import UIKit

class MAMovieDetailHeaderTableViewCell: UITableViewCell {

    @IBOutlet private weak var imgBackground : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMovie(_ movie : MAMovieModel) {
        if let poster = movie.posterPath {
            MAAppUtils.loadRemoteImage(fromURL: MAAPIConstants.Common.imageUrl(withFileName: poster), onView: imgBackground)
        } else if let backdrop = movie.backdropPath {
            MAAppUtils.loadRemoteImage(fromURL: MAAPIConstants.Common.imageUrl(withFileName: backdrop), onView: imgBackground)
        }
    }
}
