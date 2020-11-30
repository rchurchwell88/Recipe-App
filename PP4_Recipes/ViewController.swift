//
//  ViewController.swift
//  PP4_Recipes
//
//  Created by Russell Churchwell on 11/25/20.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        testPushUser()
    }
    
    func testPushUser(){
        Auth.auth().createUser(withEmail: "worked@worked.com", password: "password", completion: nil)
    }

}

