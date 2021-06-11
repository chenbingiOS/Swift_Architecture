//
//  Item.swift
//  Recordings
//
//  Created by mtAdmin on 2021/6/10.
//

import Foundation

class Item {
    
    weak var store: Store?
    weak var parent: Folder? {
        didSet {
            store = parent?.store
        }
    }
    
    let uuid: UUID
    // private(set) 外部只读，内部读写
    private(set) var name: String
    
    init(name: String, uuid: UUID) {
        self.name = name
        self.uuid = uuid
        self.store = nil
    }
    
    func setName(_ newName: String) {
        name = newName
//        if let p = parent {
//            let (oldIndex, newIndec)
//        }
    }
    
    func deleted() {
        parent = nil
    }
    
    var uuidPath: [UUID]?
    func item(atUUIDPath path: ArraySlice<UUID>) -> Item? {
        guard let first = path.first, first == uuid else {
            return nil
        }
        return self
    }
}

extension Item {
    static let changeReasonKey = "reason"
    static let newValueKey = "newValue"
    static let oldValueKey = "OldValue"
    static let parentFolderKey = "parentFolder"
    static let renamed = "renamed"
    static let added = "added"
    static let removed = "removed"
}
