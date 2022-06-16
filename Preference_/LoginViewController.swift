//
//  LoginViewController.swift
//  Preference_
//
//  Created by 김양현 on 2022/06/01.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var pw: UITextField!
    @IBOutlet weak var idText: UILabel!
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var pwText: UILabel!
    @IBOutlet weak var joinBtn: UIButton!
    @IBOutlet weak var findBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }//end of view DidLoad
    
   
    @IBAction func loginBtn(_ sender: UIButton) {
        let request = NSMutableURLRequest(url: NSURL(string: "http://localhost/DB_Con_Login.php")! as URL)
        
        request.httpMethod="POST"
        
        let postRes="id=\(id.text!)&pw=\(pw.text!)"
        
        request.httpBody = postRes.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            
            data, response, error in
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }//end of if
            
            print("response = \(String(describing: response))")
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(String(describing: responseString))")
            let checkLogin = responseString?.substring(to: 1)
            let nickname = responseString?.substring(from: 1)
            
            if checkLogin == "1"{
                DispatchQueue.main.async{
                    guard let change = self.storyboard?.instantiateViewController(withIdentifier: "mainVC") as? ViewController else { return }
                                
                    change.modalTransitionStyle = .coverVertical // 화면 전환 애니메이션 설정
                    change.modalPresentationStyle = .fullScreen // 전환된 화면이 보여지는 방법 설정 (fullScreen)
                    change.checkUser="1"
                    change.loginUser=nickname! 
                    self.present(change, animated: true, completion: nil)
                }//end of main async
              
                
            }else{
                DispatchQueue.main.async {
                    let sheet = UIAlertController(title: "로그인 실패", message: "아이디 혹은 비밀번호가 일치하지 않습니다", preferredStyle: .actionSheet)
                    
                    sheet.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { _ in print("알람 닫기") }))

                    self.present(sheet, animated: true)
                    
                }//end of main async
            }//end of if
            
        }//end of Task
        task.resume()
        
    }//end of loginBtn
    
    
    
    
}//end of class
