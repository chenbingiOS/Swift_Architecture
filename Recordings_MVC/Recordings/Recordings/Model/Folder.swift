//
//  Folder.swift
//  Recordings
//
//  Created by mtAdmin on 2021/6/10.
//

import UIKit

class Folder: Item, Codable {
    override weak var store: Store? {
        didSet {
            contents.forEach { $0.store = store }
        }
    }
    
    var contents: [Item]
    
    override init(name: String, uuid: UUID) {
        contents = []
        super.init(name: name, uuid: uuid)
    }
        
    // MARK: 状态恢复功能
    enum FolderKeys: CodingKey { case name, uuid, contents }
    enum FolderOrRecording: CodingKey { case folder, recording }
    
    required init(from decoder: Decoder) throws {
        contents = [Item]()
        
        let c = try decoder.container(keyedBy: FolderKeys.self)
        var nested = try c.nestedUnkeyedContainer(forKey: FolderKeys.contents)
        while true {
            let wrapper = try nested.nestedContainer(keyedBy: FolderOrRecording.self)
            if let f = try wrapper.decodeIfPresent(Folder.self, forKey: FolderOrRecording.folder) {
                contents.append(f)
            } else if let r = try wrapper.decodeIfPresent(Recording.self, forKey: FolderOrRecording.recording) {
                contents.append(r)
            } else {
                break
            }
        }
        
        let name = try c.decode(String.self, forKey: FolderKeys.name)
        let uuid = try c.decode(UUID.self, forKey: FolderKeys.uuid)
        super.init(name: name, uuid: uuid)
        
        contents.forEach { $0.parent = self }
    }
    
    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: FolderKeys.self)
        try c.encode(name, forKey: FolderKeys.name)
        try c.encode(uuid, forKey: FolderKeys.uuid)
        
        var nested = c.nestedUnkeyedContainer(forKey: FolderKeys.contents)
        for c in contents {
            var wrapper = nested.nestedContainer(keyedBy: FolderOrRecording.self)
            switch c {
            case let f as Folder:
                try wrapper.encode(f, forKey: FolderOrRecording.folder)
            case let r as Recording:
                try wrapper.encode(r, forKey: FolderOrRecording.recording)
            default:
                break
            }
        }
        
        _ = nested.nestedContainer(keyedBy: FolderOrRecording.self)
    }
}

extension Folder {
    // 移除音频文件
    func remove(_ item: Item) {
        guard let index = contents.firstIndex(where: { $0 === item } ) else { return }
        item.deleted()
        contents.remove(at: index)
        
        store?.save(item, userInfo: [
            Item.changeReasonKey : Item.removed,
            Item.oldValueKey : index,
            Item.parentFolderKey : self
        ])
    }
    
    func add(_ item: Item) {
        assert(contents.contains(where: { $0 === item }) == false)
        
        contents.append(item)
        contents.sort(by: { $0.name < $1.name })
        
        let newIndex = contents.firstIndex(where: { $0 === item })!
        item.parent = self
        store?.save(item, userInfo: [
            Item.changeReasonKey : Item.added,
            Item.newValueKey : newIndex,
            Item.parentFolderKey : self
        ])
    }
}
