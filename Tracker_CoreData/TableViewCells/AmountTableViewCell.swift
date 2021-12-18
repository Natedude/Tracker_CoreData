//
//  TestTableViewCell.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/15/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//

import UIKit

class AmountTableViewCell: UITableViewCell, UITextFieldDelegate {
	@IBOutlet weak var textField: CurrencyTextField!
	var format = NumberFormatter()
	
	static let reuseIdentifier = "AmountTableViewCell"
	var stringWrapper: StringWrapper!
	
	static func nib() -> UINib {
		return UINib(nibName: "AmountTableViewCell",
					 bundle: nil)
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		format.numberStyle = .decimal  // 	EDITED by Nathan Hildum on 12/15/21.
		format.minimumFractionDigits = 2
		format.maximumFractionDigits = 2
		// align placeholder text to the right in textField
		let align = NSTextAlignment.right
		self.textField.textAlignment = align
		
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	// Inspired by demo of use of shouldChangeCharacterIn UITextFieldDelegate func
	// in Patrick Lin's answer on https://stackoverflow.com/questions/27215495/limit-uitextfield-input-to-numbers-in-swift
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//		print("AmountTableViewCell/shouldChangeCharactersIn:")
		guard var input = textField.text else {
			print("textField.text nil")
			return true
		}
		input = input.filter("0123456789.".contains)

		/*
		input range stuff inspired by https://stackoverflow.com/questions/32305891/index-of-a-substring-in-a-string-with-swift
		*/
		let rangeOf0 = input.range(of: "0")
		let r0 = rangeOf0 ?? nil
		if r0 != nil {
			//
			input.remove(at: r0!.lowerBound)
			
			//no zero so we dont move dot
//			let rangeOfDot = input.range(of: ".")
//			guard let r1 = rangeOfDot else {
//				print("shouldChangeCharactersIn: r = range error")
//				return true
//			}
//			input.remove(at: r1.lowerBound)
//			input.insert(".", at: r1.upperBound)
		}
		
		// if enter alpha char does move period
		// if there is a dot move it
		// but we dont want to move dot if non numeric entered TODO
		let str = string.filter("0123456789.".contains)
		print("str.isEmpty = \(str.isEmpty)")
		if !str.isEmpty {
			let rangeOfDot = input.range(of: ".")
			guard let r1 = rangeOfDot else {
				print("shouldChangeCharactersIn: r1 = rangeOfDot error")
				return true
			}
			input.remove(at: r1.lowerBound)
			input.insert(".", at: r1.upperBound)
		}
//		let rangeOfDot = input.range(of: ".")
//		guard let r1 = rangeOfDot else {
//			print("shouldChangeCharactersIn: r1 = rangeOfDot error")
//			return true
//		}
//		input.remove(at: r1.lowerBound)
//		input.insert(".", at: r1.upperBound)
		
		
//		print("string = \(string)")
//		let text = self.textField.text ?? "error"
//		print("text = \(text)")
//		let rangeOfComma = text.range(of: ",")
//		let rComma = rangeOfComma ?? nil
//		if rComma == nil{
//			print("rComma = rangeOfComma nil")
//			
//		} else {
//			input.remove(at: rComma!.lowerBound)
//			input.insert(",", at: rComma!.upperBound)
//		}
		
			//			let rangeOfDot = input.range(of: ".")
			//			guard let r1 = rangeOfDot else {
			//				print("shouldChangeCharactersIn: r = range error")
			//				return true
			//			}
			//			input.remove(at: r1.lowerBound)
			//			input.insert(".", at: r1.upperBound)
//		11
		
		
//		let rangeOf0 = input.range(of: "0")
//		guard let r0 = rangeOf0 else {
//			print("shouldChangeCharactersIn: r = range error")
//			return true
//		}
//		input.remove(at: r0.lowerBound)
//
//		input.insert(char, at: r0.upperBound)
		
//		let r0 = rangeOf0
//		{
//			print("shouldChangeCharactersIn: r0 = range0 is nil error")
//			is0 = false
////			return false
//		}
//		input.remove(at: r0.lowerBound)
		let num = string.filter("0123456789.".contains)// if letter entered
		if !num.isEmpty {
//			if r0 == nil {
				input = input + num
//			}
		} else {
			
		}
		
		
		stringWrapper.wrappedString = input
		print("shouldChangeCharactersIn: stringWrapper.wrappedString = \(stringWrapper.wrappedString)")
		return true
	}
}
