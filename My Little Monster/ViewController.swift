//
//  ViewController.swift
//  My Little Monster
//
//  Created by Alexander Besson on 2015-12-12.
//  Copyright © 2015 Alexander Besson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imgMonster: UIImageView!
    @IBOutlet weak var imgFood: DragImage!
    @IBOutlet weak var imgHeart: DragImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgMonster.animationImages = []
        
        var imgArray = [UIImage]()
        
        for var x = 1; x <= 4; x++ {
            var img = UIImage(named: "idle\(x)")
            imgArray.append(img!)
        }
        
        imgMonster.animationImages = imgArray
        imgMonster.animationDuration = 0.8
        imgMonster.animationRepeatCount = 0
        imgMonster.startAnimating()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("Screen was touched.")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

