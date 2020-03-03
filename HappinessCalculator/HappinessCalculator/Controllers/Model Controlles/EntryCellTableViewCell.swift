//
//  EntryCellTableViewCell.swift
//  NotificationPatternsJournal
//
//  Created by Hin Wong on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

// declaring a protocol and allowing to use class level object
protocol EntryCellTableViewCellDelegate: class {
    
    //  creating a job that the boss, or tableViewCell, can tell our intern, or tableViewController, to do
    func switchToggledOnCell(cell: EntryCellTableViewCell)
}

class EntryCellTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var higherOrLowerLabel: UILabel!
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    
    // MARK: - Properties
    var entry: Entry?
    
    // declaring a delegate (creating our intern), creating runner that tell our intern to do something
    weak var delegate: EntryCellTableViewCellDelegate?
    
    // MARK: - Helper functions
    
    func setEntry(entry: Entry, averageHappiness: Int) {
        self.entry = entry
        updateUI(averageHappiness: averageHappiness)
        createObserver()
    }
    
    func updateUI(averageHappiness: Int) {
        guard let entry = entry else {return}
        titleLabel.text = entry.title
        isEnabledSwitch.isOn = entry.isIncluded
        
        // Update higherOrLowerLabel after notifications
        higherOrLowerLabel.text = entry.happiness >= averageHappiness ? "Higher" : "Lower"
    }
    
    func createObserver () {
        // Creating our person who will listen for our notification, then call recalculate happiness
        NotificationCenter.default.addObserver(self, selector: #selector(recalculateHappiness), name: notificationKey, object: nil)
    }
    
    @objc func recalculateHappiness(notification: NSNotification) {
        guard let averageHappiness = notification.object as? Int else {return}
        updateUI(averageHappiness: averageHappiness)
    }
    
    @IBAction func toggledIsIncluded(_ sender: Any) {
        // Telling our delegate to go tell our intern to do something
        delegate?.switchToggledOnCell(cell: self)
    }
}
