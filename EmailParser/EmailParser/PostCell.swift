//
//  PostCell.swift
//  EmailParser
//
//  Created by Lee on 2019/3/8.
//  Copyright © 2019 Lee. All rights reserved.
//

import Cocoa

class PostCell: NSTableCellView {

    @IBOutlet weak var senderLabel: NSTextField!
    @IBOutlet weak var emailLabel: NSTextField!
    @IBOutlet weak var dateLabel: NSTextField!
    @IBOutlet weak var subjectLabel: NSTextField!
    @IBOutlet weak var organizationLabel: NSTextField!
    @IBOutlet weak var costLabel: NSTextField!
    @IBOutlet weak var keywordsLabel: NSTextField!
    @IBOutlet weak var numberOfLinesLabel: NSTextField!
    
    func configure(_ post: HardwarePost) {
        senderLabel.stringValue = post.sender
        emailLabel.stringValue = post.email
        dateLabel.stringValue = post.date
        subjectLabel.stringValue = post.subject
        organizationLabel.stringValue = post.organization
        numberOfLinesLabel.stringValue = "\(post.numberOfLines)"
        
        costLabel.stringValue = post.costs.isEmpty ? "NO" : post.costs.map{ "\($0)" }.lazy.joined(separator: "; ")
        keywordsLabel.stringValue = post.keywords.isEmpty ? "No keywords found" : post.keywords.joined(separator: "; ")
    }
}
