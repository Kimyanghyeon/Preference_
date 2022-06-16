//
//  TimeLineViewController.swift
//  Preference_
//
//  Created by 김양현 on 2022/06/14.
//

import UIKit

class TimeLineViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var table: UITableView!
    
    var count : Int = 0
    var arr : Array<String> = []
    
    var S_image: Array<String> = []
    var s_nickname=["yang"]
    var s_time = ["시간 : 11:30-21:00"]
    var s_loc = ["위치 : 서울 용산구 한강대로 276-1 1층"]
    var s_text = [" SIVA는 Serve International Vegan Awareness의 약자로 비건활동 단체의 이름 - 2019년에 오픈한 비건 식당 3일 전에 유선전화, DB으로 예약가능"]
    var sub = ["#4호선"]
    var tag1 = ["#숙대입구"]
    var tag2 = ["#완전비건식당"]
    var tag3 = ["#도보1분"]
    var w_time = ["2022-06-14 18:18:54"]
    
  
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestCount()
        table.delegate=self
        table.dataSource=self
    }//end of viewDid
    
    @IBAction func reset(_ sender: UIButton) {
        requestCount()
    }//end of reset
    
    func requestCount(){
        let request = NSMutableURLRequest(url: NSURL(string: "http://localhost/DB_Con_Board_Count.php")! as URL)
        
        request.httpMethod="POST"
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            
            data, response, error in
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }//end of if
            
            print("response = \(String(describing: response))")
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(String(describing: responseString))")
            let res : String = responseString! as String
            self.count = Int(res)!
           
            print(self.count)
            for i in 1...self.count{
                let request = NSMutableURLRequest(url: NSURL(string: "http://localhost/DB_Con_Board.php")! as URL)
                
                request.httpMethod="POST"
                let postRes="num=\(i)"
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
                    self.arr =  responseString!.components(separatedBy: "%")
                    print(self.arr[0])
                    /*
                        self.s_nickname[i] = self.arr[0]
                        self.s_loc[i] = self.arr[1]
                        self.s_time[i] = self.arr[2]
                        self.s_text[i] = self.arr[3]
                        self.S_image[i] = self.arr[4]
                        self.sub[i] = self.arr[5]
                        self.tag1[i] = self.arr[6]
                        self.tag2[i] = self.arr[7]
                        self.tag3[i] = self.arr[8]
                        self.w_time[i] = self.arr[9]
                    */
                
                   
                    
                }//end of Task
                task.resume()
                
            }//end of for
        }//end of Task
        task.resume()
    }//end of request
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }//end of tableview
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TimeLineTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TimeLineTableViewCell", for: indexPath) as! TimeLineTableViewCell
               // Cell Label의 내용 지정

        
        cell.s_nickname.text=s_nickname[indexPath.row]
        cell.s_loc.text=s_loc[indexPath.row]
        cell.s_time.text=s_time[indexPath.row]
        cell.s_text.text=s_text[indexPath.row]
        cell.sub.text=sub[indexPath.row]
        cell.tag1.text=tag1[indexPath.row]
        cell.tag2.text=tag2[indexPath.row]
        cell.tag3.text=tag3[indexPath.row]
        cell.w_time.text=w_time[indexPath.row]
        
        return cell
    }//end tableview
    
   
    
   

}//end of class
