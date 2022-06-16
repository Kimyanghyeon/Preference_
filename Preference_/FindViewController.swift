//
//  FindViewController.swift
//  Preference_
//
//  Created by 김양현 on 2022/06/01.
//

import UIKit

class FindViewController: UIViewController {
    
    
    @IBOutlet weak var findIDEmail: UITextField!
    
    @IBOutlet weak var findPwName: UITextField!
    
    @IBOutlet weak var findPwId: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }//end of viewDid
    
    @IBAction func findID(_ sender: UIButton) {
        let request = NSMutableURLRequest(url: NSURL(string: "http://localhost/DB_Con_Find_ID.php")! as URL)
        
        request.httpMethod="POST"
        
        let postRes="email=\(findIDEmail.text!)"
        
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
            let user_id = responseString?.substring(from: 1)
            
            if checkLogin == "1"{
                DispatchQueue.main.async{
                    let sheet = UIAlertController(title: "아이디 찾기", message: user_id, preferredStyle: .actionSheet)
                    
                    sheet.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { _ in print("알람 닫기") }))

                    self.present(sheet, animated: true)
                }//end of main async
              
                
            }else{
                DispatchQueue.main.async {
                    let sheet = UIAlertController(title: "아이디 찾기 실패", message: "존재하지 않는 이메일 입니다", preferredStyle: .actionSheet)
                    
                    sheet.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { _ in print("알람 닫기") }))

                    self.present(sheet, animated: true)
                    
                }//end of main async
            }//end of if
            
        }//end of Task
        task.resume()
        
    }//end of findID
    
    
    @IBAction func findPw(_ sender: UIButton) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://localhost/DB_Con_Find_PW.php")! as URL)
        
        request.httpMethod="POST"
        
        let postRes="name=\(findPwName.text!)&id=\(findPwId.text!)"
        
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
            let user_pw = responseString?.substring(from: 1)
            
            if checkLogin == "1"{
                DispatchQueue.main.async{
                    let sheet = UIAlertController(title: "비밀번호 찾기", message: user_pw, preferredStyle: .actionSheet)
                    
                    sheet.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { _ in print("알람 닫기") }))

                    self.present(sheet, animated: true)
                }//end of main async
              
                
            }else{
                DispatchQueue.main.async {
                    let sheet = UIAlertController(title: "비밀번호 찾기 실패", message: "존재하지 않는 정보 입니다", preferredStyle: .actionSheet)
                    
                    sheet.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { _ in print("알람 닫기") }))

                    self.present(sheet, animated: true)
                    
                }//end of main async
            }//end of if
            
        }//end of Task
        task.resume()
        
    }//end of findPw
    

}//end of classs
