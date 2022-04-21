//
//  ViewController.swift
//  Xcode_Firebase_Example
//
//  Created by 백래훈 on 2022/04/11.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFirebase()
        
    }
    
    @IBAction func didBackButton(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func setFirebase() {
        
        let db = Database.database().reference()
        
        db.child("Test").observeSingleEvent(of: .value) {snapshot in
            print("---> \(snapshot)")
            let value = snapshot.value as? String ?? ""
            DispatchQueue.main.async {
                self.testLabel.text = value
            }
        }
    }
    
    
}

