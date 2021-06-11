//
//  Recording.swift
//  Recordings
//
//  Created by mtAdmin on 2021/6/10.
//

import UIKit

class Recording: Item, Codable {

    override init(name: String, uuid: UUID) {
        super.init(name: name, uuid: uuid)
    }
    
    var fileURL: URL? {
        store?.fileURL(for: self)
    }
    
    // MARK: 状态恢复功能
    enum RecordingKeys: CodingKey { case name, uuid }
    
    required init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: RecordingKeys.self)
        let name = try c.decode(String.self, forKey: RecordingKeys.name)
        let uuid = try c.decode(UUID.self, forKey: RecordingKeys.uuid)
        super.init(name: name, uuid: uuid)
    }
    
    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: RecordingKeys.self)
        try c.encode(name, forKey: RecordingKeys.name)
        try c.encode(uuid, forKey: RecordingKeys.uuid)
    }
    
    // 删除存储文件
    override func deleted() {
        store?.removeFile(for: self)
        super.deleted()
    }
}
