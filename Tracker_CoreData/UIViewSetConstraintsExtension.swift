////
////  UIViewSetConstraintsExtension.swift
////  Tracker_CoreData
////
////  Created by Nathan Hildum on 12/16/21.
////  Copyright © 2021 Nathan Hildum. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//
//class Test {
//	var label = UILabel()
//	init(){
////		guard /*let timeLabel = self.timeLabel,*/
////			let label = self.label else {
////				print("EntryTableViewCell/awakeFromNib: labels nil ERROR")
////				return
////		}
//		let label = self.label
//
//		label.setConstraintCustom(
//			val: CGFloat(0.5),
//			att1: Edge.leading.layoutAttribute,
//			att2: Edge.leading.layoutAttribute)
//
////		let myView = UIView()
////		let superview2 = UIView()
////		myView.backgroundColor = UIColor.red
////		self.addSubview(myView)
////		myView.translatesAutoresizingMaskIntoConstraints = false
////
////		self.addConstraint(
////			NSLayoutConstraint(
////				item: superview2,
////				attribute: .trailingMargin,
////				relatedBy: .equal,
////				toItem: self,
////				attribute: .trailingMargin,
////				multiplier: 1,
////				constant: 0))
//	}
//}
//
//// not working :-(
//// looking CALayer? https://www.raywenderlich.com/10317653-calayer-tutorial-for-ios-getting-started
//// make editing constraints easy
//extension UIView {
//	// Programmatic Constraints Inspired by
//	// https://cocoacasts.com/working-with-auto-layout-and-layout-anchors
//	func setConstraintCustom(
//		val: CGFloat? = nil,
//		att1: NSLayoutConstraint.Attribute,
//		att2: NSLayoutConstraint.Attribute
////		edge1: Edge,
////		edge2: Edge
//		//		subview: UIView
//		//		superview: UIView
//	) {
//		guard let superview = self.superview else {
//			print("EntryTableViewCell/setConstrains: superview nil")
//			return
//		}
//		if let val = val {
//			print("setConstraint: val = \(val), type=\(type(of: val))")
//			self.addConstraint(
//				NSLayoutConstraint(
//					item: superview,
//					attribute: att1,
//					relatedBy: .equal,
//					toItem: self,
//					attribute: att2,
//					multiplier: val,
//					constant: 1)
//				)
//		}
//
////		let myView = UIView()
////		let superview2 = UIView()
////		myView.backgroundColor = UIColor.red
////		self.addSubview(myView)
////		myView.translatesAutoresizingMaskIntoConstraints = false
////
////		self.addConstraint(
////			NSLayoutConstraint(
////				item: superview2,
////				attribute: .trailingMargin,
////				relatedBy: .equal,
////				toItem: self,
////				attribute: .trailingMargin,
////				multiplier: 1,
////				constant: 0))
//	}
//
////	func setConstraintsCustom(
////		lead: Double?
////		//		trail: CGFloat? = nil,
////		//		top: CGFloat? = nil,
////		//		bottom: CGFloat? = nil,
////		//		width: CGFloat? = nil,
////		//		height: CGFloat? = nil
////	) {
////		if let lead = lead {
////			self.setConstraintCustom(
////				val: CGFloat(lead),
////				att1: NSLayoutConstraint.Attribute,
////				att2: NSLayoutConstraint.Attribute
//////				edge1: .left,
//////				edge2: .
////				//				subview: self
////				//				superview: superview
////			)
////		}
////		//		if let trail = trail {
////		//			self.setConstraint(
////		//				val: CGFloat(trail),
////		//				att: NSLayoutConstraint.Attribute.trailing,
////		//				subview: self
////		////				superview: superview
////		//			)
////		//		}
////		//		if let top = top {
////		//			self.setConstraint(
////		//				val: CGFloat(top),
////		//				att: NSLayoutConstraint.Attribute.bottom,
////		//				subview: self
////		////				superview: superview
////		//			)
////		//		}
////		//		if let bottom = bottom {
////		//			self.setConstraint(
////		//				val: CGFloat(bottom),
////		//				att: NSLayoutConstraint.Attribute.top,
////		//				subview: self
////		////				superview: superview
////		//			)
////		//		}
////		//		if let width = width {
////		//			self.setConstraint(
////		//				val: CGFloat(width),
////		//				att: NSLayoutConstraint.Attribute.top,
////		//				subview: self
////		////				superview: superview
////		//			)
////		//		}
////		//		if let height = height {
////		//			self.setConstraint(
////		//				val: CGFloat(height),
////		//				att: NSLayoutConstraint.Attribute.top,
////		//				subview: self
////		////				superview: superview
////		//			)
////		//		}
////	}
//}
//
//// https://github.com/novoda/ios-demos/blob/master/UIView%2BAutolayout.swift
//
//enum Edge {
//	case top
//	case left
//	case bottom
//	case right
//	case leading
//	case trailing
//
//	var layoutAttribute: NSLayoutConstraint.Attribute {
//		switch self {
//			case .top:
//				return .top
//			case .bottom:
//				return .bottom
//			case .left:
//				return .left
//			case .right:
//				return .right
//			case .leading:
//				return .leading
//			case .trailing:
//				return .trailing
////			case .right:
////				return .right
////			case .right:
////				return .right
//		}
//	}
//}
//
//// MARK: Pin superview
//extension UIView {
//	func pinToSuperview(edges: [Edge], constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.required) {
//		for edge in edges {
//			switch edge {
//				case .top: pinToSuperviewTop(withConstant: constant, priority: priority)
//				case .left: pinToSuperviewLeft(withConstant: constant, priority: priority)
//				case .bottom: pinToSuperviewBottom(withConstant: constant, priority: priority)
//				case .right: pinToSuperviewRight(withConstant: constant, priority: priority)
//				case .leading:
//				<#code#>
//				case .trailing:
//				<#code#>
//			}
//		}
//	}
//
//	@discardableResult func pinToSuperviewTop(withConstant constant: CGFloat = 0,
//											  priority: UILayoutPriority = UILayoutPriority.required,
//											  relatedBy relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
//		guard let superview = self.superview else {
//			preconditionFailure("view has no superview")
//		}
//
//		return pinTop(to: superview, constant: constant, priority: priority, relatedBy: relation)
//	}
//
//	@discardableResult func pinToSuperviewLeft(withConstant constant: CGFloat = 0,
//											   priority: UILayoutPriority = UILayoutPriority.required,
//											   relatedBy relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
//		guard let superview = self.superview else {
//			preconditionFailure("view has no superview")
//		}
//
//		return pinLeft(to: superview, constant: constant, priority: priority, relatedBy: relation)
//	}
//
//	@discardableResult func pinToSuperviewRight(withConstant constant: CGFloat = 0,
//												priority: UILayoutPriority = UILayoutPriority.required,
//												relatedBy relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
//		guard let superview = self.superview else {
//			preconditionFailure("view has no superview")
//		}
//
//		return pinRight(to: superview, constant: constant, priority: priority, relatedBy: relation)
//	}
//
//	@discardableResult func pinToSuperviewBottom(withConstant constant: CGFloat = 0,
//												 priority: UILayoutPriority = UILayoutPriority.required,
//												 relatedBy relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
//		guard let superview = self.superview else {
//			preconditionFailure("view has no superview")
//		}
//
//		return pinBottom(to: superview, constant: -constant, priority: priority, relatedBy: relation)
//	}
//
//	@discardableResult func limitFromSuperviewBottom(withMinimumConstant constant: CGFloat = 0,
//													 priority: UILayoutPriority = UILayoutPriority.required) -> NSLayoutConstraint {
//		guard let superview = self.superview else {
//			preconditionFailure("view has no superview")
//		}
//
//		let constraint = superview.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: constant)
//		constraint.priority = priority
//		constraint.isActive = true
//
//		return constraint
//	}
//
//	@discardableResult func limitFromSuperviewRight(withMinimumConstant constant: CGFloat = 0,
//													priority: UILayoutPriority = UILayoutPriority.required) -> NSLayoutConstraint {
//		guard let superview = self.superview else {
//			preconditionFailure("view has no superview")
//		}
//
//		let constraint = superview.rightAnchor.constraint(greaterThanOrEqualTo: rightAnchor, constant: constant)
//		constraint.priority = priority
//		constraint.isActive = true
//
//		return constraint
//	}
//
//	func pinToSuperviewEdges(withConstant constant: CGFloat = 0) {
//		guard let superview = self.superview else {
//			preconditionFailure("view has no superview")
//		}
//
//		pinTop(to: superview, constant: constant)
//		pinBottom(to: superview, constant: constant)
//		pinLeft(to: superview, constant: constant)
//		pinRight(to: superview, constant: constant)
//	}
//}
//
//// MARK: Pin sibling views
//extension UIView {
//	@discardableResult func pinTop(to view: UIView,
//								   constant: CGFloat = 0,
//								   priority: UILayoutPriority = UILayoutPriority.required,
//								   relatedBy relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
//		return pin(edge: .top, to:.top, of: view, constant: constant, priority: priority, relatedBy: relation)
//	}
//
//	@discardableResult func pinBottom(to view: UIView,
//									  constant: CGFloat = 0,
//									  priority: UILayoutPriority = UILayoutPriority.required,
//									  relatedBy relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
//		return pin(edge: .bottom, to:.bottom, of: view, constant: constant, priority: priority, relatedBy: relation)
//	}
//
//	@discardableResult func pinLeft(to view: UIView,
//									constant: CGFloat = 0,
//									priority: UILayoutPriority = UILayoutPriority.required,
//									relatedBy relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
//		return pin(edge: .left, to:.left, of: view, constant: constant, priority: priority, relatedBy: relation)
//	}
//
//	@discardableResult func pinRight(to view: UIView,
//									 constant: CGFloat = 0,
//									 priority: UILayoutPriority = UILayoutPriority.required,
//									 relatedBy relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
//		return pin(edge: .right, to:.right, of: view, constant: constant, priority: priority, relatedBy: relation)
//	}
//
//	func pinEdges(to view: UIView) {
//		pin(edge: .left, to: .left, of: view)
//		pin(edge: .right, to: .right, of: view)
//		pin(edge: .top, to: .top, of: view)
//		pin(edge: .bottom, to: .bottom, of: view)
//	}
//
//	@discardableResult func pin(edge: Edge,
//								to otherEdge: Edge,
//								of view: UIView,
//								constant: CGFloat = 0,
//								priority: UILayoutPriority = UILayoutPriority.required,
//								relatedBy relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
//		guard let superview = self.superview else {
//			preconditionFailure("view has no superview")
//		}
//
//		translatesAutoresizingMaskIntoConstraints = false
//		if view !== superview {
//			view.translatesAutoresizingMaskIntoConstraints = false
//		}
//
//		let constraint = NSLayoutConstraint(item: self,
//											attribute: edge.layoutAttribute,
//											relatedBy: relation,
//											toItem: view,
//											attribute: otherEdge.layoutAttribute,
//											multiplier: 1,
//											constant: constant)
//		constraint.priority = priority
//		superview.addConstraint(constraint)
//		return constraint
//	}
//
//}
//
//// MARK: - Size Constraint
//extension UIView {
//
//	@discardableResult func addMaxWidthConstraint(with constant: CGFloat,
//												  priority: UILayoutPriority = UILayoutPriority.required) -> NSLayoutConstraint {
//
//		return addWidthConstraint(with: constant, priority: priority, relatedBy: .lessThanOrEqual)
//	}
//
//	@discardableResult func addMinWidthConstraint(with constant: CGFloat,
//												  priority: UILayoutPriority = UILayoutPriority.required) -> NSLayoutConstraint {
//
//		return addWidthConstraint(with: constant, priority: priority, relatedBy: .greaterThanOrEqual)
//	}
//
//	@discardableResult func addWidthConstraint(with constant: CGFloat,
//											   priority: UILayoutPriority = UILayoutPriority.required,
//											   relatedBy relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
//		translatesAutoresizingMaskIntoConstraints = false
//
//		let constraint = NSLayoutConstraint(item: self,
//											attribute: .width,
//											relatedBy: relation,
//											toItem: nil,
//											attribute: .notAnAttribute,
//											multiplier: 1,
//											constant: constant)
//		constraint.priority = priority
//		addConstraint(constraint)
//		return constraint
//
//	}
//
//	@discardableResult func addHeightConstraint(with constant: CGFloat,
//												priority: UILayoutPriority = UILayoutPriority.required,
//												relatedBy relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
//		translatesAutoresizingMaskIntoConstraints = false
//
//		let constraint = NSLayoutConstraint(item: self,
//											attribute: .height,
//											relatedBy: relation,
//											toItem: nil,
//											attribute: .notAnAttribute,
//											multiplier: 1,
//											constant: constant)
//		constraint.priority = priority
//		addConstraint(constraint)
//		return constraint
//
//	}
//
//}
//
//// MARK: Center superview
//extension UIView {
//
//	@discardableResult func centerYToSuperview(withConstant constant: CGFloat = 0,
//											   priority: UILayoutPriority = UILayoutPriority.required,
//											   relatedBy relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
//		guard let superview = self.superview else {
//			preconditionFailure("view has no superview")
//		}
//
//		translatesAutoresizingMaskIntoConstraints = false
//
//		let constraint = NSLayoutConstraint(item: self,
//											attribute: .centerY,
//											relatedBy: relation,
//											toItem: superview,
//											attribute: .centerY,
//											multiplier: 1,
//											constant: constant)
//		constraint.priority = priority
//		superview.addConstraint(constraint)
//		return constraint
//	}
//
//	@discardableResult func centerXToSuperview(withConstant constant: CGFloat = 0,
//											   priority: UILayoutPriority = UILayoutPriority.required,
//											   relatedBy relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
//		guard let superview = self.superview else {
//			preconditionFailure("view has no superview")
//		}
//
//		translatesAutoresizingMaskIntoConstraints = false
//
//		let constraint = NSLayoutConstraint(item: self,
//											attribute: .centerX,
//											relatedBy: relation,
//											toItem: superview,
//											attribute: .centerX,
//											multiplier: 1,
//											constant: constant)
//		constraint.priority = priority
//		superview.addConstraint(constraint)
//		return constraint
//	}
//}
