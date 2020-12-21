//
//  RecData.swift
//  PP4_Recipes
//
//  Created by Russell Churchwell on 12/12/20.
//

import Foundation

class RecData{
    var recName:String?
    var recCalories:String?
    var rUrl:String?
    var ingredients: [[String:Any]]?
    var warning:[String]?
    
    init(rName:String, rCalories:String, url:String, ingr:[[String:Any]], cau:[String]) {
        recName=rName
        recCalories=rCalories
        rUrl=url
        ingredients=ingr
        warning=cau
    }
}
