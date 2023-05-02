//
//  InsertController.swift
//  MCheMiCal
//
//  Created by Marchel Hermanliansyah on 01/05/23.
//

import UIKit
import CoreData

class InsertController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var descTF: UITextField!
    @IBOutlet weak var priceTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onInsertClicked(_ sender: Any) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Chemical", in: managedContext)!
            let newChemical = NSManagedObject(entity: entity, insertInto: managedContext)
        
        if (nameTF.text!.count > 15) {
            Util.showToast(message: "Name must not be longer than 15 characters")
            return
        }
        
        if (descTF.text!.count > 30) {
                Util.showToast(message: "Description must not be longer than 30 characters")
                return
        }
        
        if (priceTF.text!.isNumeric == false) {
            Util.showToast(message: "Price must be a number")
            return
        }
        
        newChemical.setValue(nameTF.text, forKey: "name")
        newChemical.setValue(descTF.text, forKey: "desc")
        
        // Calculation#1
        if let price = Double(priceTF.text ?? "") {
            let discountedPrice = price / 2.0
            let formattedPrice = String(format: "%d", Int(discountedPrice))
            newChemical.setValue(formattedPrice, forKey: "price")
        } else {
            Util.showToast(message: "Price must be a number")
            return
        }
        
        do {
            try managedContext.save()
            Util.showToast(message: "Chemical successfully added")
            Util.showToast(message: "Price is deducted 50% because you'll have to store the money to Gus Fring")
            let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "HomePage") as! HomeController
            self.navigationController?.pushViewController(storyboard, animated: true)
        } catch {
            Util.showToast(message: "Error saving chemical")
        }
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension String {
    var isNumeric: Bool {
        return Double(self) != nil
    }
}

