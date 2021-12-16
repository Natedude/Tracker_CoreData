//
//  EntryTableViewCell.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/10/21.
//  Copyright © 2021 Nathan Hildum. valll rights reserved.
//

import Foundation
import UIKit

// (CocoaCasts)
class EntryTableViewCell: UITableViewCell {
	// MARK: - Properties
	static let reuseIdentifier = "EntryCell"
	var sv: UIView!
	
	// MARK: - Outlets
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var substanceLabel: UILabel!
	@IBOutlet weak var amountLabel: UILabel!
	
	// MARK: - Initialization
	override func awakeFromNib() {
		super.awakeFromNib()
		self.sv = self.superview
		
//		print("EntryTableViewCell/awakeFromNib: self.amountLabel=\(self.amountLabel)")
		guard /*let timeLabel = self.timeLabel,*/
			let substanceLabel = self.substanceLabel,
			let amountLabel = self.amountLabel
			else {
				print("EntryTableViewCell/awakeFromNib: labels nil ERROR")
				return
		}
//		print("EntryTableViewCell/awakeFromNib: AFTER amountLabel=\(amountLabel)")
		
		let align = NSTextAlignment.right
		substanceLabel.textAlignment = align
		amountLabel.textAlignment = align
/*		ERROR
		2021-12-16 03:55:48.968695-0800 Tracker_CoreData[5736:6188357] *** Terminating app due to uncaught exception 'NSGenericException', reason: 'Unable to install constraint on view.  Does the constraint reference something from outside the subtree of the view?  That's illegal. constraint:
		<NSLayoutConstraint:0x600002c17660 UITableViewCellContentView:0x7fbb53da3980.leading == 0.5*UILabel:0x7fbb53da7780'mg'.leading + 1   (active)>
		view:
			<UILabel: 0x7fbb53da7780;
				frame = (1 12; 70 21);
				text = 'mg';
				opaque = NO;
				autoresize = RM+BM;
				userInteractionEnabled = NO;
				tintColor = <UIDynamicSystemColor: 0x600000f57100;
				name = systemGreenColor>;
				layer = <_UILabelLayer: 0x600002c15e50>>'
*/
		print("EntryTableViewCell/awakeFromNib: ran")

		
//		amountLabel.setConstraintCustom(
//			val: CGFloat(0.5),
//			att1: Edge.leading.layoutAttribute,
//			att2: Edge.leading.layoutAttribute)
//		amountLabel.setConstraints(
//			lead: 50
////			trail: CGFloat?,
////			top: 12,
////			bottom: 11,
////			width: 70
////			height: 13)
//		)
	}
} // end class




//
//// make editing constraints easy
//extension UIView {
//	// Programmatic Constraints Inspired by
//	// https://cocoacasts.com/working-with-auto-layout-and-layout-anchors
//	func setConstraint(
//		val: CGFloat? = nil,
//		att: NSLayoutConstraint.Attribute
////		subview: UIView
////		superview: UIView
//	) {
//		guard let superview = self.superview else {
//			print("EntryTableViewCell/setConstrains: superview nil")
//			return
//		}
//		if let val = val {
//			print("setConstraint: val = \(val), type=\(type(of: val))")
//			self.addConstraint( NSLayoutConstraint(
//				item: self,
//				attribute: att,
//				relatedBy: .equal,
//				toItem: superview,
//				attribute: .notAnAttribute,
//				multiplier: val,
//				constant: 1)
//			)
//		}
//	}
//
//	func setConstraints(
//		lead: CGFloat? = nil
////		trail: CGFloat? = nil,
////		top: CGFloat? = nil,
////		bottom: CGFloat? = nil,
////		width: CGFloat? = nil,
////		height: CGFloat? = nil
//	) {
//		if let lead = lead {
//			self.setConstraint(
//				val: CGFloat(lead),
//				att: NSLayoutConstraint.Attribute.leading
////				subview: self
////				superview: superview
//			)
//		}
////		if let trail = trail {
////			self.setConstraint(
////				val: CGFloat(trail),
////				att: NSLayoutConstraint.Attribute.trailing,
////				subview: self
//////				superview: superview
////			)
////		}
////		if let top = top {
////			self.setConstraint(
////				val: CGFloat(top),
////				att: NSLayoutConstraint.Attribute.bottom,
////				subview: self
//////				superview: superview
////			)
////		}
////		if let bottom = bottom {
////			self.setConstraint(
////				val: CGFloat(bottom),
////				att: NSLayoutConstraint.Attribute.top,
////				subview: self
//////				superview: superview
////			)
////		}
////		if let width = width {
////			self.setConstraint(
////				val: CGFloat(width),
////				att: NSLayoutConstraint.Attribute.top,
////				subview: self
//////				superview: superview
////			)
////		}
////		if let height = height {
////			self.setConstraint(
////				val: CGFloat(height),
////				att: NSLayoutConstraint.Attribute.top,
////				subview: self
//////				superview: superview
////			)
////		}
//	}
//}
