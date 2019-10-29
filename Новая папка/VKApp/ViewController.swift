//
//  BaseViewController.swift
//  VKApp
//
//  Created by Macbook Air on 16.10.2019.
//  Copyright © 2019 Pavlo. All rights reserved.
//

import UIKit

    
 class ViewController: UIViewController {
        
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet var LoginText: UITextField!
    
    @IBOutlet var PasswordText: UITextField!

    override func viewDidLoad() {
            super.viewDidLoad()
            LoginText.text = ""
            PasswordText.text = ""
           
            // Do any additional setup after loading the view.
        }
        
        
        @IBAction func LoginButtonPressed(_ sender: UIButton) {
            if LoginText.text == "" && PasswordText.text == ""{
                performSegue(withIdentifier: "Login-Ok", sender: self)
            }else{
                let alter = UIAlertController(title: "Ошибка", message: "Введены не верные данные пользователя", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alter.addAction(action)
                present(alter, animated: true, completion: nil)
            }
        }
        
        @objc func keyBoardAppeared(_ notification: Notification) {
            if let keyboardInfo = notification.userInfo as NSDictionary? {
                let size = (keyboardInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
                let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: size.height, right: 0)
                self.scrollView.contentInset = contentInset
                self.scrollView.scrollIndicatorInsets = contentInset
            }
        }
        
        @objc func keyBoardWasHidden() {
            self.scrollView.contentInset = UIEdgeInsets.zero
            self.scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyBoardAppeared(_:)),
                                                   name: UIResponder.keyboardDidShowNotification,
                                                   object: nil)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyBoardWasHidden),
                                                   name: UIResponder.keyboardDidHideNotification,
                                                   object: nil)
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyBoardAppeared(_:)),
                                                   name: UIResponder.keyboardDidShowNotification,
                                                   object: nil)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyBoardWasHidden),
                                                   name: UIResponder.keyboardDidHideNotification,
                                                   object: nil)
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }


