//
//  ViewController.swift
//  TODO App Realm
//
//  Created by Khushali Vagadia on 29/07/23.
//

import RealmSwift
import UIKit

class Contact: Object{
    @Persisted var firstname: String
    @Persisted var lastname: String
    
   convenience init(firstname: String, lastname: String) {
       self.init()
       self.firstname = firstname
       self.lastname = lastname
   }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var contactTableView: UITableView!
    
    var contactArray = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configuration()
    }
    
    @IBAction func addContactButtonTapped(_ sender: UIBarButtonItem) {
        
        contactConfiguration(isAdd: true, index: 0)
        /// ADD
    }
}

extension ViewController {
    
    func configuration() {
        contactTableView.delegate = self
        contactTableView.dataSource = self
        contactTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func contactConfiguration(isAdd: Bool, index: Int){
        
        let alertController = UIAlertController(title: isAdd ? "Add Contact" : "Update Contact", message: isAdd ? "Please enter your contact details" : "Please update your contact details", preferredStyle: .alert)
        
        let save = UIAlertAction(title: isAdd ? "Save" : "Update", style: .default) { _ in
            if let firstname = alertController.textFields?.first?.text,
               let lastname = alertController.textFields?[1].text{
                let contact = Contact(firstname: firstname, lastname: lastname)
                
                if isAdd{
                    self.contactArray.append(contact)
                    DatabaseHelper.shared.saveContact(contact: contact)
                }else{
                    self.contactArray[index] = contact
                }
                self.contactTableView.reloadData()
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addTextField() { firstnameField in
            /// FIRST NAME Placeholder
            
            firstnameField.placeholder = isAdd ? "Enter your firstname" : self.contactArray[index].firstname
            
        }
        
        alertController.addTextField() { lastnameField in
            /// LAST NAME Placeholder
            
            lastnameField.placeholder = isAdd ? "Enter your lastname" : self.contactArray[index].lastname
         }
        
        alertController.addAction(save)
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = contactArray[indexPath.row].firstname
        cell.detailTextLabel?.text = contactArray[indexPath.row].lastname
        return cell
    }
}
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") { _, _, _ in
            
            self.contactConfiguration(isAdd: false, index: indexPath.row)
            ///UPDATE
        }
        edit.backgroundColor = .systemMint
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.contactArray.remove(at: indexPath.row)
            self.contactTableView.reloadData()
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [delete, edit])
        return swipeConfiguration
    }
}





/// ADD

/*      let alertController = UIAlertController(title: "Add Contact", message: "Please enter your contact details", preferredStyle: .alert)
      let save = UIAlertAction(title: "Save", style: .default) { _ in
          if let firstname = alertController.textFields?.first?.text,
             let lastname = alertController.textFields?[1].text{
              let contact = Contact(firstname: firstname, lastname: lastname)
              self.contactArray.append(contact)
              self.contactTableView.reloadData()
          }
      }
      let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      
      alertController.addTextField() { firstnameField in
          firstnameField.placeholder = "Enter your firstname"
      }
      
      alertController.addTextField() { lastnameField in
          lastnameField.placeholder = "Enter your lastname"
      }
      
      alertController.addAction(save)
      alertController.addAction(cancel)
      
      present(alertController, animated: true)
  */



/// UPDATE

/*       let alertController = UIAlertController(title: "Update Contact", message: "Please update your contact details", preferredStyle: .alert)
       let save = UIAlertAction(title: "Save", style: .default) { _ in
           if let firstname = alertController.textFields?.first?.text,
              let lastname = alertController.textFields?[1].text{
               let contact = Contact(firstname: firstname, lastname: lastname)
             //  self.contactArray.append(contact)
               self.contactArray[indexPath.row] = contact
               self.contactTableView.reloadData()
           }
       }
       let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
       
       alertController.addTextField() { firstnameField in
           firstnameField.placeholder = self.contactArray[indexPath.row].firstname
       }
       
       alertController.addTextField() { lastnameField in
           lastnameField.placeholder = self.contactArray[indexPath.row].lastname
       }
       
       alertController.addAction(save)
       alertController.addAction(cancel)
       
       self.present(alertController, animated: true)
 */

    /// FIRST NAME Placeholder

//           if isAdd{
//                firstnameField.placeholder = "Enter your firstname"
//            }else{
//                firstnameField.placeholder = self.contactArray[index].firstname
//               }
 

    /// LAST NAME Placeholder

//            if isAdd{
//                lastnameField.placeholder = "Enter your lastname"
//            }else{
//                lastnameField.placeholder = self.contactArray[index].lastname
//            }
