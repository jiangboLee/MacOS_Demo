//
//  Scanner+.swift
//  EmailParser
//
//  Created by Lee on 2019/3/8.
//  Copyright © 2019 Lee. All rights reserved.
//

import Foundation

extension Scanner {
    func scanUpToCharactersFrom(_ set: CharacterSet) -> String? {
        var result: NSString?
        return scanUpToCharacters(from: set, into: &result) ? (result as String?) : nil
    }
    
    func scanUpTo(_ string: String) -> String? {
        var result: NSString?
        return self.scanUpTo(string, into: &result) ? (result as String?) : nil
    }
    
    func scanDouble() -> Double? {
        var double: Double = 0
        return scanDouble(&double) ? double : nil
    }
}
