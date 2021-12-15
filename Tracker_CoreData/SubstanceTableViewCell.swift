//
//  SubstanceTableViewCell.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/14/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//

import Foundation
import UIKit

// (CocoaCasts)
class SubstanceTableViewCell: UITableViewCell {
	// MARK: - Properties
	static let reuseIdentifier = "SubstanceCell"
	
	// MARK: -
	@IBOutlet weak var substanceLabel: UILabel!
	
	// MARK: - Initialization
	override func awakeFromNib() {
		super.awakeFromNib()
	}
}
