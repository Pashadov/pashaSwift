//
//  ViewController.swift
//  VKClient
//
//  Created by Macbook Air on 23.10.2019.
//  Copyright © 2019 Pavlo. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    // Mark: Outlets
    @IBOutlet var LoginTF: UITextField!
    
    @IBOutlet var PasswordTF: UITextField!
    
    //Mark: Button
    @IBAction func ButtonPress(_ sender: Any) {
        guard let login = LoginTF.text,
            let password = PasswordTF.text,
        login == "",
        password == "" else {
           Show(message: "Incorrect Login/Password")
            return
        }
 performSegue(withIdentifier: "Login Segue", sender: nil)
    }
    
    @IBOutlet var ScrollView: UIScrollView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
     
        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Присваиваем его UIScrollVIew
        ScrollView?.addGestureRecognizer(hideKeyboardGesture)
    }

    
    // Когда клавиатура появляется
      @objc func keyboardWasShown(notification: Notification) {
          
          // Получаем размер клавиатуры
          let info = notification.userInfo! as NSDictionary
          let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
          let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
          
          // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.ScrollView.contentInset = contentInsets
          ScrollView?.scrollIndicatorInsets = contentInsets
      }
      
      //Когда клавиатура исчезает
      @objc func keyboardWillBeHidden(notification: Notification) {
          // Устанавливаем отступ внизу UIScrollView, равный 0
          let contentInsets = UIEdgeInsets.zero
          ScrollView?.contentInset = contentInsets
      }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         
        navigationController?.setNavigationBarHidden(true, animated: false)
      
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
            // Второе — когда она пропадает
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
       
        print(#function)
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         
       
        
          print(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        navigationController?.setNavigationBarHidden(false, animated: true)

        
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
          print(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        
          print(#function)
    }
   
    @objc func hideKeyboard() {
        self.ScrollView?.endEditing(true)
    }

}
