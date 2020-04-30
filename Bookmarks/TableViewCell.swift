//
//  TableViewCell.swift
//  IIF Documentos
//
//  Created by Brandon Gonzalez on 29/04/20.
//  Copyright © 2020 Brandon Gonzalez. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var piedeOfText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
//    override func didMoveToSuperview() {
//        super.didMoveToSuperview()
//        layoutIfNeeded()
//    }
    
}
