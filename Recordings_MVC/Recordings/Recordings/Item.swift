//
//  Item.swift
//  Recordings
//
//  Created by mtAdmin on 2021/6/10.
//

import Foundation

class Item {
    let uuid: UUID
    private(set) var name: String
    
    init(name: String, uuid: UUID) {
        self.name = name
        self.uuid = uuid
    }
}
