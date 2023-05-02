//
//  UpdateController.swift
//  MCheMiCal
//
//  Created by Marchel Hermanliansyah on 01/05/23.
//

import UIKit
import CoreData

class UpdateController: UIViewController {

    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var descTF: UITextField!
    @IBOutlet weak var priceTF: UITextField!
    
    var name: String?
    
    var updateHandler: ((String, String, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onUpdateClicked(_ sender: Any) {
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
           
        // Update the corresponding values in the array (in the HomeController)
        updateHandler?(nameTF.text!, descTF.text!, priceTF.text!)

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Chemical")
        request.predicate = NSPredicate(format: "name = %@", self.name!)
        do {
            let results = try context.fetch(request) as! [NSManagedObject]
            if results.count > 0 {
                let chemical = results[0]
                chemical.setValue(nameTF.text!, forKey: "name")
                chemical.setValue(descTF.text!, forKey: "desc")
                chemical.setValue(priceTF.text!, forKey: "price")
                try context.save()
                Util.showToast(message: "Chemical successfully updated")
            }
        } catch {
            Util.showToast(message: "Error updating chemical")
        }
           navigationController?.popViewController(animated: true)
        // reset
            self.name = nil
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
