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
	// in Patrick Lin's answer ona https://stackoverflow.com/questions/27215495/limit-uitextfield-input-to-numbers-in-swift
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
//
		
		// if enter alpha char does move period
		// if there is a dot move it
		// but we dont want to move dot if non numeric entered
		let str = string.filter("0123456789".contains)
		print("str.isEmpty = \(str.isEmpty)")
		if !str.isEmpty {
			let rangeOfDot = input.range(of: ".")
			guard let r1 = rangeOfDot else {
				print("shouldChangeCharactersIn: r1 = rangeOfDot error")
				return true
			}
			input.remove(at: r1.lowerBound)
			input.insert(".", at: r1.upperBound)
			
			let rangeOf0 = input.range(of: "0")
			let r0 = rangeOf0 ?? nil
			if r0 != nil {
				input.remove(at: r0!.lowerBound)
			}
			input = input + str
		}
		
		stringWrapper.wrappedString = input
		print("shouldChangeCharactersIn: stringWrapper.wrappedString = \(stringWrapper.wrappedString)")
		return true
	}
}
