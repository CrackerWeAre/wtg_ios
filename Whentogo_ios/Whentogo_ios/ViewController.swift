//
//  ViewController.swift
//  Whentogo_ios
//
//  Created by 정윤도 on 2020/01/08.
//  Copyright © 2020 정윤도. All rights reserved.
//

import UIKit
import ODsaySDK
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

  
    @IBOutlet weak var jsontext: UILabel!
    
    override func viewDidLoad() {
        ODsayService.sharedInst().setApiKey("qPt1EFCkMnXiERhw5sw4ag")
        ODsayService.sharedInst().setTimeout(5000)
//        ODsayService.sharedInst().requestBusLaneDetail("12018") {
//            (retCode:Int32, resultDic:[AnyHashable : Any]?) in
//            if retCode == 200 {
//                    self.jsontext.text=resultDic!.description
//            } else {
//                    self.jsontext.text=resultDic!.description
//            }
//        }
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
   
    func convertplacetolatlon(address:String) -> Void {
        let address = "강남역"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
           let placemark = placemarks?.first
           let lat = placemark?.location?.coordinate.latitude
           let lon = placemark?.location?.coordinate.longitude
        }
    }
    

     let locationManager = CLLocationManager()

    override func viewDidAppear(_ animated: Bool) {
        self.locationManager.delegate = self                  // 뷰 컨트롤러를 로케이션 매니저 객체에 대한 앱델리게이트로 선언
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest  // 정확도 : 최고
        self.locationManager.requestWhenInUseAuthorization()  // 위치 정보 권한 허가 요청
        self.locationManager.startUpdatingLocation()          // 위치 정보 갱신 시작
        print(self.locationManager.location)
        //self.locationManager.stopUpdatingLocation()          // 위치 정보 갱신 중단
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //위치가 업데이트 될 때마다 실행될 내용
    }

    func locationManager(_ manager: CLLocationManager,didFailWithError error: Error) {
        //에러 발생
    }

    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?){
        // 더 이상 위치정보를 받아오지 않을 때 실행될 내용
    }


    
    func displayErrorPopup(rMDic:[AnyHashable : Any]?) -> Void {
        self.jsontext.text = self.mDictToTextJson(rMDic:rMDic)
        if let errArray = rMDic?["error"] as! [AnyObject]? {
            if let errDic = errArray[0] as? [String: AnyObject] {
                let alertController = UIAlertController(title: errDic["code"] as? String, message: errDic["message"] as? String, preferredStyle: .alert)
                let button0 = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertController.addAction(button0)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }

    func mDictToTextJson(rMDic:[AnyHashable : Any]?) -> String {
           if let sText = rMDic?.description {
               if let bytes = sText.cString(using: String.Encoding.ascii) {
                   return String(cString: bytes, encoding: String.Encoding.nonLossyASCII)!
               } else {
                   return "No Data is Displayed"
               }
           } else {
               return "No Data is Displayed"
           }
       }
    
}

