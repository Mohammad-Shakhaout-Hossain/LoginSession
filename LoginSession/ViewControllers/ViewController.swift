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
                        print(data.data?.token!)
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "home")
                        self.navigationController?.pushViewController(vc!, animated: true)
                        
                    }catch {
                        print("not working")
                    }

                    break
                case .failure(let error):

                    print(error)
                }
    }
    }

}

struct singin_model: Codable {
    var data : token_model?
}

struct token_model: Codable {
    var token : String?
}
