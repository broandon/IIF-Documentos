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
    
    let reuseDocument = "DocumentCell"
    let name = UserDefaults.standard.value(forKey: "Name")!
    let hour = Calendar.current.component(.hour, from: Date())
    
    let defaults = UserDefaults.standard
    
    var Documentos : [Dictionary<String, Any>] =
        [["Nombre": "Código Nacional de Procedimientos Penales", "ID" : "1", "PDFNAme" : "CNPP", "Imagen" : UIImage(named: "CNDPP")!],
         ["Nombre": "Código Penal de Morelos", "ID" : "2", "PDFNAme" : "CPEM", "Imagen" : UIImage(named: "CPDM")!],
         ["Nombre": "Código Penal Federal", "ID" : "3", "PDFNAme" : "CPF", "Imagen" : UIImage(named: "CPF")!],
         ["Nombre": "Constitución Mexicana", "ID" : "4", "PDFNAme" : "CM", "Imagen" : UIImage(named: "CM")!],
         ["Nombre": "Código Civil del Estado de Morelos", "ID" : "5", "PDFNAme" : "CVM", "Imagen" : UIImage(named: "CCDEM")!]]
    
    //MARK: viewDid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setUpHourLabel()
        configureTable()
        
    }
    
    //MARK: tableView Data
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Documentos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let document = Documentos[indexPath.row]
        
        let imagen = document["Nombre"] as! String
        let lofo = document["Imagen"] as! UIImage
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseDocument, for: indexPath)
        
        cell.selectionStyle = .none
        
        if let cell = cell as? documentsTableViewCell {
            
            DispatchQueue.main.async {
                
                cell.nameText.text = imagen
                cell.documentImage.image = lofo
                
            }
            
            return cell
            
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pickedDocument = Documentos[indexPath.row]
        
        let documentName = pickedDocument["PDFNAme"] as! String
        let documentImage = pickedDocument["Imagen"] as! UIImage
                
        defaults.set(documentName, forKey: "documentName")
                
        self.hero.isEnabled = true
                
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "documentViewController") as! documentViewController
        newViewController.image = documentImage
        newViewController.isModalInPresentation = true
        present(newViewController, animated: true, completion: {
            
            print("Here")
            
        })
        
    }
    
    //MARK: Funcs
    
    private func configureTable() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        let documentXib = UINib(nibName: "documentsTableViewCell", bundle: nil)
        tableView.register(documentXib, forCellReuseIdentifier: reuseDocument)
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 35
        tableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func configureView() {
        
        whiteView.layer.cornerRadius = 35
        whiteView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
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
        if 10...11 ~= hour{
            greetingsLabel.text = "¡Buenos días! ☀️ "
        }
        if 12...15 ~= hour{
            greetingsLabel.text = "¡Buenas tardes! 🌞"
        }
        if 16...18 ~= hour{
            greetingsLabel.text = "¡Excelente tarde! 🌅"
        }
        if 19 ~= hour{
            greetingsLabel.text = "¿Hora de merendar? 🤤"
        }
        if 20...24 ~= hour {
            greetingsLabel.text = "¡Buenas noches! 🌚"
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
