//
//  ViewController.swift
//  My Little Monster
//
//  Created by Alexander Besson on 2015-12-12.
//  Copyright © 2015 Alexander Besson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imgMonster: MonsterImage!
    @IBOutlet weak var imgFood: DragImage!
    @IBOutlet weak var imgHeart: DragImage!

    @IBOutlet weak var imgLeftSkull: UIImageView!
    @IBOutlet weak var imgCenterSkull: UIImageView!
    @IBOutlet weak var imgRightSkull: UIImageView!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE_ALPHA: CGFloat = 1.0
    let MAX_PENALTIES = 3
    var penalties = 0
    
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgFood.dropTarget = imgMonster
        imgHeart.dropTarget = imgMonster
        
        imgLeftSkull.alpha = DIM_ALPHA
        imgCenterSkull.alpha = DIM_ALPHA
        imgRightSkull.alpha = DIM_ALPHA
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        startTimer()
    }
    
    func itemDroppedOnCharacter(nitif: AnyObject) {
        print("Item dropped on character.")
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        penalties++
        
        if penalties == 1 {
            imgLeftSkull.alpha = OPAQUE_ALPHA
            imgCenterSkull.alpha = DIM_ALPHA
        } else if penalties == 2 {
            imgCenterSkull.alpha = OPAQUE_ALPHA
            imgRightSkull.alpha = DIM_ALPHA
        } else if penalties >= 3 {
            imgRightSkull.alpha = OPAQUE_ALPHA
        } else {
            imgLeftSkull.alpha = DIM_ALPHA
            imgCenterSkull.alpha = DIM_ALPHA
            imgRightSkull.alpha = DIM_ALPHA
        }
        
        if penalties >= MAX_PENALTIES {
            gameOver()
        }
    }
    
    func gameOver() {
        timer.invalidate()
        imgMonster.playDeathAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

