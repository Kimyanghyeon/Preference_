//
//  ViewController.swift
//  Preference_
//
//  Created by 김양현 on 2022/06/01.
//

import UIKit
import MapKit
import SafariServices

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var writeBtn: UIButton!
    @IBOutlet weak var myMap: MKMapView!
    

    
    let locationManager = CLLocationManager()
    
    var responseString : NSString = ""
    
    var checkUser: String = ""
    
    @IBOutlet weak var nicknameText: UILabel!
    var loginUser: String = ""
    
    let logoutText = NSMutableAttributedString(string: "MY")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate=self
        locationManager.desiredAccuracy=kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingHeading()
        myMap?.showsUserLocation=true
        writeBtn.isHidden=true
        
        if checkUser == "1"{
            self.loginBtn.setAttributedTitle(logoutText, for: .normal)
            writeBtn.isHidden=false
        }//end of if
        
        nicknameText.text = loginUser
        
    }//end of viewDidLoad
    
    
    
    
    func goLocation(letitudeValue: CLLocationDegrees,longituseValue:CLLocationDegrees,delta span : Double){
        let pLocation = CLLocationCoordinate2DMake(letitudeValue, longituseValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        myMap.setRegion(pRegion, animated: true)
        //지도에 내 위치
    }//end of goLacaation
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let pLocation = locations.last
        goLocation(letitudeValue: (pLocation?.coordinate.latitude)!, longituseValue: (pLocation?.coordinate.longitude)!, delta: 0.01)

    }//end of locationManager

    @IBAction func moveView(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "로그인"{
            guard let change = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as? LoginViewController else { return }
                        
            change.modalTransitionStyle = .coverVertical // 화면 전환 애니메이션 설정
            self.present(change, animated: true, completion: nil)
            self.writeBtn.isHidden = true
            
            
        }else if sender.titleLabel?.text == "MY"{
            
            guard let change = self.storyboard?.instantiateViewController(withIdentifier: "myPageVC") as? MyPageViewController else { return }
                    
            change.modalTransitionStyle = .coverVertical // 화면 전환 애니메이션 설정
            change.nickname = loginUser
            self.present(change, animated: true, completion: nil)
            self.writeBtn.isHidden = false
        }//end of else if
        
    }//end of moveView
    
    
    @IBAction func writeBtn(_ sender: UIButton) {
        guard let change = self.storyboard?.instantiateViewController(withIdentifier: "writeVC") as? WriteViewController else { return }
                    
        change.modalTransitionStyle = .coverVertical // 화면 전환 애니메이션 설정
        change.nickname = loginUser
        self.present(change, animated: true, completion: nil)
        
    }//end of writeBtn
    
    @IBAction func openWeb(_ sender: UIButton) {
        let url = NSURL(string: "http://ch.yes24.com/Article/View/50962")
        let githubSafariView: SFSafariViewController = SFSafariViewController(url: url as! URL)
        self.present(githubSafariView, animated: true, completion: nil)
    }//end of openWeb
    
    
}//end of class


