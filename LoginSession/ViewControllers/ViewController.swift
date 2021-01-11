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

var parameters: Parameters?

override func viewDidLoad() {
    super.viewDidLoad()
    
    }
@IBAction func didTapedLogin(_ sender: Any) {
    guard let phoneNum = self.phoneNoText.text, let pass = self.passwordText.text else {
        print("your info is nil.")
        return
    }
    parameters = ["mobile_number": "\(phoneNum)", "password": "\(pass)"]
    apiHandler()
}
    func apiHandler () {
    let urlString = "https://staging-apigw-personal.fast-pay.cash/api/v1/auth/signin"
   
        AF.request(urlString, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
                        case .success:
                           print(response)
                            do {
                            let data = try JSONDecoder().decode(singin_model.self, from: response.data!)
                                //print(data.messages)
                                //print(data.code)
                                if data.code == 200 {
                                    let token = data.data?.token;
                                    UserDefaults.standard.setValue(token, forKey: "token")
                                    //print("inside main thread")
                                    DispatchQueue.main.async {
                                        
                                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "home")
                                        self.navigationController?.pushViewController(vc!, animated: true)
                                    }
                                    
                                    
                                } else {
                                    DispatchQueue.main.async {
                                        self.apiAlertHandler()
                                    }
                                    
                                    print(data.messages)
                                }
                                
                            }
                            catch {
                                print("not working")
                            }

                            break
                        case .failure(let error):

                            print(error)
                        }
            }
    }
    
    func apiAlertHandler () {
        let alert = UIAlertController(title: "Failed", message: "The mobile number field is required. The password field is required.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
            print("Dismiss Tapped")
        }))
        present(alert, animated: true, completion: nil)
    
    }

    func tapButtonAlertHandler () {
        
    }
}

struct singin_model: Codable {
    var code: Int
    var messages: [String?]
    var data : token_model?
}

struct token_model: Codable {
    var token : String?
}
