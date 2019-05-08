
import UIKit
import CoreData

class UserInterfaceViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var enteredDataTextField: UITextField!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    func displayAlert(title:String, message:String?) {
        
        if let message = message {
            let alert = UIAlertController(title: title, message: "\(message)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
         self.enteredDataTextField.delegate = self
    }

    @IBAction func getCountryName(_ sender: Any) {

        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        DispatchQueue.main.async {
            self.loadURL(userInput: self.enteredDataTextField.text!)
        }
        
        
    }
    
    func textFieldShouldReturn(_ enteredDataTextField: UITextField) -> Bool {
        enteredDataTextField.resignFirstResponder()
        return true
    }
    
    func loadURL(userInput: String) {
        
        if (userInput == "") {
             displayAlert(title: "Alert", message: "Please enter a city")
        }
        
        else {
            do {
                
                var result = FinalProject.getCountryName(input: userInput)
                
                if result != "error" {
                    countryLabel.text = result
                }
                else if result == "error" {
                   displayAlert(title: "Alert", message: "an error has occured")
                }
                
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let newUser =  NSEntityDescription.insertNewObject(forEntityName: "History", into: context)
                
                newUser.setValue(enteredDataTextField.text!, forKey: "city")
                
                do {
                    try context.save()
                    print("Saved.")
                }
                catch {
                    print("Error.")
                }
                
                
            }
            catch {
               displayAlert(title: "Alert", message: "an error has occured")
            }
            
        }
        
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        
        
    }
    
    
    
}

