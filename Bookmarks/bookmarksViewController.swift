//
//  bookmarksViewController.swift
//  IIF Documentos
//
//  Created by Brandon Gonzalez on 29/04/20.
//  Copyright © 2020 Brandon Gonzalez. All rights reserved.
//

import UIKit

struct myDictionary {
    static var Bookmarks : [Any] = []
}

class bookmarksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Outlets
    
    let reuseDocument = "DocumentCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    let theMainDic = UserDefaults.standard.value(forKey: "MainDic")
    
    var dictionary = myDictionary.Bookmarks as! [[String:Any]]
    
    //MARK: viewDid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkDataSource()
        setupTableView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        updateTableContentInset()
        
    }
    
    //MARK: Funcs
    
    func updateTableContentInset() {
        let numRows = self.tableView.numberOfRows(inSection: 0)
        var contentInsetTop = self.tableView.bounds.size.height
        for i in 0..<numRows {
            let rowRect = self.tableView.rectForRow(at: IndexPath(item: i, section: 0))
            contentInsetTop -= rowRect.size.height
            if contentInsetTop <= 0 {
                contentInsetTop = 0
            }
        }
        self.tableView.contentInset = UIEdgeInsets(top: contentInsetTop,left: 0,bottom: 0,right: 0)
    }
    
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
