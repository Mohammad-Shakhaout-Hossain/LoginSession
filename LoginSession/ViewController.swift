//
//  ViewController.swift
//  LoginSession
//
//  Created by Shakhawat Hossain Shakib on 5/1/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var phoneNoText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    let parameters: Parameters = ["mobile_number": "+9641920961634", "password": "Password@2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiHandler()
    }
    @IBAction func didTapedLogin(_ sender: Any) {
        
    }
    
    func apiHandler () {
        let urlString = "https://staging-apigw-personal.fast-pay.cash/api/v1/auth/signin"

        AF.request(urlString, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
        response in
          switch response.result {
                        case .success:
                            print(response)

                            break
                        case .failure(let error):

                            print(error)
                        }
        }
    }
    
    
    @objc func tapOnView(_ tapGestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
        view.removeGestureRecognizer(tapGestureRecognizer)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let gestureView = UITapGestureRecognizer(target: self, action: #selector(tapOnView(_:)))
        view.addGestureRecognizer(gestureView)
    }

}

