//
//  CurrencyTextField.swift
//  CurrencyTextFieldDemo
//  https://github.com/richa008/CurrencyTextField
//
//  Created by Deshmukh,Richa on 6/2/16.
//  Copyright © 2016 Richa. All rights reserved.
//
//  EDITED by Nathan Hildum on 12/15/21.

import Foundation
import UIKit

@IBDesignable open class CurrencyTextField : UITextField {
	
	private let maxDigits = 12
	private var defaultValue = 0.00
	private let currencyFormatter = NumberFormatter()
	private var previousValue = ""
	
	var value: Double {
		get { return Double(getCleanNumberString()) ?? 0 / 100 }
		set { setAmount(newValue) }
	}
	
	// MARK: - init functions
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
		initTextField()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initTextField()
	}
	
	func initTextField(){
		self.keyboardType = UIKeyboardType.decimalPad
		currencyFormatter.numberStyle = .decimal  // 	EDITED by Nathan Hildum on 12/15/21.
		currencyFormatter.minimumFractionDigits = 2
		currencyFormatter.maximumFractionDigits = 2
		setAmount(defaultValue)
	}
	
//	{
//	CGRect newbounds = bounds;
//	CGSize size = [[self placeholder] sizeWithAttributes:
//	@{NSFontAttributeName: self.font}];
//	int width =  bounds.size.width - size.width;
//	newbounds.origin.x = width ;
//	newbounds.size.width = size.width;
//	return newbounds;
//	}
	
	// MARK: - UITextField Notifications
	
	override open func willMove(toSuperview newSuperview: UIView?) {
		if newSuperview != nil {
			NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: self)
		} else {
			NotificationCenter.default.removeObserver(self)
		}
	}
	
	@objc private func textDidChange(_ notification: Notification) {
		let cursorOffset = getOriginalCursorPosition()
		let cleanNumericString = getCleanNumberString()
		let textFieldLength = text?.count
		let textFieldNumber = Double(cleanNumericString)
//		print(getString())
		
		if cleanNumericString.count <= maxDigits && textFieldNumber != nil {
			setAmount(textFieldNumber! / 100)
		} else {
			text = previousValue
		}
		
		setCursorOriginalPosition(cursorOffset, oldTextFieldLength: textFieldLength)
	}
	
	//MARK: - Custom text field functions
	
	private func setAmount (_ amount : Double){
		let textFieldStringValue = currencyFormatter.string(from: NSNumber(value: amount))
		text = textFieldStringValue
		textFieldStringValue.flatMap { previousValue = $0 }
	}
	
	//MARK - helper functions
	
//	private func getString() -> String{
//		return text?.components(separatedBy: CharacterSet(charactersIn: "0123456789.,").inverted).joined() ?? ""
//	}
	
	private func getCleanNumberString() -> String {
		return text?.components(separatedBy: CharacterSet(charactersIn: "0123456789").inverted).joined() ?? ""
	}
	
	private func getOriginalCursorPosition() -> Int{
		guard let selectedTextRange = selectedTextRange else { return 0 }
		return offset(from: beginningOfDocument, to: selectedTextRange.start)
	}
	
	private func setCursorOriginalPosition(_ cursorOffset: Int, oldTextFieldLength : Int?) {
		let newLength = text?.count
		let startPosition = beginningOfDocument
		if let oldTextFieldLength = oldTextFieldLength, let newLength = newLength, oldTextFieldLength > cursorOffset {
			let newOffset = newLength - oldTextFieldLength + cursorOffset
			let newCursorPosition = position(from: startPosition, offset: newOffset)
			if let newCursorPosition = newCursorPosition {
				let newSelectedRange = textRange(from: newCursorPosition, to: newCursorPosition)
				selectedTextRange = newSelectedRange
			}
		}
	}
}
