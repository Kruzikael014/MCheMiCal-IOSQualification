//
//  ViewController.swift
//  MCheMiCal
//
//  Created by Marchel Hermanliansyah on 01/05/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            // Fetch the account with the given username and password
            let request = NSFetchRequest<Account>(entityName: "Account")
            request.predicate = NSPredicate(format: "username = %@ AND password = %@", usernameTF.text!, passwordTF.text!)
            do {
                let results = try context.fetch(request)
                
                if results.count > 0 {
                    let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "HomePage") as! HomeController
                    self.navigationController?.pushViewController(storyboard, animated: true)
                    Util.showToast(message: "Welcome \(results[0].username!)")
                } else {
                    Util.showToast(message: "Login failed, make sure you have prompted correct credentials!")
                }
            } catch {
                Util.showToast(message: "Unknown error! Failed to fetch login data!")
            }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "RegisterPage") as! RegisterController
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
}

