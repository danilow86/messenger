//
//  ViewController.swift
//  Messenger
//
//  Created by danilo on 08/10/2023.
//

import UIKit
import SwiftUI

import FirebaseAuth

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        DatabaseManager.shared.insertUser(with: <#T##ChatAppUser#>)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      
        validateAuth()
    }
    
    private func  validateAuth(){
        if FirebaseAuth.Auth.auth().currentUser == nil{
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController :vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
}

