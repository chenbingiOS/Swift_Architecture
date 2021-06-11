//
//  FolderViewController.swift
//  Recordings
//
//  Created by mtAdmin on 2021/6/10.
//


//== 通常是用于判定两个对象的内容是否相同 === 通常是用于判定两个对象引用的是否为同一块内存地址。

import UIKit

class FolderViewController: UITableViewController {

    var folder: Folder = Store.shared.rootFolder {
        didSet {
            tableView.reloadData()
            if folder === folder.store?.rootFolder {
                title = .recoredings
            } else {
                title = folder.name
            }
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

// MARK: Action
extension FolderViewController {
    // 新建一个文件夹
    @IBAction func createNewFolder(_ sender: Any?) {
        modalTextAlert(title: .createFolder, accept: .create, placeholder: .folderName) { string in
            if let s = string {
                let newFolder = Folder(name: s, uuid: UUID())
                self.folder.add(newFolder)
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func createNewRecording(_ sender: Any) {
        performSegue(withIdentifier: .showRecorder, sender: self)
    }
}

// MARK: Delegate
extension FolderViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        folder.contents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = folder.contents[indexPath.row]
        let identifier = item is Recording ? "RecordingCell" : "FolderCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = "\((item is Recording) ? "🔊" : "📁") \(item.name)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        folder.remove(folder.contents[indexPath.row])
    }
}

// MARK: 状态恢复功能
extension FolderViewController {
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        coder.encode(folder.uuidPath, forKey: .uuidPathKey)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        if let uuidPath = coder.decodeObject(forKey: .uuidPathKey) as? [UUID], let folder = Store.shared.item(atUUIDPath: uuidPath) as? Folder {
            self.folder = folder
        } else {
            if let index = navigationController?.viewControllers.firstIndex(of: self), index != 0 {
                navigationController?.viewControllers.remove(at: index)
            }
        }
    }
}

fileprivate extension String {
    
    static let uuidPathKey = "uuidPath"
    static let showRecorder = "showRecorder"
    static let showPlayer = "showPlayer"
    static let showFolder = "showFolder"

    // 支持多语言
    static let recoredings = "Recordings"
    static let createFolder = "Create Folder"
    static let folderName = "Folder Name"
    static let create = "Create"
}
