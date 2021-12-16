//
//  EntryTableViewCell.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/10/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//

import Foundation
import UIKit

// (CocoaCasts)
class EntryTableViewCell: UITableViewCell {
	// MARK: - Properties
	static let reuseIdentifier = "EntryCell"
	
	// MARK: - Outlets
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var substanceLabel: UILabel!
	
	// MARK: - Initialization
	override func awakeFromNib() {
		super.awakeFromNib()
	}
}
