//
//  settingsTableViewController.swift
//  IIF Documentos
//
//  Created by Brandon Gonzalez on 16/03/20.
//  Copyright © 2020 Brandon Gonzalez. All rights reserved.
//

import UIKit

class settingsTableViewController: UITableViewController {
    var delegate: getOut?
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func logOut(_ sender: Any) {
        
        print("called")
        self.delegate?.logout2()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }


}
