//
//  WriteViewController.swift
//  Preference_
//
//  Created by 김양현 on 2022/06/13.
//

import UIKit
import AVFoundation
import Photos

class WriteViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var categoryText: UILabel!
    @IBOutlet weak var s_loc: UITextField!
    @IBOutlet weak var s_name: UITextField!
    @IBOutlet weak var s_time1: UILabel!
    @IBOutlet weak var s_time2: UILabel!
    
    @IBOutlet weak var s_time1Select: UITextField!
    @IBOutlet weak var s_time2Select: UITextField!
    @IBOutlet weak var s_text: UITextView!
    @IBOutlet weak var sub: UITextField!
    @IBOutlet weak var tag1: UITextField!
    @IBOutlet weak var tag2: UITextField!
    @IBOutlet weak var tag3: UITextField!
    
    var nickname:String = ""
    
    let photo = UIImagePickerController()
    var imageData : NSData? = nil
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("")
        print("===============================")
        print("[A_Image >> viewDidLoad() :: 뷰 로드 실시]")
        print("===============================")
        print("")
              
        
        photo.delegate=self
        
        showDatePicker()
        showDatePicker2()
        createPickerView()
        dismissPickerView()
        
    }//end of viewDidLoad
    
    
    
    let categorySelectList = ["--","비건","노키즈존"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
        //선택 가능한 리스트의 갯수
    }//end of numberOfComponents
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorySelectList.count
        //리스트 길이
    }//end of pickerView
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categorySelectList[row]
        //리스트 문자열 반환
    }//end of pickerView
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        category.text=categorySelectList[row]
        categoryText.text = categorySelectList[row]
        //선택됬을 때 액션
    }//end of pickerView
    
    
    func createPickerView() {
        let picker = UIPickerView()
        picker.delegate = self
        category?.inputView = picker
    }//end of createPickerView

    func dismissPickerView() {
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker3));
            let spaceButton = UIBarButtonItem(barButtonSystemItem:.flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
            toolBar.setItems([doneButton,spaceButton,cancelButton], animated: true)
            
            toolBar.isUserInteractionEnabled = true
            category?.inputAccessoryView = toolBar
    }//end of dismissPickerView
    
    @objc func donedatePicker3(){
       self.view.endEditing(true)
     }//end of donedatePicker
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .time
        //ToolBar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem:.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolBar.setItems([doneButton,spaceButton,cancelButton], animated: true)
        
        s_time1Select.inputAccessoryView = toolBar
        s_time1Select.inputView = datePicker
        
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }//end of else if

     }//end of showDatePicker
    
    @objc func donedatePicker(){
          let formatt = DateFormatter()
          formatt.dateFormat="aa:HH:mm"
          s_time1Select.text = formatt.string(from: datePicker.date)
       self.view.endEditing(true)
     }//end of donedatePicker

     @objc func cancelDatePicker(){
         self.view.endEditing(true)
      }//end ofcancelDatePicker
    
    func showDatePicker2(){
        //Formate Date
        datePicker.datePickerMode = .time
        //ToolBar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker2));
        let spaceButton = UIBarButtonItem(barButtonSystemItem:.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolBar.setItems([doneButton,spaceButton,cancelButton], animated: true)
        
        s_time2Select.inputAccessoryView = toolBar
        s_time2Select.inputView = datePicker
        
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }//end of else if

     }//end of showDatePicker
    
    @objc func donedatePicker2(){
          let formatt = DateFormatter()
          formatt.dateFormat="aa:HH:mm"
          s_time2Select.text = formatt.string(from: datePicker.date)
       self.view.endEditing(true)
     }//end of donedatePicker
    
    // 뷰 로드 완료
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("")
        print("===============================")
        print("[A_Image >> viewWillAppear() :: 뷰 로드 완료]")
        print("===============================")
        print("")
    }//end of viewWillAppear
       
    // 뷰 화면 표시
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("")
        print("===============================")
        print("[A_Image >> viewDidAppear() :: 뷰 화면 표시]")
        print("===============================")
        print("")
        // -----------------------------------------
        // [뷰 컨트롤러 포그라운드, 백그라운드 상태 체크 설정 실시]
        NotificationCenter.default.addObserver(self, selector: #selector(checkForeground), name: UIApplication.willEnterForegroundNotification, object: nil) // [포그라운드]
        NotificationCenter.default.addObserver(self, selector: #selector(checkBackground), name: UIApplication.didEnterBackgroundNotification, object: nil) // [백그라운드]
        // -----------------------------------------
        // [포그라운드 처리 실시]
        checkForeground()
        // -----------------------------------------
    }//end of viewDidAppear
           
       
    // 뷰 정지
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("")
        print("===============================")
        print("[A_Image >> viewWillDisappear() :: 뷰 정지 상태]")
        print("===============================")
        print("")
    }//end of viewWillDisappear
           
     // 뷰 종료
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("")
        print("===============================")
        print("[A_Image >> viewDidDisappear() :: 뷰 종료 상태]")
        print("===============================")
        print("")
        // -----------------------------------------
        // [뷰 컨트롤러 포그라운드, 백그라운드 상태 체크 해제 실시]
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil) // [포그라운드]
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil) // [백그라운드]
        // -----------------------------------------
    }//end of viewDidDisappear
       
    // 백그라운드 상태
    @objc func checkForeground() {
        print("")
        print("===============================")
        print("[A_Image >> checkForeground() :: 뷰 컨트롤러 포그라운드]")
        print("===============================")
        print("")
    }//end of checkForeground
    @objc func checkBackground() {
        print("")
        print("===============================")
        print("[A_Image >> checkBackground() :: 뷰 컨트롤러 백그라운드]")
        print("===============================")
        print("")
    }//end of checkBackground
       
    // 앨범 열기
    func openPhoto(){
        DispatchQueue.main.async {
            print("")
            print("===============================")
            print("[A_Image >> openPhoto() :: 앨범 열기 수행 실시]")
            print("===============================")
            print("")
            // -----------------------------------------
            // [사진 찍기 카메라 호출]
               
            self.photo.sourceType = .photoLibrary // 앨범 지정 실시
            self.photo.allowsEditing = false // 편집을 허용하지 않음
            self.present(self.photo, animated: false, completion: nil)
            // -----------------------------------------
        }//end of DispatchQueue.main.async
    }//end of openPhoto
       
    
    // 버튼 클릭 이벤트
    @IBAction func uploadImageBtn(_ sender: UIButton) {
        
        print("")
        print("===============================")
        print("[A_Image >> buttonAction() :: 앨범 열기 버튼 클릭 이벤트 발생]")
        print("===============================")
        print("")
        
        
        // [앨범의 사진에 대한 접근 권한 확인 실시]
        PHPhotoLibrary.requestAuthorization( { status in
            switch status{
            case .authorized:
                print("")
                print("===============================")
                print("[A_Image >> buttonAction() :: 앨범의 사진에 대한 접근 권한 확인 실시]")
                print("상태 :: 앨범 권한 허용")
                print("===============================")
                print("")
                
                // [앨범 열기 수행 실시]
                self.openPhoto()
                break
                
            case .denied:
                print("")
                print("===============================")
                print("[A_Image >> buttonAction() :: 앨범의 사진에 대한 접근 권한 확인 실시]")
                print("상태 :: 앨범 권한 거부")
                print("===============================")
                print("")
                break
                
            case .notDetermined:
                print("")
                print("===============================")
                print("[A_Image >> buttonAction() :: 앨범의 사진에 대한 접근 권한 확인 실시]")
                print("상태 :: 앨범 권한 선택하지 않음")
                print("===============================")
                print("")
                break
                
            case .restricted:
                print("")
                print("===============================")
                print("[A_Image >> buttonAction() :: 앨범의 사진에 대한 접근 권한 확인 실시]")
                print("상태 :: 앨범 접근 불가능, 권한 변경이 불가능")
                print("===============================")
                print("")
                break
                
            default:
                break
            }//end of switch case
        })//end of uploadImageBtn
    }//end of uploadImageBtn
    
    func requestPOST() {
           
           // MARK: [URL 지정 실시]
           let urlComponents = URLComponents(string: "http://localhost/DB_Con_Upload.php")
           
           // MARK: [사진 파일 파라미터 이름 정의 실시]
           let file = "file"
           
           // MARK: [전송할 데이터 파라미터 정의 실시]
           var reqestParam : Dictionary<String, Any> = [String : Any]()
           reqestParam["idx"] = 201 // 일반 파라미터
           reqestParam["\(file)"] = self.imageData! as NSData // 사진 파일
           
           // [boundary 설정 : 바운더리 라인 구분 필요 위함]
           let boundary = "Boundary-\(UUID().uuidString)" // 고유값 지정
           
           print("")
           print("====================================")
           print("[A_Image >> requestPOST() :: 바운더리 라인 구분 확인 실시]")
           print("boundary :: ", boundary)
           print("====================================")
           print("")
           
           // [http 통신 타입 및 헤더 지정 실시]
           var requestURL = URLRequest(url: (urlComponents?.url)!) // url 주소 지정
           requestURL.httpMethod = "POST" // POST 방식
           requestURL.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type") // 멀티 파트 타입
           
           // [서버로 전송할 uploadData 데이터 형식 설정]
           var uploadData = Data()
           let boundaryPrefix = "--\(boundary)\r\n"
           
           // [멀티 파트 전송 파라미터 삽입 : 딕셔너리 for 문 수행]
           for (key, value) in reqestParam {
               if "\(key)" == "\(file)" { // MARK: [사진 파일 인 경우]
                   print("")
                   print("====================================")
                   print("[A_Image >> requestPOST() :: 멀티 파트 전송 파라미터 확인 실시]")
                   print("타입 :: ", "사진 파일")
                   print("key :: ", key)
                   print("value :: ", value)
                   print("====================================")
                   print("")
                   
                   uploadData.append(boundaryPrefix.data(using: .utf8)!)
                   uploadData.append("Content-Disposition: form-data; name=\"\(file)\"; filename=\"\(file)\"\r\n".data(using: .utf8)!) // [파라미터 key 지정]
                   uploadData.append("Content-Type: \("image/jpg")\r\n\r\n".data(using: .utf8)!) // [전체 이미지 타입 설정]
                   uploadData.append(value as! Data) // [사진 파일 삽입]
                   uploadData.append("\r\n".data(using: .utf8)!)
                   uploadData.append("--\(boundary)--".data(using: .utf8)!)
               }else { // MARK: [일반 파라미터인 경우]
                   print("")
                   print("====================================")
                   print("[A_Image >> requestPOST() :: 멀티 파트 전송 파라미터 확인 실시]")
                   print("타입 :: ", "일반 파라미터")
                   print("key :: ", key)
                   print("value :: ", value)
                   print("====================================")
                   print("")
                   
                   uploadData.append(boundaryPrefix.data(using: .utf8)!)
                   uploadData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!) // [파라미터 key 지정]
                   uploadData.append("\(value)\r\n".data(using: .utf8)!) // [value 삽입]
               }//end of else if
           }//end of for

           // [http 요쳥을 위한 URLSessionDataTask 생성]
           print("")
           print("====================================")
           print("[A_Image >> requestPOST() :: 사진 업로드 요청 실시]")
           print("url :: ", requestURL)
           print("uploadData :: ", uploadData)
           print("====================================")
           print("")
           
           // MARK: [URLSession uploadTask 수행 실시]
           let dataTask = URLSession(configuration: .default)
           dataTask.configuration.timeoutIntervalForRequest = TimeInterval(20)
           dataTask.configuration.timeoutIntervalForResource = TimeInterval(20)
           dataTask.uploadTask(with: requestURL, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in

               // [error가 존재하면 종료]
               guard error == nil else {
                   print("")
                   print("====================================")
                   print("[A_Image >> requestPOST() :: 사진 업로드 요청 실패]")
                   print("fail : ", error?.localizedDescription ?? "")
                   print("====================================")
                   print("")
                   return
               }//end of error

               // [status 코드 체크 실시]
               let successsRange = 200..<300
               guard let statusCode = (response as? HTTPURLResponse)?.statusCode, successsRange.contains(statusCode)
               else {
                   print("")
                   print("====================================")
                   print("[A_Image >> requestPOST() :: 사진 업로드 요청 에러]")
                   print("error : ", (response as? HTTPURLResponse)?.statusCode ?? 0)
                   print("allHeaderFields : ", (response as? HTTPURLResponse)?.allHeaderFields ?? "")
                   print("msg : ", (response as? HTTPURLResponse)?.description ?? "")
                   print("====================================")
                   print("")
                   return
               }//end of else

               // [response 데이터 획득, json 형태로 변환]
               let resultCode = (response as? HTTPURLResponse)?.statusCode ?? 0
               let resultLen = data! // 데이터 길이
               do {
                   guard let jsonConvert = try JSONSerialization.jsonObject(with: data!) as? [String: Any] else {
                       print("")
                       print("====================================")
                       print("[A_Image >> requestPOST() :: 사진 업로드 요청 에러]")
                       print("error : ", "json 형식 데이터 convert 에러")
                       print("====================================")
                       print("")
                       return
                   }//end of else
                   guard let JsonResponse = try? JSONSerialization.data(withJSONObject: jsonConvert, options: .prettyPrinted) else {
                       print("")
                       print("====================================")
                       print("[A_Image >> requestPOST() :: 사진 업로드 요청 에러]")
                       print("error : ", "json 형식 데이터 변환 에러")
                       print("====================================")
                       print("")
                       return
                   }//end of else
                   guard let resultString = String(data: JsonResponse, encoding: .utf8) else {
                       print("")
                       print("====================================")
                       print("[A_Image >> requestPOST() :: 사진 업로드 요청 에러]")
                       print("error : ", "json 형식 데이터 >> String 변환 에러")
                       print("====================================")
                       print("")
                       return
                   }//end of else
                   print("")
                   print("====================================")
                   print("[A_Image >> requestPOST() :: 사진 업로드 요청 성공]")
                   print("allHeaderFields : ", (response as? HTTPURLResponse)?.allHeaderFields ?? "")
                   print("resultCode : ", resultCode)
                   print("resultLen : ", resultLen)
                   print("resultString : ", resultString)
                   print("====================================")
                   print("")
               } catch {
                   print("")
                   print("====================================")
                   print("[A_Image >> requestPOST() :: 사진 업로드 요청 에러]")
                   print("error : ", "Trying to convert JSON data to string")
                   print("====================================")
                   print("")
                   return
               }//end of case
           }.resume()//end of fo
          
   }//end of request

    @IBAction func writeBtn(_ sender: UIButton) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://localhost/DB_Con_Write_Kid.php")! as URL)
        
        request.httpMethod="POST"
        
        let postRes="nickname=\(nickname)&s_name=\(s_name.text!)&s_loc=\(s_loc.text!)&s_time=\(s_time1.text!+s_time2.text!)$s_text=\(s_text.text!)"
        
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
            
            
        }//end of Task
        task.resume()
        
    }//end of writeBtn
    


}//end of class


