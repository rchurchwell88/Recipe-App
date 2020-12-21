//
//  RecDetViewController.swift
//  PP4_Recipes
//
//  Created by Russell Churchwell on 12/17/20.
//

import UIKit

class RecDetViewController: UIViewController {
    
   
    var data:RecData?
    var recText="-----------\nINGREDIENTS\n-----------\n\n"

    @IBOutlet weak var descriptOutlet: UILabel!
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBAction func popSaf(_ sender: UIButton) {
        let url = URL(string: data!.rUrl!)
        UIApplication.shared.open(url!)
    }
    
    @IBAction func bDismiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segWV(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toWV", sender: self)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as?WebViewVC
        
        dest?.data=data
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.title=data?.recName
        descriptOutlet.sizeToFit()
        
        appendRecDet()
    }
    
    func appendRecDet(){
        let top = data?.ingredients
        let middle = data?.warning
        
        for each in top!{
            let tmp = each["text"] as? String
            
            recText.append(tmp!+"\n\n")
        }
        
        recText.append("\n---------\nWARNINGS\n---------\n\n")
        
        for each in middle!{
            let tmp = each+"\n\n"
            
            recText.append(tmp)
            
        }
        
        
        descriptOutlet.text=recText
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
