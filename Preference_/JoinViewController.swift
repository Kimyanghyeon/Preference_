//
//  JoinViewController.swift
//  Preference_
//
//  Created by κΉμν on 2022/06/01.
//

import UIKit

class JoinViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {
    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var nickname: UITextField!
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var pw: UITextField!
    @IBOutlet weak var email1: UITextField!
    @IBOutlet weak var emailSelf: UITextField!
    @IBOutlet weak var email2: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var birth: UILabel!
    @IBOutlet weak var loc: UITextField!
    @IBOutlet weak var birthSelect: UITextField!
    
    var birthText : String = ""
    let datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        birth.text = birthText
        showDatePicker()
        createPickerView()
        dismissPickerView()
        
    }//end of viewDidLoad
    
    @IBAction func joinBtn(_ sender: UIButton) {
        let request = NSMutableURLRequest(url: NSURL(string: "http://localhost/DB_Con.php")! as URL)
        
        request.httpMethod="POST"
        
        let postRes="name=\(name.text!)&nickname=\(nickname.text!)&id=\(id.text!)&pw=\(pw.text!)&email=\(email1.text!+"@"+email2.text!)&gender=\(gender.text!)&birth=\(birth.text!)&loc=\(loc.text!)"
        
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
            
            if checkLogin == "1"{
                DispatchQueue.main.async{
                    guard let change = self.storyboard?.instantiateViewController(withIdentifier: "mainVC") as? ViewController else { return }
                                
                    change.modalTransitionStyle = .coverVertical // νλ©΄ μ ν μ λλ©μ΄μ μ€μ 
                    change.modalPresentationStyle = .fullScreen // μ νλ νλ©΄μ΄ λ³΄μ¬μ§λ λ°©λ² μ€μ  (fullScreen)
                    self.present(change, animated: true, completion: nil)
                }//end of main async
              
                
            }else{
                DispatchQueue.main.async {
                    let sheet = UIAlertController(title: "νμκ°μ μ€ν¨", message: "μλ ₯μ΄ μλ£λμ§ μμμ΅λλ€", preferredStyle: .actionSheet)
                    
                    sheet.addAction(UIAlertAction(title: "νμΈ", style: .destructive, handler: { _ in print("μλ λ«κΈ°") }))

                    self.present(sheet, animated: true)
                    
                }//end of main async
            }//end of if
            
        }//end of Task
        task.resume()
        
    }//end of joinBtn
    
    
    let emaileSelectList = ["gmail.com","naver.com","daum.net","kakao.com","itc.ac.kr"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
        //μ ν κ°λ₯ν λ¦¬μ€νΈμ κ°―μ
    }//end of numberOfComponents
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return emaileSelectList.count
        //λ¦¬μ€νΈ κΈΈμ΄
    }//end of pickerView
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return emaileSelectList[row]
        //λ¦¬μ€νΈ λ¬Έμμ΄ λ°ν
    }//end of pickerView
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        emailSelf.text=emaileSelectList[row]
        email2.text = emaileSelectList[row]
        //μ νλ¬μ λ μ‘μ
    }//end of pickerView
    
    func createPickerView() {
        let picker = UIPickerView()
        picker.delegate = self
        emailSelf?.inputView = picker
    }//end of createPickerView

    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker3));
        let spaceButton = UIBarButtonItem(barButtonSystemItem:.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolBar.setItems([doneButton,spaceButton,cancelButton], animated: true)
        
        toolBar.isUserInteractionEnabled = true
        emailSelf?.inputAccessoryView = toolBar
    }//end of dismissPickerView
    
    @objc func donedatePicker3(){
       self.view.endEditing(true)
     }//end of donedatePicker
    
    
    @IBAction func genderSelect(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex==0){
            gender.text="λ¨μ"
        }else if(sender.selectedSegmentIndex==1){
            gender.text="μ¬μ"
        }//end of else if
    }//end of genderSelect
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        //ToolBar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem:.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolBar.setItems([doneButton,spaceButton,cancelButton], animated: true)
        
        birthSelect.inputAccessoryView = toolBar
        birthSelect.inputView = datePicker
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }//end of else if

     }//end of showDatePicker
    
      @objc func donedatePicker(){
          let formatt = DateFormatter()
          formatt.dateFormat="yyyyMMdd"
          birthSelect.text = formatt.string(from: datePicker.date)
          birth.text=formatt.string(from:datePicker.date)
          self.view.endEditing(true)
     }//end of donedatePicker

     @objc func cancelDatePicker(){
         self.view.endEditing(true)
      }//end ofcancelDatePicker

    

}//end of class
