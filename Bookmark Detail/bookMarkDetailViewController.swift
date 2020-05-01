//
//  bookMarkDetailViewController.swift
//  IIF Documentos
//
//  Created by Brandon Gonzalez on 01/05/20.
//  Copyright © 2020 Brandon Gonzalez. All rights reserved.
//

import UIKit

class bookMarkDetailViewController: UIViewController {
    
    //MARK: Outlets
    
    var fillDocumentName : String?
    var fillPage : String?
    var fillText : String?
    var PDFName : String?
    
    var image : UIImage?
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var documentName: UILabel!
    @IBOutlet weak var documentPage: UILabel!
    @IBOutlet weak var documentText: UITextView!
    @IBOutlet weak var goToPageButton: UIButton!
    
    //MARK: viewDid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    //MARK: Funcs
    
    func chooseBookImage() {
        
        if PDFName == "CNPP" {
            
            bookImage.image = UIImage(named: "CNDPP")
            image = UIImage(named: "CNDPP")
            
        }
        
        if PDFName == "CPEM" {
            
            bookImage.image = UIImage(named: "CPDM")
            image = UIImage(named: "CDPM")
        }
        
        if PDFName == "CPF" {
            
            bookImage.image = UIImage(named: "CPF")
            image = UIImage(named: "CPF")
            
        }
        
        if PDFName == "CM" {
            
            bookImage.image = UIImage(named: "CM")
            image = UIImage(named: "CM")
        }
        
        if PDFName == "CVM" {
            
            bookImage.image = UIImage(named: "CCDEM")
            image = UIImage(named: "CCDEM")
            
        }
        
    }
    
    func setupView() {
        
        goToPageButton.layer.cornerRadius = 20
        documentName.text = fillDocumentName
        documentText.text = fillText
        documentPage.text = fillPage
        chooseBookImage()
        bookImage.layer.cornerRadius = 20
        
    }
    
    @IBAction func goToDocument(_ sender: Any) {
        
        UserDefaults.standard.set(true, forKey: "sentFromBookmarks")
        UserDefaults.standard.set(PDFName, forKey: "documentName")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "documentViewController") as! documentViewController
        
        newViewController.imageFromBookmarks = image
        newViewController.fillpage = fillPage
        
        present(newViewController, animated: true, completion: nil)
        
    }
    
    
}
