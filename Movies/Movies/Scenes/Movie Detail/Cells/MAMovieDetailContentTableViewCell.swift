//
//  MAMovieDetailContentTableViewCell.swift
//  Movies
//
//  Created by admin on 8/5/17.
//  Copyright © 2017 Tri Vo. All rights reserved.
//

import UIKit

class MAMovieDetailContentTableViewCell: UITableViewCell {

    @IBOutlet private weak var lblContent : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContent(_ content : String?) {
        lblContent.text = content
    }
    
}
