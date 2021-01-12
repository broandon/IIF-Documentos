//
//  settingsTableViewController.swift
//  IIF Documentos
//
//  Created by Brandon Gonzalez on 16/03/20.
//  Copyright © 2020 Brandon Gonzalez. All rights reserved.
//

import UIKit

class settingsTableViewController: UITableViewController {
    
    //MARK: Outlets
    
    //MARK: viewDid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: Buttons
    
    @IBAction func logOut(_ sender: Any) {
        
        let alert = UIAlertController(title: "¿Borrar todo?", message: "Esto borrará tu nombre, tus marcadores y otra información. ¿Continuar?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Reiniciar", style: .default, handler: { action in
                                   
            UserDefaults.standard.set(false, forKey: "loggedIn")
            
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            UserDefaults.standard.synchronize()
            
            guard let rootVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginViewController") as? loginViewController else {
                return
            }
            
            UIApplication.shared.windows.first?.rootViewController = rootVC
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
        }))
        
        self.present(alert, animated: true)

    }
    
}

//MARK: Extensions
