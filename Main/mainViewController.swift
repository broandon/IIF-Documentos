//
//  mainViewController.swift
//  IIF Documentos
//
//  Created by Brandon Gonzalez on 04/03/20.
//  Copyright © 2020 Brandon Gonzalez. All rights reserved.
//

import UIKit

class mainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Outlets
    
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var settingsImage: UIImageView!
    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var topImagePlaceholder: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let name = UserDefaults.standard.value(forKey: "Name")!
    let hour = Calendar.current.component(.hour, from: Date())
    
    //MARK: viewDid
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureView()
        setUpHourLabel()
        
    }
    
    //MARK: tableView Data
    
    let documents : Dictionary = ["document1": "document2", "document3": "document4"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return documents.count
    }
    
    
    //MARK: Funcs
    
    private func configureTable() {
        
        let reuseDocument = "DocumentCell79"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        let documentXib = UINib(nibName: "documentosPersonalesTableViewCell", bundle: nil)
        tableView.register(documentXib, forCellReuseIdentifier: reuseDocument)
    }
    
    func configureView() {
        
        whiteView.roundCorners([.topLeft, .topRight], radius: 35)
        nameLabel.text = "Hola, \(name)"
        whiteView.slideInFromBottom()
        nameLabel.slideInFromTop()
        profileImage.slideInFromRight()
        settingsImage.slideInFromLeft()
        
    }
    
    func setUpHourLabel() {
        
        if 0...3 ~= hour {
            greetingsLabel.text = "Trabajando tarde. 😎"
        }
        if 4...5 ~= hour {
            greetingsLabel.text = "Buho nocturno. 🦉"
        }
        if 6...9 ~= hour {
            greetingsLabel.text = "Excelente mañana. 🌄"
        }
        if 10...12 ~= hour{
            greetingsLabel.text = "¡Buenos días! ☀️ "
        }
        if 13...15 ~= hour{
            greetingsLabel.text = "¡Buenas tardes!"
        }
        if 16...18 ~= hour{
            greetingsLabel.text = "¡Excelente tarde! 🌅"
        }
        if 19 ~= hour{
            greetingsLabel.text = "¿Hora de merendar? 🤤"
        }
        if 20...24 ~= hour {
            greetingsLabel.text = "¡Buenas noches! 🌚 "
        }
        
    }
    
    //MARK: Buttons
    
    @IBAction func logout(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "loggedIn")
        self.hero.isEnabled = true
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
        newViewController.hero.modalAnimationType = .autoReverse(presenting: .pageOut(direction: .right))
        self.hero.replaceViewController(with: newViewController)
        
    }
    
    
}

//MARK: Extensions
