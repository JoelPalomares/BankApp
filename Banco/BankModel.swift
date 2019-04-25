//
//  BankModel.swift
//  Banco
//
//  Created by Joel Palomares Jasso on 4/21/19.
//  Copyright © 2019 Joel Palomares Jasso. All rights reserved.
//

import Foundation
class BankModel{
    var id : String?
    var name : String?
    var city : String?
    var manager : String?
    var money : String?
    init(id : String?, name: String?, city: String?,manager:String?, money:String?){
        self.id = id
        self.name = name
        self.city = city
        self.manager = manager
        self.money = money
    }
    
}
