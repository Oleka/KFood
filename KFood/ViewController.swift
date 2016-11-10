//
//  ViewController.swift
//  KFood
//
//  Created by Oleka on 02/11/16.
//  Copyright © 2016 Olga Blinova. All rights reserved.
//

import UIKit
import AVFoundation
import SystemConfiguration

extension UIColor {
    convenience init(string: String) {
        var chars = string.hasPrefix("#") ? Array(string.characters.dropFirst()) : Array(string.characters)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 1
        switch chars.count {
        case 3:
            chars = [chars[0], chars[0], chars[1], chars[1], chars[2], chars[2]]
            fallthrough
        case 6:
            chars = ["F","F"] + chars
            fallthrough
        case 8:
            a = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
            r = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
            g = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
            b = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
        default:
            a = 0
        }
        self.init(red: r, green: g, blue:  b, alpha: a)
    }
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}


class ViewController: UIViewController {

    @IBOutlet weak var b0: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    @IBOutlet weak var b5: UIButton!
    @IBOutlet weak var b6: UIButton!
    @IBOutlet weak var b7: UIButton!
    @IBOutlet weak var b8: UIButton!
    @IBOutlet weak var b9: UIButton!
    @IBOutlet weak var b10: UIButton!
    @IBOutlet weak var b11: UIButton!
    @IBOutlet weak var b12: UIButton!
    @IBOutlet weak var b13: UIButton!
    @IBOutlet weak var b14: UIButton!
    @IBOutlet weak var b15: UIButton!
    
    @IBOutlet weak var citeLinkButton: UIButton!
    @IBOutlet weak var vkLinkButton: UIButton!
    
    @IBOutlet weak var selectProductLibel: UILabel!
    @IBOutlet weak var selectProductImage: UIImageView!
    
    let KFoodArray = [
    [0,0,0,0,0,0,0,0,0,2,1,0,0,0,0,0],
    [0,0,1,2,2,0,1,0,0,2,2,0,0,0,0,1],
    [0,1,0,1,0,0,2,2,0,2,2,1,0,1,0,0],
    [0,2,1,0,1,0,2,2,1,2,2,0,2,1,1,0],
    [0,2,0,1,0,0,2,2,1,2,2,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0],
    [0,1,2,2,2,0,0,0,0,2,2,0,0,1,0,1],
    [0,0,2,2,2,0,0,0,1,2,1,0,1,2,0,2],
    [0,0,0,1,1,0,0,1,0,2,1,1,2,0,0,1],
    [2,2,2,2,2,2,2,2,2,2,2,0,1,2,2,2],
    [1,2,2,2,2,0,2,1,1,2,2,1,2,2,1,2],
    [0,0,1,0,0,0,0,0,1,0,1,0,0,0,0,0],
    [0,0,0,2,0,0,0,1,2,1,2,0,0,2,0,2],
    [0,0,1,1,0,0,1,2,0,2,2,0,2,0,0,1],
    [0,0,0,1,0,0,0,0,0,2,1,0,0,0,0,0],
    [0,1,0,0,0,0,1,2,1,2,2,0,2,1,0,0]
    
    ]
    
    func f_setButtonsColor(arr: Array<Int>){
        
        var iTag = 0
        while iTag < arr.count {
            if let iButton = self.view.viewWithTag(iTag) as? UIButton {
                iButton.borderWidth=0
                iButton.setTitleColor(UIColor(string: "E9F8D9"), for: .normal)
                if (arr[iTag]==2) {
                    iButton.backgroundColor = UIColor(string: "4D990C")
                }
                else if(arr[iTag]==1){
                    iButton.backgroundColor = UIColor(string: "1C82E1")
                }
                else{
                    iButton.backgroundColor = UIColor(string: "F6651F")
                }
            }
            iTag += 1
        }
    }
    
    func f_playSound(){
        AudioServicesPlaySystemSound(1123)
    }
    
    @IBAction func changeButtonsColor(_ sender: UIButton) {
        let buttonTag:NSInteger = sender.tag
        //Select element of KFoodArray by buttonTag = array for color
        let tagArray = KFoodArray[buttonTag]
        f_setButtonsColor(arr:tagArray)
        f_playSound()
        
        //button design
        sender.borderWidth=2
        sender.borderColor=UIColor(string: "4D990C")
        sender.backgroundColor=UIColor(string: "B3EF73")
        sender.setTitleColor(UIColor(string: "4D990C"), for: .normal)

    }
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func alertMessage(_ userMessage:String){
        
        let myAlert = UIAlertController(title: "Проблема!", message: userMessage, preferredStyle: .alert)
        
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)
        
    }
    
    @IBAction func linkCite(_ sender: UIButton) {
        
        if isInternetAvailable() {
        
            let buttonTag:NSInteger = sender.tag
        
            if buttonTag==100 {
                //URL cite 1-eco.ru
                let citeURL = URL(string: "http://www.1-eco.net")
                UIApplication.shared.open(citeURL!)
            }
            else if buttonTag==101{
                //URL vk.com
                let vkURL = URL(string: "https://vk.com/club132045634")
                UIApplication.shared.open(vkURL!)
            }
            else{
            //nothing)
            }
        }
        else{
            self.alertMessage("Нет доступа к Internet!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background.png")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

