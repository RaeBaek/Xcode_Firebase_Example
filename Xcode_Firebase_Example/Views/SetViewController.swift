//
//  SetViewController.swift
//  Xcode_Firebase_Example
//
//  Created by 백래훈 on 2022/04/18.
//

import UIKit

class SetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - @IBActions
    @IBAction func backButtonDidTab(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
