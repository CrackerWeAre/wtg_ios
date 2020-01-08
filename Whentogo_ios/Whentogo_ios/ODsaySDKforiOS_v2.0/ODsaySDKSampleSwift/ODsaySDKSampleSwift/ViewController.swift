//
//  ViewController.swift
//  ODsaySDKSampleSwift
//
//  Created by SEONG HOON CHOI on 2017. 9. 18..
//  Copyright © 2017년 SEONG HOON CHOI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblApiKey: UILabel!
    @IBOutlet weak var btnApiName: UIButton!
    @IBOutlet weak var paramsView: UITextView!
    @IBOutlet weak var resultView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblApiKey.text = "{인증키 값}"              //발급받은 인증 키값 입력
        
        ODsayService.sharedInst().setApiKey(self.lblApiKey.text)    //SDK 인증
        ODsayService.sharedInst().setTimeout(10000)                  //통신 타임아웃 설정
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnApiNameAction(_ sender: Any) {
        
        let sheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let button0 = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        let button1 = UIAlertAction(title: "버스 노선 조회", style: .default) { UIAlertAction in
            self.btnApiName.setTitle(UIAlertAction.title, for: .normal)
            
            ODsayService.sharedInst().requestSearchBusLane("150", cid: 1000, stationListYn: "no", displayCnt: 10, startNo: 1) { (retCode:Int32, resultDic:[AnyHashable : Any]?) in
                if retCode == 200 {
                    self.resultView.text = self.mDictToTextJson(rMDic:resultDic)
                } else {
                    self.displayErrorPopup(rMDic: resultDic)
                }
                
                self.paramsView.text = ODsayService.sharedInst().getLastReqParams().description;
            }
        }
        
        let button2 = UIAlertAction(title: "버스노선 상세정보 조회", style: .default) { UIAlertAction in
            self.btnApiName.setTitle(UIAlertAction.title, for: .normal)
            
            ODsayService.sharedInst().requestBusLaneDetail("12018") { (retCode:Int32, resultDic:[AnyHashable : Any]?) in
                if retCode == 200 {
                    self.resultView.text = self.mDictToTextJson(rMDic:resultDic)
                    print(resultDic!.description)
                } else {
                    self.displayErrorPopup(rMDic: resultDic)
                }
                
                self.paramsView.text = ODsayService.sharedInst().getLastReqParams().description;
            }
        }
        
        let button3 = UIAlertAction(title: "버스정류장 세부정보 조회", style: .default) { UIAlertAction in
            self.btnApiName.setTitle(UIAlertAction.title, for: .normal)
            
            ODsayService.sharedInst().requestBusStationInfo("106572") { (retCode:Int32, resultDic:[AnyHashable : Any]?) in
                if retCode == 200 {
                    self.resultView.text = self.mDictToTextJson(rMDic:resultDic)
                } else {
                    self.displayErrorPopup(rMDic: resultDic)
                }
                
                self.paramsView.text = ODsayService.sharedInst().getLastReqParams().description;
            }
        }
        
        let button4 = UIAlertAction(title: "열차•KTX 운행정보 검색", style: .default) { UIAlertAction in
            self.btnApiName.setTitle(UIAlertAction.title, for: .normal)
            
            ODsayService.sharedInst().requestTrainTime("3300128", endStationID: "3300108") { (retCode:Int32, resultDic:[AnyHashable : Any]?) in
                if retCode == 200 {
                    self.resultView.text = self.mDictToTextJson(rMDic:resultDic)
                } else {
                    self.displayErrorPopup(rMDic: resultDic)
                }
                
                self.paramsView.text = ODsayService.sharedInst().getLastReqParams().description;
            }
        }
        
        let button5 = UIAlertAction(title: "고속버스 운행정보 검색", style: .default) { UIAlertAction in
            self.btnApiName.setTitle(UIAlertAction.title, for: .normal)
            
            ODsayService.sharedInst().requestExpressServiceTime("4000057", endStationID: "4000030") { (retCode:Int32, resultDic:[AnyHashable : Any]?) in
                if retCode == 200 {
                    self.resultView.text = self.mDictToTextJson(rMDic:resultDic)
                } else {
                    self.displayErrorPopup(rMDic: resultDic)
                }
                
                self.paramsView.text = ODsayService.sharedInst().getLastReqParams().description;
            }
        }
        
        let button6 = UIAlertAction(title: "시외버스 운행정보 검색", style: .default) { UIAlertAction in
            self.btnApiName.setTitle(UIAlertAction.title, for: .normal)
            
            ODsayService.sharedInst().requestIntercityServiceTime("4000022", endStationID: "4000255") { (retCode:Int32, resultDic:[AnyHashable : Any]?) in
                if retCode == 200 {
                    self.resultView.text = self.mDictToTextJson(rMDic:resultDic)
                } else {
                    self.displayErrorPopup(rMDic: resultDic)
                }
                
                self.paramsView.text = ODsayService.sharedInst().getLastReqParams().description;
            }
        }
        
        let button7 = UIAlertAction(title: "항공 운행정보 검색", style: .default) { UIAlertAction in
            self.btnApiName.setTitle(UIAlertAction.title, for: .normal)
            
            ODsayService.sharedInst().requestAirServiceTime("3500001", endStationID: "3500003", selectTime: 6) { (retCode:Int32, resultDic:[AnyHashable : Any]?) in
                if retCode == 200 {
                    self.resultView.text = self.mDictToTextJson(rMDic:resultDic)
                } else {
                    self.displayErrorPopup(rMDic: resultDic)
                }
                
                self.paramsView.text = ODsayService.sharedInst().getLastReqParams().description;
            }
        }
        
        let button8 = UIAlertAction(title: "운수회사별 버스노선 조회", style: .default) { UIAlertAction in
            self.btnApiName.setTitle(UIAlertAction.title, for: .normal)
            
            ODsayService.sharedInst().requestSearchCompanyLane("792", busNo: "100") { (retCode:Int32, resultDic:[AnyHashable : Any]?) in
                if retCode == 200 {
                    self.resultView.text = self.mDictToTextJson(rMDic:resultDic)
                } else {
                    self.displayErrorPopup(rMDic: resultDic)
                }
                
                self.paramsView.text = ODsayService.sharedInst().getLastReqParams().description;
            }
        }
        
        let button9 = UIAlertAction(title: "지하철역 세부 정보 조회", style: .default) { UIAlertAction in
            self.btnApiName.setTitle(UIAlertAction.title, for: .normal)
            
            ODsayService.sharedInst().requestSubwayStationInfo("130") { (retCode:Int32, resultDic:[AnyHashable : Any]?) in
                if retCode == 200 {
                    self.resultView.text = self.mDictToTextJson(rMDic:resultDic)
                } else {
                    self.displayErrorPopup(rMDic: resultDic)
                }
                
                self.paramsView.text = ODsayService.sharedInst().getLastReqParams().description;
            }
        }
        
        let button10 = UIAlertAction(title: "지하철역 전체 시간표 조회", style: .default) { UIAlertAction in
            self.btnApiName.setTitle(UIAlertAction.title, for: .normal)
            
            ODsayService.sharedInst().requestSubwayTimeTable("130", wayCode: 1) { (retCode:Int32, resultDic:[AnyHashable : Any]?) in
                if retCode == 200 {
                    self.resultView.text = self.mDictToTextJson(rMDic:resultDic)
                } else {
                    self.displayErrorPopup(rMDic: resultDic)
                }
                
                self.paramsView.text = ODsayService.sharedInst().getLastReqParams().description;
            }
        }
        
        let button11 = UIAlertAction(title: "노선 그래픽 데이터 검색", style: .default) { UIAlertAction in
            self.btnApiName.setTitle(UIAlertAction.title, for: .normal)
            
            ODsayService.sharedInst().requestLoadLane("0:0@12018:1:-1:-1") { (retCode:Int32, resultDic:[AnyHashable : Any]?) in
                if retCode == 200 {
                    self.resultView.text = self.mDictToTextJson(rMDic:resultDic)
                } else {
                    self.displayErrorPopup(rMDic: resultDic)
                }
                
                self.paramsView.text = ODsayService.sharedInst().getLastReqParams().description;
            }
        }
        
        let button12 = UIAlertAction(title: "대중교통 정류장 검색", style: .default) { UIAlertAction in
            self.btnApiName.setTitle(UIAlertAction.title, for: .normal)
            
            ODsayService.sharedInst().requestSearchStation("11", cid: 1000, stationClass: "1:2", displayCnt: 10, startNo: 1, myLocation: "127.0363583:37.5113295") { (retCode:Int32, resultDic:[AnyHashable : Any]?) in
                if retCode == 200 {
                    self.resultView.text = self.mDictToTextJson(rMDic:resultDic)
                } else {
                    self.displayErrorPopup(rMDic: resultDic)
                }
                
                self.paramsView.text = ODsayService.sharedInst().getLastReqParams().description;
            }
        }
        
        let button13 = UIAlertAction(title: "반경내 대중교통 POI 검색", style: .default) { UIAlertAction in
            self.btnApiName.setTitle(UIAlertAction.title, for: .normal)
            
            ODsayService.sharedInst().requestPointSearch(126.933361407195, y: 37.3643392278118, radius: 250, stationClass: "1:2") { (retCode:Int32, resultDic:[AnyHashable : Any]?) in
                if retCode == 200 {
                    self.resultView.text = self.mDictToTextJson(rMDic:resultDic)
                } else {
                    self.displayErrorPopup(rMDic: resultDic)
                }
                
                self.paramsView.text = ODsayService.sharedInst().getLastReqParams().description;
            }
        }
        
        let button14 = UIAlertAction(title: "지도 위 대중교통 POI 검색", style: .default) { UIAlertAction in
            self.btnApiName.setTitle(UIAlertAction.title, for: .normal)
            
            ODsayService.sharedInst().requestBoundarySearch("127.045478316811:37.68882830829:127.055063420699:37.6370465749586", eparam: "127.045478316811:37.68882830829:127.055063420699:37.6370465749586", stationClass: "1:2") { (retCode:Int32, resultDic:[AnyHashable : Any]?) in
                if retCode == 200 {
                    self.resultView.text = self.mDictToTextJson(rMDic:resultDic)
                } else {
                    self.displayErrorPopup(rMDic: resultDic)
                }
                
                self.paramsView.text = ODsayService.sharedInst().getLastReqParams().description;
            }
        }
        
        let button15 = UIAlertAction(title: "지하철 경로검색 조회(지하철 노선도)", style: .default) { UIAlertAction in
            self.btnApiName.setTitle(UIAlertAction.title, for: .normal)
            
            ODsayService.sharedInst().requestSubwayPath(1000, sid: 201, eid: 222, sopt: 1) { (retCode:Int32, resultDic:[AnyHashable : Any]?) in
                if retCode == 200 {
                    self.resultView.text = self.mDictToTextJson(rMDic:resultDic)
                } else {
                    self.displayErrorPopup(rMDic: resultDic)
                }
                
                self.paramsView.text = ODsayService.sharedInst().getLastReqParams().description;
            }
        }
        
        let button16 = UIAlertAction(title: "대중교통 길찾기", style: .default) { UIAlertAction in
            self.btnApiName.setTitle(UIAlertAction.title, for: .normal)
            
            ODsayService.sharedInst().requestSearchPubTransPath("126.926493082645", sy: "37.6134436427887", ex: "127.126936754911", ey: "37.5004198786564", opt: 0, searchType: 0, searchPathType: 0) { (retCode:Int32, resultDic:[AnyHashable : Any]?) in
                if retCode == 200 {
                    self.resultView.text = self.mDictToTextJson(rMDic:resultDic)
                } else {
                    self.displayErrorPopup(rMDic: resultDic)
                }
                
                self.paramsView.text = ODsayService.sharedInst().getLastReqParams().description;
            }
        }
        
        let button17 = UIAlertAction(title: "지하철역 환승 정보 조회", style: .default) { UIAlertAction in
            self.btnApiName.setTitle(UIAlertAction.title, for: .normal)
            
            ODsayService.sharedInst().requestSubwayTransitInfo("133") { (retCode:Int32, resultDic:[AnyHashable : Any]?) in
                if retCode == 200 {
                    self.resultView.text = self.mDictToTextJson(rMDic:resultDic)
                } else {
                    self.displayErrorPopup(rMDic: resultDic)
                }
                
                self.paramsView.text = ODsayService.sharedInst().getLastReqParams().description;
            }
        }
        
        let button18 = UIAlertAction(title: "고속버스 터미널 조회", style: .default) { UIAlertAction in
            self.btnApiName.setTitle(UIAlertAction.title, for: .normal)
            
            ODsayService.sharedInst().requestExpressBusTerminals(1000, terminalName: "서울") { (retCode:Int32, resultDic:[AnyHashable : Any]?) in
                if retCode == 200 {
                    self.resultView.text = self.mDictToTextJson(rMDic:resultDic)
                } else {
                    self.displayErrorPopup(rMDic: resultDic)
                }
                
                self.paramsView.text = ODsayService.sharedInst().getLastReqParams().description;
            }
        }
        
        let button19 = UIAlertAction(title: "시외버스 터미널 조회", style: .default) { UIAlertAction in
            self.btnApiName.setTitle(UIAlertAction.title, for: .normal)
            
            ODsayService.sharedInst().requestIntercityBusTerminals(1000, terminalName: "서울") { (retCode:Int32, resultDic:[AnyHashable : Any]?) in
                if retCode == 200 {
                    self.resultView.text = self.mDictToTextJson(rMDic:resultDic)
                } else {
                    self.displayErrorPopup(rMDic: resultDic)
                }
                
                self.paramsView.text = ODsayService.sharedInst().getLastReqParams().description;
            }
        }
        
        let button20 = UIAlertAction(title: "도시코드 조회", style: .default) { UIAlertAction in
            self.btnApiName.setTitle(UIAlertAction.title, for: .normal)
            
            ODsayService.sharedInst().requestSearchCID("서울") { (retCode:Int32, resultDic:[AnyHashable : Any]?) in
                if retCode == 200 {
                    self.resultView.text = self.mDictToTextJson(rMDic:resultDic)
                } else {
                    self.displayErrorPopup(rMDic: resultDic)
                }
                
                self.paramsView.text = ODsayService.sharedInst().getLastReqParams().description;
            }
        }
        
        sheetController.addAction(button0)
        sheetController.addAction(button1)
        sheetController.addAction(button2)
        sheetController.addAction(button3)
        sheetController.addAction(button4)
        sheetController.addAction(button5)
        sheetController.addAction(button6)
        sheetController.addAction(button7)
        sheetController.addAction(button8)
        sheetController.addAction(button9)
        sheetController.addAction(button10)
        sheetController.addAction(button11)
        sheetController.addAction(button12)
        sheetController.addAction(button13)
        sheetController.addAction(button14)
        sheetController.addAction(button15)
        sheetController.addAction(button16)
        sheetController.addAction(button17)
        sheetController.addAction(button18)
        sheetController.addAction(button19)
        sheetController.addAction(button20)
        self.present(sheetController, animated: true, completion: nil)
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
    
    func displayErrorPopup(rMDic:[AnyHashable : Any]?) -> Void {
        self.resultView.text = self.mDictToTextJson(rMDic:rMDic)
        if let errArray = rMDic?["error"] as! [AnyObject]? {
            if let errDic = errArray[0] as? [String: AnyObject] {
                let alertController = UIAlertController(title: errDic["code"] as? String, message: errDic["message"] as? String, preferredStyle: .alert)
                let button0 = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertController.addAction(button0)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
}

