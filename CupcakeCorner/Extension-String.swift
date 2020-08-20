//
//  Extension-String.swift
//  CupcakeCorner
//
//  Created by Paul Richardson on 20.08.2020.
//  Copyright © 2020 Developer. All rights reserved.
//

import Foundation

extension String {
	var isBlank: Bool {
		return allSatisfy({$0.isWhitespace})
	}
}
