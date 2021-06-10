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
            self.rootFolder = Folder()
        }
    }
}

fileprivate extension String {
    static let storeLocation = "store.json"
}
