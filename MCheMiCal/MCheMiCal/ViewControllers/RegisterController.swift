//
//  RegisterController.swift
//  MCheMiCal
//
//  Created by Marchel Hermanliansyah on 01/05/23.
//

import UIKit
import CoreData

class RegisterController: UIViewController {

    @IBOutlet weak var usernameTXT: UITextField!
    @IBOutlet weak var passwordTXT: UITextField!
    @IBOutlet weak var rePasswordTXT: UITextField!
    @IBOutlet weak var dateTXT: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func isFutureDate(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let currentDate = Date()
        return calendar.compare(date, to: currentDate, toGranularity: .day) == .orderedDescending
    }

    @IBAction func onSignUp(_ sender: Any) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Account", in: managedContext)!
        let newAccount = NSManagedObject(entity: entity, insertInto: managedContext)
        
        if (usernameTXT.text!.count > 10) {
            Util.showToast(message: "Length of username must not be greater than 10")
            return
        }
        
        if (isFutureDate(dateTXT.date)) {
            Util.showToast(message: "Date must not be later than today")
            return
        }
        
        if(rePasswordTXT.text!.isEqual(passwordTXT.text) == false) {
            Util.showToast(message: "Password do not match")
            return
        }
        
        newAccount.setValue(dateTXT.date, forKey: "dob")
        newAccount.setValue(usernameTXT.text, forKey: "username")
        newAccount.setValue(passwordTXT.text, forKey: "password")
        
        do {
            try managedContext.save()	
            Util.showToast(message: "Account successfully made!")
            let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "LoginPage") as! ViewController
            self.navigationController?.pushViewController(storyboard, animated: true)
        } catch let error as NSError {
            Util.showToast(message: "Unknown error! Failed to save the data!")
        }
        
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "LoginPage") as! ViewController
        self.navigationController?.pushViewController(storyboard, animated: true)
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
