//
//  documentViewController.swift
//  IIF Documentos
//
//  Created by Brandon Gonzalez on 12/03/20.
//  Copyright © 2020 Brandon Gonzalez. All rights reserved.
//

import UIKit
import PDFKit

class documentViewController: UIViewController {
        
    //MARK: Outlets
    
    @IBOutlet weak var documentViewer: PDFView!
    
    //MARK: viewDid
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        guard let path = Bundle.main.url(forResource: "CNPP", withExtension: "pdf") else { return }
        
        let document = PDFDocument(url: path)
        documentViewer.document = document
                
        documentViewer.go(to: documentViewer.currentSelection!)
        
    }
    
    //MARK: Funcs
    
    //MARK: Buttons

}

//MARK: Extensions
