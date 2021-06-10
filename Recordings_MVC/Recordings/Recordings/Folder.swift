//
//  Folder.swift
//  Recordings
//
//  Created by mtAdmin on 2021/6/10.
//

import UIKit

class Folder: Item, Codable {

    var contents: [Any]
    
    override init(name: String, uuid: UUID) {
        super.init(name: name, uuid: uuid)
        contents = []
    }
    
    required init(from decoder: Decoder) throws {
        
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
    
    
}
