//
//  TestTableViewCell.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/15/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//

import UIKit

class TestTableViewCell: UITableViewCell, UITextFieldDelegate {
	@IBOutlet weak var textField: CurrencyTextField!
	
	static let reuseIdentifier = "TestTableViewCell"
	var stringWrapper: StringWrapper!
	
	static func nib() -> UINib {
		return UINib(nibName: "TestTableViewCell",
					 bundle: nil)
	}
	
//	func configure(str: String){
//		
//	}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		let align = NSTextAlignment.right
		self.textField.textAlignment = align
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		guard let inputText = textField.text else {
			print("AmountFieldTableViewCell/shouldChangeCharactersIn: textField.text nil")
			return true
		}
		stringWrapper.wrappedString = inputText
		print("stringWrapper.wrappedString = \(stringWrapper.wrappedString)")
		return true
	}
	
	// When text field has finished being edited by the user,
	// set the wrapped string to the input amount string
	// UITextFieldDelegate inspired by Scott McKenzie's answer on https://stackoverflow.com/questions/49752220/get-data-from-custom-tableview-cell-text-field
//	func textFieldDidEndEditing(_ textField: UITextField) {
//		guard let inputText = textField.text else {
//			print("AmountFieldTableViewCell/textFieldDidEndEditing: textField.text nil")
//			return
//		}
//		stringWrapper.wrappedString = inputText
//	}
    
}
