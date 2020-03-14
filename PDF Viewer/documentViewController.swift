//
//  documentViewController.swift
//  IIF Documentos
//
//  Created by Brandon Gonzalez on 12/03/20.
//  Copyright © 2020 Brandon Gonzalez. All rights reserved.
//

import UIKit
import PDFKit

class documentViewController: UIViewController, PDFDocumentDelegate {
    
    //MARK: Outlets
    
    var image: UIImage?
    var searchedItem: PDFSelection?
    var mainDocument: PDFDocument!
    
    let documentName = UserDefaults.standard.value(forKey: "documentName") as! String
    
    @IBOutlet weak var documentViewer: PDFView!
    @IBOutlet weak var documentVisualAid: UIImageView!
    @IBOutlet weak var search: UITextField!
    
    //MARK: viewDid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(documentName)
        
        guard let path = Bundle.main.url(forResource: documentName, withExtension: "pdf") else { return }
        
        mainDocument = PDFDocument(url: path)
        documentViewer.document = mainDocument
        documentViewer.document?.delegate = self
        documentViewer.autoScales = true
        
        documentVisualAid.image = image
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let searchText = search.text!
                
        self.mainDocument.beginFindString(searchText, withOptions: .caseInsensitive)
        
    }
    
    //MARK: Funcs
    
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
        
        self.dismiss(animated: true, completion: {
            
            print("Gone")
            
        })
        
    }
    
    
    
}

//MARK: Extensions
