//
//  ViewController.swift
//  FRPSampleApp
//
//  Created by mobilus on 11/05/21.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        emailTextField.rx.text.map { text in
//            return self.isValidEmail(email: text!)
//        }
//        .bind(to: signupButton.rx.isEnabled)

        let emailValid = emailTextField.rx.text.map { text in
            return self.isValidEmail(email: text!)
        }
        
        let passwordValid = passwordTextField.rx.text.map { text in
            return self.isValidPassword(password: text!)
        }

        Observable.combineLatest(emailValid, passwordValid) { $0 && $1 }
            .bind(to: signupButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    func isValidEmail(email:String) -> Bool {
        return !email.isEmpty && email.contains("@")
    }

    func isValidPassword(password: String) -> Bool {
        return !password.isEmpty && password.count >= 6
    }
}
