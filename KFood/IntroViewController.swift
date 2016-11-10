//
//  IntroViewController.swift
//  KFood
//
//  Created by Oleka on 09/11/16.
//  Copyright © 2016 Olga Blinova. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    
    @IBOutlet weak var buddistLabel: UILabel!
    @IBOutlet weak var kfoodLabel: UILabel!
    @IBOutlet weak var treeImage: UIImageView!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var coachLabel: UILabel!
    
    func lifeFlow(){
        //Animation?
        self.kfoodLabel.isHidden = true
        self.treeImage.isHidden  = true
        self.coachLabel.isHidden = true
        self.photoImage.isHidden = true
        
        // 1
        var _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(IntroViewController.updateFirstView), userInfo: nil, repeats: false);
        // 2
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(IntroViewController.updateSecondView), userInfo: nil, repeats: false);
        // into Main
        _ = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(IntroViewController.moveToMainView), userInfo: nil, repeats: false);
        
    }
    
    func updateFirstView(){
        self.buddistLabel.isHidden=true
        self.view.backgroundColor = UIColor(string: "B3EF73")
        self.kfoodLabel.isHidden  = false
        self.treeImage.isHidden   = false
        self.coachLabel.isHidden  = true
        self.photoImage.isHidden   = true
    }
    
    func updateSecondView(){
        self.buddistLabel.isHidden=true
        self.view.backgroundColor = UIColor.white
        self.kfoodLabel.isHidden  = true
        self.treeImage.isHidden   = true
        self.coachLabel.isHidden  = false
        self.photoImage.isHidden  = false
    }
    
    func moveToMainView(){
        performSegue(withIdentifier: "Main", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.lifeFlow()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
