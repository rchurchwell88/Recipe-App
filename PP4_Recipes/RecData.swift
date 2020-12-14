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
    
    init(rName:String, rCalories:String, url:String) {
        recName=rName
        recCalories=rCalories
        rUrl=url
    }
}
