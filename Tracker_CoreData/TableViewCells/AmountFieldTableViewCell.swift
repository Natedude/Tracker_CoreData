//
//  AmountFieldTableViewCell.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/15/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//

import Foundation
import UIKit

// Design inspired by Custom Cells TableView video: https://www.youtube.com/watch?v=bYcfZdoCRe8
class AmountFieldTableViewCell: UITableViewCell, UITextFieldDelegate {
	// MARK: - Properties
	static let reuseIdentifier = "AmountFieldTableViewCell"
	@IBOutlet weak var textField: CurrencyTextField!
	@IBOutlet weak var label: UILabel!
	var stringWrapper: StringWrapper!
	
	static func nib() -> UINib {
		return UINib(nibName: "AmountFieldTableViewCell",
		bundle: nil)
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//		self.textField.delegate = self
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	// When text field has finished being edited by the user,
	// set the wrapped string to the input amount string
	// UITextFieldDelegate inspired by Scott McKenzie's answer on https://stackoverflow.com/questions/49752220/get-data-from-custom-tableview-cell-text-field
	func textFieldDidEndEditing(_ textField: UITextField) {
		guard let inputText = textField.text else {
			print("AmountFieldTableViewCell/textFieldDidEndEditing: textField.text nil")
			return
		}
		stringWrapper.wrappedString = inputText
	}
    
	// Limit allowed characters in text field to numerics and '.'
	// Taken from Patrick Lin's answer on https://stackoverflow.com/questions/27215495/limit-uitextfield-input-to-numbers-in-swift
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		// remove non-numerics and compare with original string
		return string == string.filter("0123456789.".contains)
	}
	
}
