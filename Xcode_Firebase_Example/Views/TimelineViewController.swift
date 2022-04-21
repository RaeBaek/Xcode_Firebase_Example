//
//  TimelineViewController.swift
//  Xcode_Firebase_Example
//
//  Created by 백래훈 on 2022/04/18.
//

import UIKit

class TimelineViewController: UIViewController {

    @IBOutlet weak var timeLineTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        timeLineTableView.delegate = self
        timeLineTableView.dataSource = self
        
    }
    
    @IBAction func backButtonDidTab(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Functions
    func setUI() {
        
    }
    
}

extension TimelineViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    
    
}
