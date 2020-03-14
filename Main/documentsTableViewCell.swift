//
//  documentsTableViewCell.swift
//  IIF Documentos
//
//  Created by Brandon Gonzalez on 13/03/20.
//  Copyright © 2020 Brandon Gonzalez. All rights reserved.
//

import UIKit

class documentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var documentImage: UIImageView!
    @IBOutlet weak var imageBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageBackground.layer.cornerRadius = imageBackground.bounds.height / 2
        imageBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        
        documentImage.layer.cornerRadius = documentImage.bounds.height / 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
