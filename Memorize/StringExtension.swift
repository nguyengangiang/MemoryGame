//
//  StringExtension.swift
//  Memorize
//
//  Created by Giang Nguyenn on 1/17/21.
//

import Foundation

extension Data {
    // just a simple converter from a Data to a String
    var utf8: String? { String(data: self, encoding: .utf8 ) }
}
