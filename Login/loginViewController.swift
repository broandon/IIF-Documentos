//
//  loginViewController.swift
//  IIF Documentos
//
//  Created by Brandon Gonzalez on 04/03/20.
//  Copyright © 2020 Brandon Gonzalez. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var nameTF: UITextField!
    
    //MARK: viewDid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
    }
    
    //MARK: Funcs
    
    func configureView() {
        
        loginView.layer.cornerRadius = 50
        loginView.layer.shadowColor = UIColor.black.cgColor
        loginView.layer.shadowOpacity = 1
        loginView.layer.shadowOffset = .zero
        loginView.layer.shadowRadius = 10
        nameTF.layer.cornerRadius = 15
    }
    
    //MARK: Buttons
    
    //MARK: Extensions
    
}
