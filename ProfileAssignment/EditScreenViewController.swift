//
//  EditScreen.swift
//  ProfileAssignment
//
//  Created by Muhammad Bilal Shakoor on 8/5/24.
//

import UIKit
import CoreData


class EditScreenViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
    var isEditable = Bool()
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let user = user {
                   nameTextField.text = user.name
                   phoneTextField.text = user.phone
                   emailTextField.text = user.email
                   detailsTextView.text = user.details
               }
        
    }
    
    @IBAction func onTapSaveButton(_ sender: Any) {
        guard let user = user else { return }
        let dict: [String: String] = [
                   "name": nameTextField.text ?? "",
                   "phone": phoneTextField.text ?? "",
                   "email": emailTextField.text ?? "",
                   "details": detailsTextView.text ?? ""
               ]
               
//               if isEditable, let user = user {
//                   DataHelper.shared.editData(objects: dict, userId: user.objectID)
//               } else {
//                   DataHelper.shared.saveData(objects: dict)
//               }
        DataHelper.shared.editData(objects: dict, userId: user.objectID)
               
               navigateToProfileScreen()
    }
    
    func navigateToProfileScreen() {
        navigationController?.popViewController(animated: true)
    }
}

