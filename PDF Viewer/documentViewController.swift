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
    var name: String?
    
    var theMainDic = UserDefaults.standard.value(forKey: "MainDic")
    
    let documentName = UserDefaults.standard.value(forKey: "documentName") as? String
        
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
        
        if theMainDic == nil {
            
            print("This shit don't exist.")
            print(theMainDic)
            
            let dicValue : [[String:Any]] = []
            
            UserDefaults.standard.set(dicValue, forKey: "MainDic")
            
            print("Here we create it and give it an empty existence")
            print(theMainDic)
            
            theMainDic =  UserDefaults.standard.value(forKey: "MainDic")
            
            print("Here we update it, i guess, idk")
            print(theMainDic)
            
            var dic = theMainDic as! [[String:Any]]
            
            let date = Date()
                    
            let newBookmark = ["Title" : "\(name ?? "")", "Texto" : "\(documentViewer.currentSelection?.string ?? "")", "Date" : "\(date)"] as [String:Any]
            
            dic.append(newBookmark)
            
            print("Here it should appear with the appended shit")
            print(dic)
                            
            let savedBookmarks = dic
            
            UserDefaults.standard.set(savedBookmarks, forKey: "MainDic")
            if let loadedTasks = UserDefaults.standard.array(forKey: "MainDic") as? [[String: Any]] {
                print(loadedTasks)
            }
            
            let alert = UIAlertController(title: "Nuevo marcador", message: "Tu nuevo marcador ha sido guardado con exito. ¿Quieres continuar aqui o ir a tus marcadores?", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Continuar", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Ir a Marcadores", style: .default, handler: { action in
                
                let myViewController = bookmarksViewController(nibName: "bookmarksViewController", bundle: nil)
                self.present(myViewController, animated: true, completion: nil)
                
            }))

            self.present(alert, animated: true)
                    
            
            return
            
        }
        
        print("The dic exists")
        
        var dic = theMainDic as! [[String:Any]]
                        
        let currentTextAndPage = "The selection is: \(documentViewer.currentSelection?.string ?? "") and the page is: \(mainDocument.index(for: documentViewer.currentPage!))"
        
        let date = Date()
                
        let newBookmark = ["Title" : "\(name ?? "")", "Texto" : "\(documentViewer.currentSelection?.string ?? "")", "Date" : "\(date)"] as [String:Any]
        
        dic.append(newBookmark)
                        
        let savedBookmarks = dic
        
        UserDefaults.standard.set(savedBookmarks, forKey: "MainDic")
        if let loadedTasks = UserDefaults.standard.array(forKey: "MainDic") as? [[String: Any]] {
            print(loadedTasks)
        }
        
        let alert = UIAlertController(title: "Nuevo marcador", message: "Tu nuevo marcador ha sido guardado con exito. ¿Quieres continuar aqui o ir a tus marcadores?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Continuar", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Ir a Marcadores", style: .default, handler: { action in
            
            let myViewController = bookmarksViewController(nibName: "bookmarksViewController", bundle: nil)
            self.present(myViewController, animated: true, completion: nil)
            
        }))

        self.present(alert, animated: true)
                
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
