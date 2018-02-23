//
//  ArticleCell.swift
//  TechNews
//
//  Created by Lucy Mambre on 24/01/2018.
//  Copyright © 2018 Lucy Mambre. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTitle: UITextField!    
    @IBOutlet weak var myDesc: UILabel!
    @IBOutlet weak var myAuthor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if (selected == true) {
        }
    }

}