// MARK: [앨범 선택한 이미지 정보를 확인 하기 위한 딜리게이트 선언]
extension WriteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: [사진, 비디오 선택을 했을 때 호출되는 메소드]
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.originalImage]{
            
            // [앨범에서 선택한 사진 정보 확인]
            print("")
            print("====================================")
            print("[A_Image >> imagePickerController() :: 앨범에서 선택한 사진 정보 확인 및 사진 표시 실시]")
            //print("[사진 정보 :: ", info)
            print("====================================")
            print("")
            
            // [이미지 뷰에 앨범에서 선택한 사진 표시 실시]
           // self.imageView.image = img as? UIImage
            
            // [이미지 데이터에 선택한 이미지 지정 실시]
            self.imageData = (img as? UIImage)!.jpegData(compressionQuality: 0.8) as NSData? // jpeg 압축 품질 설정
            /*
            print("")
            print("===============================")
            print("[A_Image >> imagePickerController() :: 앨범에서 선택한 사진 정보 확인 및 사진 표시 실시]")
            print("[imageData :: ", self.imageData)
            print("===============================")
            print("")
            // */
            
            // [멀티파트 서버에 사진 업로드 수행]
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // [1초 후에 동작 실시]
                self.requestPOST()
            }//end of DispatchQueue.main.asyncAfter
        }//end of if let img
        // [이미지 파커 닫기 수행]
        dismiss(animated: true, completion: nil)
    }//end of func imagePickerController
    
    
    
    // MARK: [사진, 비디오 선택을 취소했을 때 호출되는 메소드]
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("")
        print("===============================")
        print("[A_Image >> imagePickerControllerDidCancel() :: 사진, 비디오 선택 취소 수행 실시]")
        print("===============================")
        print("")
        
        // [이미지 파커 닫기 수행]
        self.dismiss(animated: true, completion: nil)
    }//end of imagePickerControllerDidCancel
}//end of dele
