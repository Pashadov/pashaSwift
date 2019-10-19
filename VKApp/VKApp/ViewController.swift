//
//  ViewController.swift
//  VKApp
//
//  Created by Macbook Air on 16.10.2019.
//  Copyright © 2019 Pavlo. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var baseImage: UIImageView?
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

