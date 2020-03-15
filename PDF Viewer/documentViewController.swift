//
//  documentViewController.swift
//  IIF Documentos
//
//  Created by Brandon Gonzalez on 12/03/20.
//  Copyright © 2020 Brandon Gonzalez. All rights reserved.
//

import UIKit
import PDFKit
import Floaty

class documentViewController: UIViewController, PDFDocumentDelegate {
    
    //MARK: Outlets
    
    var image: UIImage?
    var stringStarting: String?
    var searchedItem: PDFSelection?
    var mainDocument: PDFDocument!
    var pdfdocument: PDFDocument?

    
    let documentName = UserDefaults.standard.value(forKey: "documentName") as! String
    
    @IBOutlet weak var documentViewer: PDFView!
    @IBOutlet weak var documentVisualAid: UIImageView!
    @IBOutlet weak var search: UITextField!
    
    //MARK: viewDid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDocumentViewer()
        optionsButton()
        
    }
    
    //MARK: Funcs
    
    func setupDocumentViewer() {
        
        guard let path = Bundle.main.url(forResource: documentName, withExtension: "pdf") else { return }
        
        mainDocument = PDFDocument(url: path)
        documentViewer.document = mainDocument
        documentViewer.document?.delegate = self
        documentViewer.autoScales = true
        
        documentVisualAid.image = image
        
    }
    
    func optionsButton() {
        
        let floaty = Floaty()
        floaty.buttonColor = UIColor(named: "Main Blue") ?? UIColor.black
        floaty.plusColor = UIColor.white
        floaty.addItem("Buscar", icon: UIImage(named: "searchIcon")!, handler: { item in
            
            self.searchBtnClick()
            
            floaty.close()
        })
        self.view.addSubview(floaty)
        
    }
    
    func searchBtnClick() {
        let searchViewController = SearchTableViewController()
        searchViewController.pdfDocument = mainDocument
        searchViewController.delegate = self
        
        let nav = UINavigationController(rootViewController: searchViewController)
        self.present(nav, animated: true, completion:nil)
    }
    
    func documentDidEndDocumentFind(_ notification: Notification) {
        print("Ended search")
        documentViewer.setCurrentSelection(searchedItem, animate: true)
    }
    
    func documentDidFindMatch(_ notification: Notification) {
        print("foundMatch")
        if let selection = notification.userInfo?.first?.value as? PDFSelection {
            selection.color = .yellow
            if searchedItem == nil {
                print("Found shit")
                // The first found item sets the object.
                searchedItem = selection
                documentViewer.go(to: selection.pages[0])
                print(selection.pages)
            }
        }
    }
    
    //MARK: Buttons
    
    @IBAction func close(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

//MARK: Extensions

extension documentViewController: SearchTableViewControllerDelegate {
    func searchTableViewController(_ searchTableViewController: SearchTableViewController, didSelectSerchResult selection: PDFSelection) {
        selection.color = UIColor.yellow
        documentViewer.currentSelection = selection
        documentViewer.go(to: selection)
    }
}
