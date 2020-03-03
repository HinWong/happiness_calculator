//
//  EntryCellTableViewCell.swift
//  NotificationPatternsJournal
//
//  Created by Hin Wong on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

class EntryCellTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var higherOrLowerLabel: UILabel!
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    
    // MARK: - Properties
    var entry: Entry?
    
    // MARK: - Helper functions
    
    func setEntry(entry: Entry, averageHappiness: Int) {
        self.entry = entry
    }
    
    func updateUI(averageHappiness: Int) {
        guard let entry = entry else {return}
        titleLabel.text = entry.title
        isEnabledSwitch.isOn = entry.isIncluded
        
        // Update higherOrLowerLabel after notifications
    }
    
    
}
