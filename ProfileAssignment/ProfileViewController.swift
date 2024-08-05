//
//  ViewController.swift
//  ProfileAssignment
//
//  Created by Muhammad Bilal Shakoor on 8/5/24.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProfile()
    }

    
    func fetchProfile() {
        let users = DataHelper.shared.fetchData()
        if let userProfile = users.first {
            user = userProfile
            nameLabel.text = userProfile.name
            emailLabel.text = userProfile.email
            phoneLabel.text = userProfile.phone
            detailsTextView.text = userProfile.details
        }
    }
    
    @IBAction func onTapEditButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editVC = storyboard.instantiateViewController(withIdentifier: "EditScreenViewController") as! EditScreenViewController
        editVC.isEditable = true
        editVC.user = user
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    


}

