//
//  HomeController.swift
//  MCheMiCal
//
//  Created by Marchel Hermanliansyah on 01/05/23.
//

import UIKit
import CoreData

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var names  = [String]()
    var descs  = [String]()
    var prices = [String]()
    
    var context:NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        tableView.delegate = self
        tableView.dataSource = self
        loadData()	
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let chemical = names[indexPath.row]
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Chemical")
            request.predicate = NSPredicate(format: "name = %@", chemical)
            do {
                let result = try context.fetch(request)
                if result.count > 0 {
                    context.delete(result[0] as! NSManagedObject)
                    try context.save()
                    names.remove(at: indexPath.row)
                    descs.remove(at: indexPath.row)
                    prices.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    Util.showToast(message: "Chemical successfully deleted!")
                }
            } catch {
                Util.showToast(message: "Unknown error! Failed to delete data!")
            }
        }
    }


    @IBAction func onInsert(_ sender: Any) {
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "InsertPage") as! InsertController
        self.navigationController?.pushViewController(storyboard, animated: true)
    }		
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let updateController = storyboard.instantiateViewController(withIdentifier: "UpdatePage") as! UpdateController
        
        updateController.name = names[indexPath.row]
        
            updateController.updateHandler = { updatedName, updatedDesc, updatedPrice in
                self.names[indexPath.row] = updatedName
                self.descs[indexPath.row] = updatedDesc
                self.prices[indexPath.row] = updatedPrice
                self.tableView.reloadData()
            }
            
            self.navigationController?.pushViewController(updateController, animated: true)
        }
    
    func loadData() {
        names.removeAll()
        descs.removeAll()
        prices.removeAll()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Chemical")
        
        do {
            let results = try context.fetch(fetchRequest) as! [NSManagedObject]
            
            for data in results {
                if let name = data.value(forKey: "name") as? String,
                   let desc = data.value(forKey: "desc") as? String,
                   let price = data.value(forKey: "price") as? String {
                    names.append(name)
                    descs.append(desc)
                    prices.append(price)
                }
            }
            
            tableView.reloadData()
        } catch {
            print("Failed to fetch chemicals from CoreData")
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "Cell"
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MiCheMiCalTableViewCell
        // onBindViewHolder
        cell.nameLbl.text = names[index]
        cell.descLbl.text = descs[index]
        // String manipulation #1
        var priceText = "$\(prices[index])/pound"
        cell.priceLbl.text = priceText
        return cell
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
