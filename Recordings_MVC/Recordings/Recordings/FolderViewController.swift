//
//  FolderViewController.swift
//  Recordings
//
//  Created by mtAdmin on 2021/6/10.
//


//== 通常是用于判定两个对象的内容是否相同 === 通常是用于判定两个对象引用的是否为同一块内存地址。

import UIKit

class FolderViewController: UITableViewController {

    var folder: Folder? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = editButtonItem
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleChangeNotification(_:)), name: Store.changedNotification, object: nil)
    }
    
    @objc func handleChangeNotification(_ notification: Notification) {
        
    }
}
// MARK: Delegate
extension FolderViewController {
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//    }
}

// MARK: 状态恢复功能
extension FolderViewController {
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
    }
}

fileprivate extension String {
    static let recoredings = "Recordings"
}
