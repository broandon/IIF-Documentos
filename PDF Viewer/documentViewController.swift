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
    var delegate: getOut?
    
    //MARK: Outlets
    
    var image: UIImage?
    var stringStarting: String?
    var searchedItem: PDFSelection?
    var mainDocument: PDFDocument!
    var pdfdocument: PDFDocument?
    
    let documentName = UserDefaults.standard.value(forKey: "documentName") as! String
    
    @IBOutlet weak var documentViewer: PDFView!
    @IBOutlet weak var documentVisualAid: UIImageView!
    
    //MARK: viewDid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDocumentViewer()
        optionsButton()
        
        addCustomMenu()
        
    }
    
    //MARK: Funcs
    
    func addCustomMenu() {
        
        let printThisToConsole = UIMenuItem(title: "Añadir Bookmark", action: #selector(printToConsole))
        
        UIMenuController.shared.menuItems = [printThisToConsole]
        
    }
    
    @objc func printToConsole() {
        
        let currentTextAndPage = "The selection is: \(documentViewer.currentSelection?.string ?? "") and the page is: \(mainDocument.index(for: documentViewer.currentPage!))"
        
        print(currentTextAndPage)
        
    }
    
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
            
            self.searchButtonClick()
            
            floaty.close()
        })
        self.view.addSubview(floaty)
        
    }
    
    func searchButtonClick() {
        let searchViewController = SearchTableViewController()
        searchViewController.pdfDocument = mainDocument
        searchViewController.delegate = self
        
        let nav = UINavigationController(rootViewController: searchViewController)
        self.present(nav, animated: true, completion:nil)
    }
    
    //MARK: Buttons
    
    @IBAction func close(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func highlight(_ sender: Any) {
        
        guard let selections = documentViewer.currentSelection?.selectionsByLine()
            else {
                
                let alert = UIAlertController(title: "Marcatexto", message: "Para usar el marcatexto primero selecciona el texto.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
                
                return
                
        }
        
        selections.forEach({ selection in
            selection.pages.forEach({ page in
                let highlight = PDFAnnotation(bounds: selection.bounds(for: page), forType: .highlight, withProperties: nil)
                highlight.color = .yellow
                page.addAnnotation(highlight)
            })
        })
        
        let path = Bundle.main.url(forResource: documentName, withExtension: "pdf")
        
        documentViewer.document?.write(to: path!)
        
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

extension PDFView{
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == Selector(("_lookup:")) ||
            action == Selector(("_define:")) {
            
            return false
            
        }
        
        if action == #selector(copy(_:)) {
            
            return true
            
        }
        return false
    }
    
}
