//
//  settingsTableViewController.swift
//  IIF Documentos
//
//  Created by Brandon Gonzalez on 16/03/20.
//  Copyright © 2020 Brandon Gonzalez. All rights reserved.
//

import UIKit

class settingsTableViewController: UITableViewController {
    
    //MARK: Outlets
    
    var delegate: getOut?
    
    //MARK: viewDid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: Buttons
    
    @IBAction func logOut(_ sender: Any) {
        
        print("Pressed Log Out")
        self.delegate?.logout2()
        
    }
    
}

//MARK: Extensions
