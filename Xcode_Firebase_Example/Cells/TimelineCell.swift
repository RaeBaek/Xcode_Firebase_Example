//
//  TimelineCell.swift
//  Xcode_Firebase_Example
//
//  Created by 백래훈 on 2022/04/21.
//

import UIKit

class TimelineCell: UITableViewCell {

    @IBOutlet weak var sensingLabel: UILabel!
    @IBOutlet weak var timelineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        sensingLabel.text = ""
        timelineLabel.text = ""
        
    }

}
