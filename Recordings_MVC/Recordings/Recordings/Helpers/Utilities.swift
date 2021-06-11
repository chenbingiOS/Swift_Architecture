//
//  Utilities.swift
//  Recordings
//
//  Created by mtAdmin on 2021/6/11.
//

import Foundation
import UIKit

extension UIViewController {
    func modalTextAlert(title: String, accept: String = .ok, cancel: String = .cancel, placeholder: String, callback: @escaping (String?) -> ()) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addTextField { $0.placeholder = placeholder }
        alert.addAction(UIAlertAction(title: cancel, style: UIAlertAction.Style.cancel, handler: { _ in callback(nil) }))
        alert.addAction(UIAlertAction(title: accept, style: UIAlertAction.Style.default, handler: { _ in
            callback(alert.textFields?.first?.text)
        }))
        present(alert, animated: true, completion: nil)
    }
}

fileprivate extension String {
    static let ok = "ok"
    static let cancel = "cancel"
}

