//
//  loginViewController.swift
//  IIF Documentos
//
//  Created by Brandon Gonzalez on 04/03/20.
//  Copyright © 2020 Brandon Gonzalez. All rights reserved.
//

import UIKit
import LazyFadeInView
import Hero

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
        loginView.layer.cornerRadius = 35
        loginView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        loginView.layer.shadowColor = UIColor.black.cgColor
        loginView.layer.shadowOpacity = 1
        loginView.layer.shadowOffset = .zero
        loginView.layer.shadowRadius = 10
        
        // Name textfield
        nameTF.layer.cornerRadius = 15
        
        // Job textfield
        jobTF.layer.cornerRadius = 15
        
        // The login button
        loginButton.layer.cornerRadius = 35
        loginButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        // Logo transparency
        logoImage.alpha = 0
        
    }
    
    //MARK: Buttons
    
    @IBAction func loginButton(_ sender: Any) {
        
        if nameTF.text?.isEmpty == true {
            
            let alert = UIAlertController(title: "Error", message: "Por favor introduce tu nombre.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Reintentar", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
            return
            
        }
        
        if jobTF.text?.isEmpty == true {
            
            let alert = UIAlertController(title: "Error", message: "Por favor introduce tu nombre.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Reintentar", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
            return
            
        }
        
        let name = nameTF.text
        
        UserDefaults.standard.set(name, forKey: "Name")
        
        UserDefaults.standard.set(true, forKey: "loggedIn")
        
        self.hero.isEnabled = true
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainViewController") as! mainViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.hero.modalAnimationType = .fade
        
        self.hero.replaceViewController(with: newViewController)
        
    }
    
}

//MARK: Extensions
