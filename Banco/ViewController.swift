//
//  ViewController.swift
//  Banco
//
//  Created by Joel Palomares Jasso on 4/21/19.
//  Copyright © 2019 Joel Palomares Jasso. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tblBanks: UITableView!
    var banksLists = [BankModel]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bank = banksLists[indexPath.row]
        let alertController = UIAlertController(title: bank.name, message: "Give new values to update banks", preferredStyle: .alert)
       
        let updateAction = UIAlertAction(title: "Update", style:.default) { (_) in
            let id = bank.id
            let name = alertController.textFields?[0].text
            let city = alertController.textFields?[1].text
            let manager = alertController.textFields?[2].text
            let money = alertController.textFields?[3].text
            
            self.updateBank(id: id!, name: name!, city: city!, manager:manager!, money: money!)
        }
        let deleteAction = UIAlertAction(title: "Delete", style:.default) { (_) in
            self.deleteBank(id: bank.id!)
        }
        alertController.addTextField { (textField) in
            textField.text = bank.name
        }
        alertController.addTextField { (textField) in
            textField.text = bank.city
        }
        alertController.addTextField { (textField) in
            textField.text = bank.manager
        }
        alertController.addTextField { (textField) in
            textField.text = bank.money
        }
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true, completion: nil)
    }
    func updateBank(id: String, name: String, city: String, manager: String, money: String ){
        let bank = [
            "id": id,
            "bankName" : name,
            "bankCiudad" : city,
            "bankGerente" : manager,
            "bankMoneda": money
        ]
        refBanks.child(id).setValue(bank)
        labelMessage.text = "Bank Update"
    }
    func deleteBank(id: String){
        refBanks.child(id).setValue(nil)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return banksLists.count
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170.0
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! ViewcontrollerTableViewCell
        let bank : BankModel
        bank = banksLists[indexPath.row]
        cell.lblName.text = bank.name
        cell.lblCity.text = bank.city
        cell.lblManager.text = bank.manager
        cell.lblMoney.text = bank.money
        
        return cell
    }
    
    var refBanks = DatabaseReference.init()
    
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var textFielName: UITextField!
    
    @IBOutlet weak var textFieldCiudad: UITextField!
    
    @IBOutlet weak var textFieldGerente: UITextField!
    
    @IBOutlet weak var textFieldMoneda: UITextField!
    
    @IBAction func buttonAddBank(_ sender: Any) {
        addBanks()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refBanks = Database.database().reference().child("banks")
        refBanks.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.banksLists.removeAll()
                for banks in snapshot.children.allObjects as![DataSnapshot]{
                    let banksObject = banks.value as? [String:  AnyObject]
                    let bankName = banksObject? ["bankName"]
                    let bankCiudad = banksObject? ["bankCiudad"]
                    let bankGerente = banksObject? ["bankGerente"]
                    let bankMoneda = banksObject? ["bankMoneda"]
                    let bankId = banksObject? ["id"]
                    
                    let bank = BankModel (id: bankId as! String?, name: bankName as! String?, city: bankCiudad as! String?, manager: bankGerente as! String?, money: bankMoneda as! String?)
                    self.banksLists.append(bank)
                }
               self.tblBanks.reloadData()
            }
        })
    }
    
    func addBanks(){
        let key = refBanks.childByAutoId().key
        let banks = ["id": key,
                     "bankName": textFielName.text! as String,
                     "bankCiudad" : textFieldCiudad.text! as String,
                     "bankGerente" : textFieldGerente.text! as String,
                     "bankMoneda" : textFieldMoneda.text! as String]
        refBanks.child(key!).setValue(banks)
        labelMessage.text = "Bank Added"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

