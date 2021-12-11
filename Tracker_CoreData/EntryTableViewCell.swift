//
//  EntryTableViewCell.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/10/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//

import Foundation
import UIKit

class EntryTableViewCell: UITableViewCell {
	// MARK: - Properties
	static let reuseIdentifier = "EntryCell"
	
	// MARK: -
	@IBOutlet var timeLabel: UILabel!
	@IBOutlet var substanceLabel: UILabel!
	
	// MARK: - Initialization
	override func awakeFromNib() {
		super.awakeFromNib()
	}
}
