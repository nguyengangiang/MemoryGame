//
//  Array+Only.swift
//  Memorize
//
//  Created by Giang Nguyenn on 12/28/20.
//

import Foundation

extension Array {
    var only: Element? {
        return self.count == 1 ? self.first : nil
    }
}
