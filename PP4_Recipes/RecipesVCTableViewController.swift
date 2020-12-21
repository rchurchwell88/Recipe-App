//
//  RecipesVCTableViewController.swift
//  PP4_Recipes
//
//  Created by Russell Churchwell on 12/6/20.
//

import UIKit
import Foundation

class RecipesVCTableViewController: UITableViewController {
    
    var recDataArray=[RecData]()
    var recipeDict:[String:Any]?
    var testArray=[String]()
    var rowC:Int?
    var category:String?
    var data:RecData?
    
    @IBOutlet var TV: UITableView!
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        category=category?.replacingOccurrences(of: "+", with: " ")
        
        navBar.title=category!.uppercased()
        
        category=category?.replacingOccurrences(of: " ", with: "+")
        
        testXcode()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return testArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        data=recDataArray[indexPath.row]
        
        performSegue(withIdentifier: "toRecDet", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as? RecDetViewController
        
        dest?.data=data
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let tmpObject = recDataArray[indexPath.row]
        
        cell.textLabel?.text = tmpObject.recName
        cell.detailTextLabel?.text = "Calories: \(tmpObject.recCalories ?? "N/A")"

        return cell
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func testXcode() {
        let apiURL = URL(string: "https://api.edamam.com/search?q=\(category!)&app_id=30e0d68d&app_key=0531cb22561b686283b1db6e1bf7b9c5&from=0&to=3")!
        let session = URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
            let top = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:Any]
            
            let middle = top["hits"] as? [[String:Any]]
            
            for each in middle!{
                // try to append string to string array using hardcode for now
                let recTop = each["recipe"] as? [String:Any]
                let recName = recTop!["label"] as? String
                let calString = recTop!["calories"] as? Double
                let url = recTop!["url"] as? String
                let ingreds = recTop!["ingredients"] as? [[String:Any]]
                let warnings = recTop!["cautions"] as? [String]
                
                self.recDataArray.append(RecData(rName: recName!, rCalories: Int(calString!).description, url: url!, ingr: ingreds!, cau: warnings!))
                
                
                self.testArray.append(recName!)
            }
            
            DispatchQueue.main.async {
                self.TV.reloadData()
            }
        }
        
        session.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func testPull() -> [String:Any]{
//
//        var tmpDict = [String:Any]()
//
//        let apiURL = URL(string: "https://api.edamam.com/search?q=mexican&app_id=30e0d68d&app_key=0531cb22561b686283b1db6e1bf7b9c5&from=0&to=1")!
//
//        let session = URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
//            let top = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:Any]
//
//            let middle = top["hits"] as? [[String:Any]]
//
//            for each in middle!{
//                let test = each["recipe"] as! [String:Any]
//
//                tmpDict.updateValue(test, forKey: test["label"] as! String)
//
//
//                print()
//            }
//        }
//
//        session.resume()
//        return tmpDict
//    }
}
