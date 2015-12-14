//
//  ViewController.swift
//  My Little Monster
//
//  Created by Alexander Besson on 2015-12-12.
//  Copyright © 2015 Alexander Besson. All rights reserved.
//

import UIKit
import AVFoundation

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
    var monsterHappy = false
    var currentItem: UInt32 = 0
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgFood.dropTarget = imgMonster
        imgHeart.dropTarget = imgMonster
        
        imgLeftSkull.alpha = DIM_ALPHA
        imgCenterSkull.alpha = DIM_ALPHA
        imgRightSkull.alpha = DIM_ALPHA
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxSkull.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        startTimer()
    }
    
    func itemDroppedOnCharacter(nitif: AnyObject) {
        monsterHappy = true
        startTimer()
        
        imgFood.alpha = DIM_ALPHA
        imgFood.userInteractionEnabled = false
        imgHeart.alpha = DIM_ALPHA
        imgHeart.userInteractionEnabled = false
        
        if currentItem == 0 {
            sfxHeart.play()
        } else {
            sfxBite.play()
        }
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        
        if !monsterHappy {
            penalties++
            
            sfxSkull.play()
            
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
    
        let rand = arc4random_uniform(2) // will give 0 or 1
        
        if rand == 0 {
            imgFood.alpha = DIM_ALPHA
            imgFood.userInteractionEnabled = false
            
            imgHeart.alpha = OPAQUE_ALPHA
            imgHeart.userInteractionEnabled = true
        } else {
            imgHeart.alpha = DIM_ALPHA
            imgHeart.userInteractionEnabled = false
            
            imgFood.alpha = OPAQUE_ALPHA
            imgFood.userInteractionEnabled = true
        }
        
        currentItem = rand
        monsterHappy = false
        
    }
    
    func gameOver() {
        timer.invalidate()
        imgMonster.playDeathAnimation()
        sfxDeath.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

