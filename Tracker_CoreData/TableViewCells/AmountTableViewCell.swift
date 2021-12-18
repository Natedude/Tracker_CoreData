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
//		print("input = \(input)")
//		input = input.filter("0123456789.".contains)
////		let added = filtered + string
//		let text = self.textField.text ?? "shChChIn"
//		text.
//		print("string = \(string)")
//		print("final = \(final)")
		let rangeOfDot = input.range(of: ".")
		guard let r1 = rangeOfDot else {
			print("shouldChangeCharactersIn: r = range error")
			return true
		}
		input.remove(at: r1.lowerBound)
		input.insert(".", at: r1.upperBound)
		
		let rangeOf0 = input.range(of: "0") //first?
		guard let r0 = rangeOf0 else {
			print("shouldChangeCharactersIn: r = range error")
			return true
		}
		input.remove(at: r0.lowerBound)
		var str = string.filter("0123456789.".contains)
		if str.isEmpty {
			str = "0"
		}
		input = input + str
//		let char = input[r.lowerBound] //worked
//		let charAtIdx = input[idx]
		
//		let idx = inputText.
//		print("input =  \(input)")
//		print("char =  \(char)")
		stringWrapper.wrappedString = input
		print("shouldChangeCharactersIn: stringWrapper.wrappedString = \(stringWrapper.wrappedString)")
		return true
	}
}
