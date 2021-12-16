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
	
	static let reuseIdentifier = "AmountTableViewCell"
	var stringWrapper: StringWrapper!
	
	static func nib() -> UINib {
		return UINib(nibName: "AmountTableViewCell",
					 bundle: nil)
	}
	
//	func configure(str: String){
//		
//	}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
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
		guard let inputText = textField.text else {
			print("AmountFieldTableViewCell/shouldChangeCharactersIn: textField.text nil")
			return true
		}
		stringWrapper.wrappedString = inputText
		print("stringWrapper.wrappedString = \(stringWrapper.wrappedString)")
		return true
	}
}
