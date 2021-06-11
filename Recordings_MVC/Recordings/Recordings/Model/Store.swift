//
//  Store.swift
//  Recordings
//
//  Created by mtAdmin on 2021/6/10.
//

import Foundation

final class Store {
    
    static private let documentDirectory = try! FileManager.default.url(for: .libraryDirectory, in: .userDomainMask , appropriateFor: nil, create: true)
    static public let changedNotification = Notification.Name("StoreChanged")
    static public let shared = Store(url: documentDirectory)
    
    private let baseURL: URL?
    private var placeholder: URL?
    private(set) var rootFolder: Folder
    
    init(url: URL?) {
        self.baseURL = url
        self.placeholder = nil
        
        if let u = url,
           let data = try? Data(contentsOf: u.appendingPathComponent(.storeLocation)),
           let folder = try? JSONDecoder().decode(Folder.self, from: data)
        {
            self.rootFolder = folder
        } else {
            self.rootFolder = Folder(name: "", uuid: UUID())
        }
    }
    
    // 拼接音频文件地址
    func fileURL(for recording: Recording) -> URL? {
        baseURL?.appendingPathComponent(recording.uuid.uuidString + ".m4a") ?? placeholder
    }
    
    // 移除音频文件
    func removeFile(for recording: Recording) {
        if let url = fileURL(for: recording), url != placeholder {
            _ = try? FileManager.default.removeItem(at: url)
        }
    }
    
    // 保存数据
    func save(_ notifying: Item, userInfo: [AnyHashable: Any]) {
        if let url = baseURL, let data = try? JSONEncoder().encode(rootFolder) {
            try! data.write(to: url.appendingPathComponent(.storeLocation))
            // 省略错误处理
        }
        // 通知Ctrl Model 数据变更
        NotificationCenter.default.post(name: Store.changedNotification, object: notifying, userInfo: userInfo)
    }
    
    // 读取数组切片中的某个文件
    func item(atUUIDPath path: [UUID]) -> Item? {
        rootFolder.item(atUUIDPath: path[0...])
    }
}

fileprivate extension String {
    static let storeLocation = "store.json"
}
