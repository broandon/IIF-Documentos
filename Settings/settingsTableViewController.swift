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
    
    //MARK: viewDid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: Buttons
    
    @IBAction func logOut(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "loggedIn")
        
        guard let rootVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginViewController") as? loginViewController else {
            return
        }
        
        UIApplication.shared.windows.first?.rootViewController = rootVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
    }
    
}

//MARK: Extensions
