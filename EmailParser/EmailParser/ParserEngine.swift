//
//  ParserEngine.swift
//  EmailParser
//
//  Created by Lee on 2019/3/8.
//  Copyright © 2019 Lee. All rights reserved.
//

import Foundation

final class ParserEngine {
    typealias Fields = (sender: String, email: String, subject: String, date: String, organization: String, lines: Int)
    
    func fieldsByExtractingFrom(_ string: String) -> Fields {
        var (sender, email, subject, date, organization, lines) = ("", "", "", "", "", 0)
        let scanner = Scanner(string: string)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: " :\n")
        while !scanner.isAtEnd {
            let field = scanner.scanUpTo(":") ?? ""
            let info = scanner.scanUpTo("\n") ?? ""
            
            switch field {
            case "From": (email, sender) = fromInfoByExtractingFrom(info)
            case "Subject": subject = info
            case "Date": date = info
            case "Organization": organization = info
            case "Lines": lines = Int(info) ?? 0
            default: break
            }
        }
        return (sender, email, subject, date, organization, lines)
    }
    
    fileprivate func fromInfoByExtractingFrom(_ string: String) -> (email: String, sender: String) {
        
        let scanner = Scanner(string: string)
        if string.isMatched(".*[\\s]*\\({1}(.*)") {
            scanner.charactersToBeSkipped = CharacterSet(charactersIn: "() ")
            let email = scanner.scanUpTo("(")
            let sender = scanner.scanUpTo(")")
            return (email ?? "", sender ?? "")
        }
        
        if string.isMatched(".*[\\s]*<{1}(.*)") {
            scanner.charactersToBeSkipped = CharacterSet(charactersIn: "<> ")
            let sender = scanner.scanUpTo("<")
            let email = scanner.scanUpTo(">")
            return (email ?? "", sender ?? "")
        }
        return ("unknown", string)
    }
    
    func costInfoByExtractingFrom(_ string: String) -> [Double] {
        var results = [Double]()
        let dollar = CharacterSet(charactersIn: "$")
        let scanner = Scanner(string: string)
        scanner.charactersToBeSkipped = dollar
        while !scanner.isAtEnd && scanner.scanUpToCharacters(from: dollar, into: nil) {
            results += [scanner.scanDouble()].compactMap{$0}
        }
        return results
    }
    
    let keywords: Set<String> = ["apple", "macs", "software", "keyboard",
                                 "printers", "printer", "video", "monitor",
                                 "laser", "scanner", "disks", "cost", "price",
                                 "floppy", "card", "phone"]
    func keywordsByExtractingFrom(_ string: String) -> Set<String> {
        var results: Set<String> = []
        let scanner = Scanner(string: string)
        while !scanner.isAtEnd, let word = scanner.scanUpTo(" ")?.lowercased() {
            if keywords.contains(word) {
                results.insert(word)
            }
        }
        return results
    }
}

private extension String {
    func isMatched(_ pattern: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self)
    }
}
