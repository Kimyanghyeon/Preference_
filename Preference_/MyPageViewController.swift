//
//  MyPageViewController.swift
//  Preference_
//
//  Created by 김양현 on 2022/06/10.
//

import UIKit

class MyPageViewController: UIViewController{
    
    @IBOutlet weak var nicknameText: UILabel!
    @IBOutlet weak var locText: UILabel!
    
    @IBOutlet weak var myContentTable: UITableView!
    
    var nickname : String = ""
    var date : String = ""
    var s_text : String = ""
    
    var list : [String] = []
    
    let cell : String = "cell"
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectLoc()
        selectList()
        nicknameText.text=nickname
        myContentTable.delegate=self
        
    }//end of viewDidLoad
    
    
    @IBAction func logoutBtn(_ sender: UIButton) {
        guard let change = self.storyboard?.instantiateViewController(withIdentifier: "mainVC") as? ViewController else { return }
                    
        change.modalTransitionStyle = .coverVertical // 화면 전환 애니메이션 설정
        change.modalPresentationStyle = .fullScreen // 전환된 화면이 보여지는 방법 설정 (fullScreen)
        self.present(change, animated: true, completion: nil)
        
    }//end of logoutBtn
    
    func selectLoc(){
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://localhost/DB_Con_MyPage.php")! as URL)
        request.httpMethod="POST"
        let postRes="nickname=\(nickname)"
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
            let loc = responseString?.substring(from: 0)
            self.locText.text=loc
        }//end of Task
        
        task.resume()
        
    }//end of selectLoc
    
    func selectList(){
        let request = NSMutableURLRequest(url: NSURL(string: "http://localhost/DB_Con_MyList.php")! as URL)
        request.httpMethod="POST"
        let postRes="nickname=\(nickname)"
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
            let text = responseString?.substring(from: 0)
            
            for i in 0..<self.list.count{
                
                if(text=="" || text==nil){
                    self.list[i]="게시물이 존재하지 않습니다"
                }else{
                    self.list[i]=text!
                }//end of else if
            }//end of for
            
        }//end of Task
        
        task.resume()
        
    }//end of selectList
    
    

}//end of class

extension MyPageViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 10
    }//end of tableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }//end of table view
    
}//end of extension
