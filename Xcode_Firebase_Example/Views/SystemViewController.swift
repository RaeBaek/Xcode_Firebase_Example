//
//  SystemViewController.swift
//  Xcode_Firebase_Example
//
//  Created by 백래훈 on 2022/04/11.
//

import UIKit
import Firebase

class SystemViewController: UIViewController {
    
    @IBOutlet weak var humanLabel: UILabel!
    @IBOutlet weak var doorLabel: UILabel!
    @IBOutlet weak var flameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humiLabel: UILabel!
    @IBOutlet weak var onOffLabel: UILabel!
    
    @IBOutlet weak var humanView: UIView!
    @IBOutlet weak var doorView: UIView!
    @IBOutlet weak var flameView: UIView!
    @IBOutlet weak var tempHumiView: UIView!
    
    @IBOutlet weak var tempSign: UILabel!
    @IBOutlet weak var humiSign: UILabel!
    @IBOutlet weak var slashLabel: UILabel!
    
    @IBOutlet weak var cctvButton: UIButton!
    
    var singList: [Sing] = []
    
    var timer: DispatchSourceTimer?
    
//    let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setJasonData), userInfo: nil, repeats: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        uiSet()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setJasonData), userInfo: nil, repeats: true)
        
        if timer == nil {
            // 1
            timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
            
            // 2
            timer?.schedule(deadline: .now(), repeating: 1)
            
            // 3
            timer?.setEventHandler(handler: {
                print(Date())
                self.setJasonData()
            })
        }
        
        timer?.resume()
        
    }
    
    //MARK: - @IBActions
    @IBAction func timeLineButtonDidTab(_ sender: UIButton) {
        
        let timeLineVC = self.storyboard?.instantiateViewController(withIdentifier: "TimelineViewController")
        self.navigationController?.pushViewController(timeLineVC!, animated: true)
        
        timer?.suspend()
        
    }
    
    @IBAction func notiButtonDidTab(_ sender: UIButton) {
        
        sender.isSelected.toggle()
        
        if sender.isSelected == true {
            
            onOffLabel.text = "OFF"
            humanLabel.text = "알림 OFF"
            doorLabel.text = "알림 OFF"
            flameLabel.text = "알림 OFF"
            slashLabel.text = "알림 OFF"
            tempLabel.text = ""
            humiLabel.text = ""
            tempSign.text = ""
            humiSign.text = ""
            
            timer?.suspend()
            
        } else if sender.isSelected == false {
            
            onOffLabel.text = "ON"
            slashLabel.text = "/"
            tempSign.text = "°C"
            humiSign.text = "%"
            timer?.resume()
            
        }
    }
    
    @IBAction func setButtonDidTab(_ sender: UIButton) {
        
        let setVC = self.storyboard?.instantiateViewController(withIdentifier: "SetViewController")
        self.navigationController?.pushViewController(setVC!, animated: true)
        
        timer?.suspend()
    }
    
    @IBAction func cctvButtonDidTab(_ sender: UIButton) {
        
        let cctvVC = self.storyboard?.instantiateViewController(withIdentifier: "CctvViewController")
        self.navigationController?.pushViewController(cctvVC!, animated: true)
        
        timer?.suspend()
    }
    
    
    //MARK: - Functions
    func setNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func setJasonData() {
            
            // 데이터베이스 선언
            let db = Database.database().reference().child("setData")
            let db_doorOpen = Database.database().reference().child("setData").child("Door_Open")
            let db_fire = Database.database().reference().child("setData").child("Flame")
            let db_human = Database.database().reference().child("setData").child("Human")
            let db_tempHumi = Database.database().reference().child("setData").child("Temp_Humi")
            
            // 데이터베이스 안에 자식으로 들어가는 Data 생성
            //        db.child("Temp_Humi").setValue(["temp":"21","humi":"52"])
            //        db.child("Flame").setValue(["flame":"warning"])
            //        db.child("Door_Open").setValue(["open":"yes"])
            //        db.child("Human").setValue(["human":"yes"])
            
            
            //        db.observeSingleEvent(of: .value, with: { (snapshot) in
            //            //snapshot의 값을 딕셔너리 형태로 변경해줍니다.
            //            //guard
            //            let snapData = snapshot.value as? NSDictionary //[String : Any] else { return }
            //
            //            //Data를 JSON형태로 변경해줍니다.
            //            //let data = try! JSONSerialization.data(withJSONObject: Array(snapData.values), options: [])
            //
            //            let humanValue = snapData?["Door_open"] as? String ?? ""
            //            let doorValue = snapData?["open"] as? String ?? ""
            //            let flameValue = snapData?["fire"] as? String ?? ""
            //            let humiValue = snapData?["humi"] as? String ?? ""
            //            let tempValue = snapData?["temp"] as? String ?? ""
            //
            //            //print("\(snapData.values)")
            //            print(humanValue)
            //            print(doorValue)
            //            print(flameValue)
            //            print(humiValue)
            //            print(tempValue)
            //
            //        }) { (error) in
            //            print(error.localizedDescription)
            //        }
            
            // 문열림 db에서 문열림 값 가져옴
            db_doorOpen.observeSingleEvent(of: .value, with: { (snapshot) in
                
                let snapData = snapshot.value as? NSDictionary
                let openValue = snapData?["open"] as? String ?? ""
                
                print(openValue)
                
                if openValue == "yes" {
                    self.doorLabel.text = "문 열림"
                } else if openValue == "no" {
                    self.doorLabel.text = "문 닫힘"
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
            
            // 화재감지 db에서 화재 값 가져옴
            db_fire.observeSingleEvent(of: .value, with: { (snapshot) in
                
                let snapData = snapshot.value as? NSDictionary
                let flameValue = snapData?["flame"] as? String ?? ""
                
                print(flameValue)
                
                if flameValue == "warning" {
                    self.flameLabel.text = "화재 감지됨"
                } else if flameValue == "safety" {
                    self.flameLabel.text = "화재 감지되지 않음"
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
            
            // 인체감지 db에서 인체감지 값 가져옴
            db_human.observeSingleEvent(of: .value, with: { (snapshot) in
                
                let snapData = snapshot.value as? NSDictionary
                let humanValue = snapData?["human"] as? String ?? ""
                
                print(humanValue)
                
                if humanValue == "yes" {
                    self.humanLabel.text = "인체 감지됨"
                } else if humanValue == "no" {
                    self.humanLabel.text = "인체 감지되지 않음"
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
            
            // 온습도 db에서 온습도감지 값 가져옴
            db_tempHumi.observeSingleEvent(of: .value, with: { (snapshot) in
                
                let snapData = snapshot.value as? NSDictionary
                let humiValue = snapData?["humi"] as? String ?? ""
                let tempValue = snapData?["temp"] as? String ?? ""
                
                print(humiValue)
                print(tempValue)
                
                self.humiLabel.text = "\(humiValue)"
                self.tempLabel.text = "\(tempValue)"
                
            }) { (error) in
                print(error.localizedDescription)
            }
    }
    
    func uiSet() {
        humanView.layer.cornerRadius = 10
        doorView.layer.cornerRadius = 10
        flameView.layer.cornerRadius = 10
        tempHumiView.layer.cornerRadius = 10
        cctvButton.layer.cornerRadius = 10
    }
    
    func timerFunc() {
    }
}
