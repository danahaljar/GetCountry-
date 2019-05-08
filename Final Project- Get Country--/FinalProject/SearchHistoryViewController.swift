

import UIKit
import CoreData

class SearchHistoryViewController: UITableViewController {
    
    func displayAlert(title:String, message:String?) {
        
        if let message = message {
            let alert = UIAlertController(title: title, message: "\(message)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    @IBOutlet var historyTableView: UITableView!
    var cityArray:[String] = []

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newUser =  NSEntityDescription.insertNewObject(forEntityName: "History", into: context)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if (results.count > 0) {
                for result in results as! [NSManagedObject]{
                    if let city = result.value(forKey: "city") as? String {
                        cityArray.append(city)
                    }
                }
                
                print(cityArray)
                
            }
            print("Data is feteched")
        }
        catch {
            displayAlert(title: "Alert", message: "an error has occured")
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! UITableViewCell
        cell.textLabel?.text = cityArray[indexPath.row]
        return cell
    }
    

}
