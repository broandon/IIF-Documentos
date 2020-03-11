//
//  mainViewController.swift
//  IIF Documentos
//
//  Created by Brandon Gonzalez on 04/03/20.
//  Copyright © 2020 Brandon Gonzalez. All rights reserved.
//

import UIKit

class mainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func logout(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "loggedIn")
        
        self.hero.isEnabled = true
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
        newViewController.hero.modalAnimationType = .autoReverse(presenting: .pageOut(direction: .right))
        
        self.hero.replaceViewController(with: newViewController)
        
    }
    
    
}
