//
//  AccountVC.swift
//  PP4_Recipes
//
//  Created by Russell Churchwell on 12/6/20.
//

import UIKit
import Firebase

class AccountVC: UIViewController {
    
    var user: User?

    @IBOutlet weak var emailO: UILabel!
    @IBOutlet weak var uidO: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailO.text = "Email: \(user?.email?.description ?? "nope")"
        
        uidO.text = "UID: \(user?.uid.description ?? "nope")"
    }
    
}
