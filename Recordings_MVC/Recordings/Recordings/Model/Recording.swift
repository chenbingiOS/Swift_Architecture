//
//  Recording.swift
//  Recordings
//
//  Created by mtAdmin on 2021/6/10.
//

import UIKit

class Recording: Item {

    override init(name: String, uuid: UUID) {
        super.init(name: name, uuid: uuid)
    }
    
    var fileURL: URL? {
        store?.fileURL(for: self)
    }
}
