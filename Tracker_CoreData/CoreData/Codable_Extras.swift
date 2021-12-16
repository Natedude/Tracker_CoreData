//
//  Codable_Extras.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/15/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//

enum DecoderConfigurationError: Error {
	case missingCtx
}

extension CodingUserInfoKey {
	static let ctx = CodingUserInfoKey(rawValue: "ctx")!
}
