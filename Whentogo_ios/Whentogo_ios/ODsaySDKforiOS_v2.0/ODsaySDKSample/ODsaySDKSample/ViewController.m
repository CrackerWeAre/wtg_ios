//
//  ViewController.m
//  ODsaySDKSample
//
//  Created by SEONG HOON CHOI on 2017. 9. 11..
//  Copyright © 2017년 SEONG HOON CHOI. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblApiKey;
@property (weak, nonatomic) IBOutlet UIButton *btnApiName;
@property (weak, nonatomic) IBOutlet UILabel *btnParams;
@property (weak, nonatomic) IBOutlet UITextView *paramsView;
@property (weak, nonatomic) IBOutlet UITextView *resultView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblApiKey.text = @"{인증키 값}";            //발급받은 인증 키값 입력
    
    [[ODsayService sharedInst] setApiKey:self.lblApiKey.text];  //SDK 인증
    [[ODsayService sharedInst] setTimeout:10000];               //통신 타임아웃 설정 (밀리세컨드 단위)
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnApiNameAction:(id)sender {
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:nil
                                message:nil
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"취소"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action) {
                              }];
    
    UIAlertAction* button1 = [UIAlertAction
                              actionWithTitle:@"버스 노선 조회"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                  [self.btnApiName setTitle:action.title forState:UIControlStateNormal];
                                  
                                  [[ODsayService sharedInst] requestSearchBusLane:@"150"
                                                                              cid:1000
                                                                    stationListYn:@"no"
                                                                       displayCnt:10
                                                                          startNo:1
                                                                    responseBlock:^(int retCode,  NSDictionary *resultDic) {
                                                                        if(retCode == 200) {
                                                                            self.resultView.text = [self mDictToTextJson:resultDic];
                                                                        } else {
                                                                            [self displayErrorPopup:resultDic];
                                                                        }
                                                                        
                                  self.paramsView.text = [self mDictToTextJson:[[ODsayService sharedInst] getLastReqParams]];
                                }];
                              }];
    
    UIAlertAction* button2 = [UIAlertAction
                              actionWithTitle:@"버스노선 상세정보 조회"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                  [self.btnApiName setTitle:action.title forState:UIControlStateNormal];
                                  
                                  [[ODsayService sharedInst] requestBusLaneDetail:@"12018"
                                                                    responseBlock:^(int retCode,  NSDictionary *resultDic) {
                                                                        if(retCode == 200) {
                                                                            self.resultView.text = [self mDictToTextJson:resultDic];
                                                                        } else {
                                                                            [self displayErrorPopup:resultDic];
                                                                        }
                                  
                                  self.paramsView.text = [self mDictToTextJson:[[ODsayService sharedInst] getLastReqParams]];
                                }];
                              }];
    
    UIAlertAction* button3 = [UIAlertAction
                              actionWithTitle:@"버스정류장 세부정보 조회"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                  [self.btnApiName setTitle:action.title forState:UIControlStateNormal];
                                  
                                  [[ODsayService sharedInst] requestBusStationInfo:@"106572"
                                                                     responseBlock:^(int retCode,  NSDictionary *resultDic) {
                                                                         if(retCode == 200) {
                                                                             self.resultView.text = [self mDictToTextJson:resultDic];
                                                                         } else {
                                                                             [self displayErrorPopup:resultDic];
                                                                         }
                                                                         
                                  self.paramsView.text = [self mDictToTextJson:[[ODsayService sharedInst] getLastReqParams]];
                                }];
                              }];
    
    UIAlertAction* button4 = [UIAlertAction
                              actionWithTitle:@"열차•KTX 운행정보 검색"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                  [self.btnApiName setTitle:action.title forState:UIControlStateNormal];
                                  
                                  [[ODsayService sharedInst] requestTrainServiceTime:@"3300128"
                                                                        endStationID:@"3300108"
                                                                       responseBlock:^(int retCode,  NSDictionary *resultDic) {
                                                                           if(retCode == 200) {
                                                                               self.resultView.text = [self mDictToTextJson:resultDic];
                                                                           } else {
                                                                               [self displayErrorPopup:resultDic];
                                                                           }
                                                                           
                                    self.paramsView.text = [self mDictToTextJson:[[ODsayService sharedInst] getLastReqParams]];
                                }];
                              }];
    
    UIAlertAction* button5 = [UIAlertAction
                              actionWithTitle:@"고속버스 운행정보 검색"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                  [self.btnApiName setTitle:action.title forState:UIControlStateNormal];
                                  
                                  [[ODsayService sharedInst] requestExpressServiceTime:@"4000057"
                                                                          endStationID:@"4000030"
                                                                         responseBlock:^(int retCode,  NSDictionary *resultDic) {
                                                                             if(retCode == 200) {
                                                                                 self.resultView.text = [self mDictToTextJson:resultDic];
                                                                             } else {
                                                                                 [self displayErrorPopup:resultDic];
                                                                             }
                                                                             
                                    self.paramsView.text = [self mDictToTextJson:[[ODsayService sharedInst] getLastReqParams]];
                                }];
                              }];
    
    UIAlertAction* button6 = [UIAlertAction
                              actionWithTitle:@"시외버스 운행정보 검색"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                  [self.btnApiName setTitle:action.title forState:UIControlStateNormal];
                                  
                                  [[ODsayService sharedInst] requestIntercityServiceTime:@"4000022"
                                                                            endStationID:@"4000255"
                                                                           responseBlock:^(int retCode,  NSDictionary *resultDic) {                                                                               
                                                                               if(retCode == 200) {
                                                                                   self.resultView.text = [self mDictToTextJson:resultDic];
                                                                               } else {
                                                                                   [self displayErrorPopup:resultDic];
                                                                               }
                                   
                                   self.paramsView.text = [self mDictToTextJson:[[ODsayService sharedInst] getLastReqParams]];
                                }];
                              }];
    
    UIAlertAction* button7 = [UIAlertAction
                              actionWithTitle:@"항공 운행정보 검색"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                  [self.btnApiName setTitle:action.title forState:UIControlStateNormal];
                                  
                                  [[ODsayService sharedInst] requestAirServiceTime:@"3500001"
                                                                      endStationID:@"3500003"
                                                                        selectTime:6
                                                                     responseBlock:^(int retCode,  NSDictionary *resultDic) {
                                                                               if(retCode == 200) {
                                                                                   self.resultView.text = [self mDictToTextJson:resultDic];
                                                                               } else {
                                                                                   [self displayErrorPopup:resultDic];
                                                                               }
                                   
                                   self.paramsView.text = [self mDictToTextJson:[[ODsayService sharedInst] getLastReqParams]];
                                }];
                              }];
    
    UIAlertAction* button8 = [UIAlertAction
                              actionWithTitle:@"운수회사별 버스노선 조회"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                  [self.btnApiName setTitle:action.title forState:UIControlStateNormal];
                                  
                                  [[ODsayService sharedInst] requestSearchCompanyLane:@"792"
                                                                                busNo:@"100"
                                                                        responseBlock:^(int retCode,  NSDictionary *resultDic) {
                                                                            if(retCode == 200) {
                                                                                self.resultView.text = [self mDictToTextJson:resultDic];
                                                                            } else {
                                                                                [self displayErrorPopup:resultDic];
                                                                            }
                                                                          
                                  self.paramsView.text = [self mDictToTextJson:[[ODsayService sharedInst] getLastReqParams]];
                                }];
                              }];
    
    UIAlertAction* button9 = [UIAlertAction
                              actionWithTitle:@"지하철역 세부 정보 조회"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                  [self.btnApiName setTitle:action.title forState:UIControlStateNormal];
                                  
                                  [[ODsayService sharedInst] requestSubwayStationInfo:@"130"
                                                                        responseBlock:^(int retCode,  NSDictionary *resultDic) {
                                                                            if(retCode == 200) {
                                                                                self.resultView.text = [self mDictToTextJson:resultDic];
                                                                            } else {
                                                                                [self displayErrorPopup:resultDic];
                                                                            }
                                   
                                   self.paramsView.text = [self mDictToTextJson:[[ODsayService sharedInst] getLastReqParams]];
                                }];
                              }];
    
    UIAlertAction* button10 = [UIAlertAction
                              actionWithTitle:@"지하철역 전체 시간표 조회"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                  [self.btnApiName setTitle:action.title forState:UIControlStateNormal];
                                  
                                  [[ODsayService sharedInst] requestSubwayTimeTable:@"130"
                                                                            wayCode:1
                                                                      responseBlock:^(int retCode,  NSDictionary *resultDic) {
                                                                          if(retCode == 200) {
                                                                              self.resultView.text = [self mDictToTextJson:resultDic];
                                                                          } else {
                                                                              [self displayErrorPopup:resultDic];
                                                                          }
                                  
                                  self.paramsView.text = [self mDictToTextJson:[[ODsayService sharedInst] getLastReqParams]];
                                }];
                              }];
    
    UIAlertAction* button11 = [UIAlertAction
                               actionWithTitle:@"노선 그래픽 데이터 검색"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [self.btnApiName setTitle:action.title forState:UIControlStateNormal];
                                   
                                   [[ODsayService sharedInst] requestLoadLane:@"0:0@12018:1:-1:-1"
                                                                responseBlock:^(int retCode,  NSDictionary *resultDic) {
                                                                    if(retCode == 200) {
                                                                        self.resultView.text = [self mDictToTextJson:resultDic];
                                                                    } else {
                                                                        [self displayErrorPopup:resultDic];
                                                                    }
                                   
                                   self.paramsView.text = [self mDictToTextJson:[[ODsayService sharedInst] getLastReqParams]];
                                 }];
                               }];

    UIAlertAction* button12 = [UIAlertAction
                              actionWithTitle:@"대중교통 정류장 검색"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                  [self.btnApiName setTitle:action.title forState:UIControlStateNormal];
                                  
                                  [[ODsayService sharedInst] requestSearchStation:@"11"
                                                                              cid:1000
                                                                     stationClass:@"1:2"
                                                                       displayCnt:10
                                                                          startNo:1
                                                                       myLocation:@"127.0363583:37.5113295"
                                                                    responseBlock:^(int retCode,  NSDictionary *resultDic) {
                                                                        if(retCode == 200) {
                                                                            self.resultView.text = [self mDictToTextJson:resultDic];
                                                                        } else {
                                                                            [self displayErrorPopup:resultDic];
                                                                        }
                                  
                                  self.paramsView.text = [self mDictToTextJson:[[ODsayService sharedInst] getLastReqParams]];
                                }];
                              }];

    UIAlertAction* button13 = [UIAlertAction
                              actionWithTitle:@"반경내 대중교통 POI 검색"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                  [self.btnApiName setTitle:action.title forState:UIControlStateNormal];
                                  
                                  [[ODsayService sharedInst] requestPointSearch:126.933361407195
                                                                              y:37.3643392278118
                                                                         radius:250
                                                                   stationClass:@"1:2"
                                                                  responseBlock:^(int retCode,  NSDictionary *resultDic) {
                                                                           if(retCode == 200) {
                                                                               self.resultView.text = [self mDictToTextJson:resultDic];
                                                                           } else {
                                                                               [self displayErrorPopup:resultDic];
                                                                           }
                                  
                                  self.paramsView.text = [self mDictToTextJson:[[ODsayService sharedInst] getLastReqParams]];
                                }];
                              }];

    UIAlertAction* button14 = [UIAlertAction
                              actionWithTitle:@"지도 위 대중교통 POI 검색"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                  [self.btnApiName setTitle:action.title forState:UIControlStateNormal];
                                  
                                  [[ODsayService sharedInst] requestBoundarySearch:@"127.045478316811:37.68882830829:127.055063420699:37.6370465749586"
                                                                            eparam:@"127.045478316811:37.68882830829:127.055063420699:37.6370465749586"
                                                                      stationClass:@"1:2"
                                                                     responseBlock:^(int retCode,  NSDictionary *resultDic) {
                                                                         if(retCode == 200) {
                                                                             self.resultView.text = [self mDictToTextJson:resultDic];
                                                                         } else {
                                                                             [self displayErrorPopup:resultDic];
                                                                         }
                                  
                                  self.paramsView.text = [self mDictToTextJson:[[ODsayService sharedInst] getLastReqParams]];
                                }];
                              }];

    UIAlertAction* button15 = [UIAlertAction
                              actionWithTitle:@"지하철 경로검색 조회(지하철 노선도)"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                  [self.btnApiName setTitle:action.title forState:UIControlStateNormal];
                                  
                                  [[ODsayService sharedInst] requestSubwayPath:1000
                                                                           sid:201
                                                                           eid:222
                                                                          sopt:1
                                                                 responseBlock:^(int retCode,  NSDictionary *resultDic) {
                                                                     if(retCode == 200) {
                                                                         self.resultView.text = [self mDictToTextJson:resultDic];
                                                                     } else {
                                                                         [self displayErrorPopup:resultDic];
                                                                     }
                                  
                                  self.paramsView.text = [self mDictToTextJson:[[ODsayService sharedInst] getLastReqParams]];
                                }];
                              }];

    UIAlertAction* button16 = [UIAlertAction
                              actionWithTitle:@"대중교통 길찾기"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                  [self.btnApiName setTitle:action.title forState:UIControlStateNormal];
                                  
                                  [[ODsayService sharedInst] requestSearchPubTransPath:@"126.926493082645"
                                                                                    sy:@"37.6134436427887"
                                                                                    ex:@"127.126936754911"
                                                                                    ey:@"37.5004198786564"
                                                                                   opt:0
                                                                            searchType:0
                                                                        searchPathType:0
                                                                         responseBlock:^(int retCode,  NSDictionary *resultDic) {
                                                                                   if(retCode == 200) {
                                                                                       self.resultView.text = [self mDictToTextJson:resultDic];
                                                                                   } else {
                                                                                       [self displayErrorPopup:resultDic];
                                                                                   }
                                  
                                  self.paramsView.text = [self mDictToTextJson:[[ODsayService sharedInst] getLastReqParams]];
                                }];
                              }];

    UIAlertAction* button17 = [UIAlertAction
                              actionWithTitle:@"지하철역 환승 정보 조회"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                  [self.btnApiName setTitle:action.title forState:UIControlStateNormal];
                                  
                                  [[ODsayService sharedInst] requestSubwayTransitInfo:@"133"
                                                                        responseBlock:^(int retCode,  NSDictionary *resultDic) {
                                                                            if(retCode == 200) {
                                                                                self.resultView.text = [self mDictToTextJson:resultDic];
                                                                            } else {
                                                                                [self displayErrorPopup:resultDic];
                                                                            }
                                  
                                  self.paramsView.text = [self mDictToTextJson:[[ODsayService sharedInst] getLastReqParams]];
                                }];
                              }];

    UIAlertAction* button18 = [UIAlertAction
                              actionWithTitle:@"고속버스 터미널 조회"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                  [self.btnApiName setTitle:action.title forState:UIControlStateNormal];
                                  
                                  [[ODsayService sharedInst] requestExpressBusTerminals:1000
                                                                           terminalName:@"서울"
                                                                          responseBlock:^(int retCode,  NSDictionary *resultDic) {
                                                                              if(retCode == 200) {
                                                                                  self.resultView.text = [self mDictToTextJson:resultDic];
                                                                              } else {
                                                                                  [self displayErrorPopup:resultDic];
                                                                              }
                                  
                                  self.paramsView.text = [self mDictToTextJson:[[ODsayService sharedInst] getLastReqParams]];
                                }];
                              }];

    UIAlertAction* button19 = [UIAlertAction
                              actionWithTitle:@"시외버스 터미널 조회"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                  [self.btnApiName setTitle:action.title forState:UIControlStateNormal];
                                  
                                  [[ODsayService sharedInst] requestIntercityBusTerminals:1000
                                                                             terminalName:@"서울"
                                                                            responseBlock:^(int retCode,  NSDictionary *resultDic) {
                                                                              if(retCode == 200) {
                                                                                  self.resultView.text = [self mDictToTextJson:resultDic];
                                                                              } else {
                                                                                  [self displayErrorPopup:resultDic];
                                                                              }
                                  
                                  self.paramsView.text = [self mDictToTextJson:[[ODsayService sharedInst] getLastReqParams]];
                                }];
                              }];

    UIAlertAction* button20 = [UIAlertAction
                              actionWithTitle:@"도시코드 조회"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action) {
                                  [self.btnApiName setTitle:action.title forState:UIControlStateNormal];
                                  
                                  [[ODsayService sharedInst] requestSearchCID:@"서울"
                                                                responseBlock:^(int retCode,  NSDictionary *resultDic) {
                                                                    if(retCode == 200) {
                                                                        self.resultView.text = [self mDictToTextJson:resultDic];
                                                                    } else {
                                                                        [self displayErrorPopup:resultDic];
                                                                    }
                                  
                                  self.paramsView.text = [self mDictToTextJson:[[ODsayService sharedInst] getLastReqParams]];
                                }];
                              }];

    
    
    [alert addAction:button0];
    [alert addAction:button1];
    [alert addAction:button2];
    [alert addAction:button3];
    [alert addAction:button4];
    [alert addAction:button5];
    [alert addAction:button6];
    [alert addAction:button7];
    [alert addAction:button8];
    [alert addAction:button9];
    [alert addAction:button10];
    [alert addAction:button11];
    [alert addAction:button12];
    [alert addAction:button13];
    [alert addAction:button14];
    [alert addAction:button15];
    [alert addAction:button16];
    [alert addAction:button17];
    [alert addAction:button18];
    [alert addAction:button19];
    [alert addAction:button20];
    [self presentViewController:alert animated:YES completion:nil];
    
    [self.paramsView setContentOffset:CGPointZero animated:NO];
    [self.resultView setContentOffset:CGPointZero animated:NO];
}

- (NSString*)mDictToTextJson:(NSDictionary*)rMDic {
    return [NSString stringWithCString:[[rMDic description] cStringUsingEncoding:NSASCIIStringEncoding] encoding:NSNonLossyASCIIStringEncoding];
}

- (void)displayErrorPopup:(NSDictionary*)errorDic {
    NSArray* errArray = [errorDic objectForKey:@"error"];
    NSDictionary* errDic = [errArray firstObject];

    self.resultView.text = [self mDictToTextJson:errorDic];
    
    UIAlertController* alertPopup = [UIAlertController
                                     alertControllerWithTitle:[errDic objectForKey:@"code"]
                                     message:[errDic objectForKey:@"message"]
                                     preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* btnOk = [UIAlertAction
                            actionWithTitle:@"확인"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                                [alertPopup dismissViewControllerAnimated:YES completion:nil];
                                
                            }];
    
    [alertPopup addAction:btnOk];
    [self presentViewController:alertPopup animated:YES completion:nil];
    
}


@end
