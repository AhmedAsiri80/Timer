//
//  ViewController.swift
//  timer ahmedapp
//
//  Created by Ahmed Assiri on 13/07/1443 AH.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerOn: UILabel!
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var reset: UIButton!
 
    var timer:Timer = Timer()
    
    var count:Int = 0
    
    var timerCounting:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        start.setTitleColor(UIColor.green, for: .normal)
        // Do any additional setup after loading the view.
    }

    @IBAction func startAction(_ sender: Any) {
        let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure you would like to reset the Timer? ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
           
        }))
        
        alert.addAction(UIAlertAction(title: "yes", style: .default, handler: { (_) in
            self.count = 0
            self.timer.invalidate()
            self.timerOn.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.start.setTitle("START", for: .normal)
            self.start.setTitleColor(UIColor.green, for: .normal)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func resetAction(_ sender: Any) {
        
        if(timerCounting) {
           timerCounting = false
            timer.invalidate()
            start.setTitle("START", for: .normal)
            start.setTitleColor(UIColor.green, for: .normal)
        }
        
        else{
            
            timerCounting = true
            start.setTitle("STOP", for: .normal)
            start.setTitleColor(UIColor.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
        
    }
    @objc func timerCounter() -> Void {
        
        count = count + 1
        let time = secondsToHoursNinutesSeconds(seconds: count)
        let timeString  = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timerOn.text = timeString
    }
    
    func secondsToHoursNinutesSeconds(seconds:Int) -> (Int,Int,Int)
    {
        return((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60 ))
    }
    
    func makeTimeString(hours: Int, minutes: Int , seconds : Int) -> String
    {
        var timString = ""
        timString += String(format: "%02d", hours)
        timString += " : "
        
        timString += String(format: "%02d", minutes)
        timString += " : "
        
        timString += String(format: "%02d", seconds)
    
        return timString
    }
}

