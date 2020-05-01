//
//  bookmarksViewController.swift
//  IIF Documentos
//
//  Created by Brandon Gonzalez on 29/04/20.
//  Copyright © 2020 Brandon Gonzalez. All rights reserved.
//

import UIKit
import PDFKit

struct myDictionary {
    static var Bookmarks : [Any] = []
}

class bookmarksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Outlets
    
    let reuseDocument = "DocumentCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: bookmarksViewControllerDelegate?
    
    let theMainDic = UserDefaults.standard.value(forKey: "MainDic")
    
    var dictionary = myDictionary.Bookmarks as! [[String:Any]]
    
    //MARK: viewDid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkDataSource()
        setupTableView()
        
    }
    
    //MARK: Funcs
    
    func checkDataSource() {
        
        if theMainDic == nil {
            
            dictionary = myDictionary.Bookmarks as! [[String:Any]]
            
        } else {
            
            dictionary = theMainDic as! [[String:Any]]
            
        }
        
    }
    
    func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        let documentXib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(documentXib, forCellReuseIdentifier: reuseDocument)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let newBookmark = ["Title" : "\(name ?? "")", "Texto" : "\(documentViewer.currentSelection?.string ?? "")", "Date" : "\(date)", "Pagina":"\(mainDocument.index(for: documentViewer.currentPage!))", "Image":"\(image!)"] as [String:Any]
//
        let document = dictionary[indexPath.row]
        
        let title = document["Title"]
        let text = document["Texto"]
        let page = document["Pagina"]
        let pdfName = document["PDF"]
        
        let myViewController = bookMarkDetailViewController(nibName: "bookMarkDetailViewController", bundle: nil)
        myViewController.fillDocumentName = title as! String
        myViewController.fillText = text as! String
        myViewController.fillPage = "\(page!)"
        myViewController.PDFName = pdfName as! String
        
        present(myViewController, animated: true, completion: nil)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        dictionary.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseDocument, for: indexPath) as! TableViewCell
        
        dictionary.sort { ($0["Date"] as! String) > ($1["Date"] as! String) }
        
        let document = dictionary[indexPath.row]
        
        let title = document["Title"] as? String ?? ""
        let text = document["Texto"] as? String ?? ""
        cell.title.text = title
        cell.piedeOfText.text = text
        
        return cell
        
    }
    
    //MARK: Buttons
    
}
