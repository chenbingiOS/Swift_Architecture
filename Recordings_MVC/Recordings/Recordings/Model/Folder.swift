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
        contents = []
        super.init(name: name, uuid: uuid)
    }
    
    
    enum FolderKeys: CodingKey { case name, uuid, contents }
    required init(from decoder: Decoder) throws {
        contents = [Item]()
        
//        let c = try decoder.container(keyedBy: FolderKeys.Self)
        
        let uuid = UUID()
        let name = ""
        super.init(name: name, uuid: uuid)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
    
    
}
