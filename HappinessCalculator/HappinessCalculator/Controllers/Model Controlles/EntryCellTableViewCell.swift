//
//  EntryCellTableViewCell.swift
//  NotificationPatternsJournal
//
//  Created by Hin Wong on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

protocol EntryCellTableViewCellDelegate: class {
    func switchToggledOnCell(cell: EntryCellTableViewCell)
}

class EntryCellTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var higherOrLowerLabel: UILabel!
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    
    // MARK: - Properties
    var entry: Entry?
    weak var delegate: EntryCellTableViewCellDelegate?
    
    // MARK: - Helper functions
    
    func setEntry(entry: Entry, averageHappiness: Int) {
        self.entry = entry
        updateUI(averageHappiness: averageHappiness)
    }
    
    @objc func updateUI(averageHappiness: Int) {
        guard let entry = entry else {return}
        titleLabel.text = entry.title
        isEnabledSwitch.isOn = entry.isIncluded
        
        // Update higherOrLowerLabel after notifications
        higherOrLowerLabel.text = entry.happiness >= averageHappiness ? "Higher" : "Lower"
    }
    
    func createObserver () {
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: notificationKey, object: nil)
    }
    
    @IBAction func toggledIsIncluded(_ sender: Any) {
        delegate?.switchToggledOnCell(cell: self)
    }
    
}
