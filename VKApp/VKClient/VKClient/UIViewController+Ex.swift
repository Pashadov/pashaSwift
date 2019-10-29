//
//  UIViewController+Ex.swift
//  VKClient
//
//  Created by Macbook Air on 27.10.2019.
//  Copyright © 2019 Pavlo. All rights reserved.
//

import UIKit

extension UIViewController {
    func Show(message: String) {
       let alertVC = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertVC.addAction(ok)
        present(alertVC, animated: true)
    }
}
