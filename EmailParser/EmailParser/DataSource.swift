//
//  DataSource.swift
//  EmailParser
//
//  Created by Lee on 2019/3/8.
//  Copyright © 2019 Lee. All rights reserved.
//

import Cocoa

class DataSource: NSObject {

    @IBOutlet var textView: NSTextView!
    
    let hardwarePosts: [HardwarePost]
    
    override init() {
        self.hardwarePosts = Bundle.main
            .urls(forResourcesWithExtension: nil, subdirectory: "comp.sys.mac.hardware")?
            .compactMap({ try? Data(contentsOf: $0) }).lazy
            .map(HardwarePost.init) ?? []
        super.init()
    }
    
}

extension DataSource: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return hardwarePosts.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: tableColumn?.identifier ?? NSUserInterfaceItemIdentifier(rawValue: ""), owner: self) as! PostCell
        cell.configure(hardwarePosts[row])
        return cell
    }
}

extension DataSource: NSTableViewDelegate {
    func tableViewSelectionDidChange(_ notification: Notification) {
        guard let tableView = notification.object as? NSTableView else { return }
        textView.string = hardwarePosts[tableView.selectedRow].message
    }
}
