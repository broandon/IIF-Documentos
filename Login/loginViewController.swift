//
//  loginViewController.swift
//  IIF Documentos
//
//  Created by Brandon Gonzalez on 04/03/20.
//  Copyright © 2020 Brandon Gonzalez. All rights reserved.
//

import UIKit
import LazyFadeInView

class loginViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var jobTF: UITextField!
    
    //MARK: viewDid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 2, animations: {
            
            self.logoImage.alpha = 1
            
        })
        
    }
    
    //MARK: Funcs
    
    func configureView() {
        
        // White view
        loginView.roundCorners([.topLeft, .topRight], radius: 35)
        loginView.layer.shadowColor = UIColor.black.cgColor
        loginView.layer.shadowOpacity = 1
        loginView.layer.shadowOffset = .zero
        loginView.layer.shadowRadius = 10
        
        // Name textfield
        nameTF.layer.cornerRadius = 15
        
        // Job textfield
        jobTF.layer.cornerRadius = 15
        
        // The login button
        loginButton.roundCorners([.bottomLeft, .bottomRight], radius: 35)
        
        // Logo transparency
        logoImage.alpha = 0
        
    }
    
    //MARK: Buttons
    
    @IBAction func loginButton(_ sender: Any) {
    
        UserDefaults.standard.set(true, forKey: "loggedIn")

    
    }
    
    //MARK: Extensions
    
}
