//
//  HelpViewController.swift
//  Portal World
//
//  Created by يعرب المصطفى on 8/2/18.
//  Copyright © 2018 yarob. All rights reserved.
//

import UIKit
import Spring
import Pulsator

class HelpViewController: UIViewController {
    @IBOutlet weak var imageView: SpringImageView!
    
    @IBOutlet weak var helpLabel: SpringLabel!
    
    @IBOutlet weak var helpDescriptionLabel: SpringLabel!
    
    @IBOutlet weak var startButton: CustomizableButton!
    
    let pulsator = Pulsator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helpLabel.isHidden = true
        helpDescriptionLabel.isHidden = true
        startButton.isHidden = true
        animateTheScene()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    private func animateTheScene()
    {
        startButton.animation = "zoomIn"
        startButton.duration = 0.8
        helpLabel.animation = "fadeInDown"
        helpDescriptionLabel.animation = "fadeInDown"
        helpLabel.duration = 0.75
        helpDescriptionLabel.duration = 0.75
        imageView.animation = "zoomIn"
        imageView.duration = 0.75
        
        imageView.animateNext {
            self.helpLabel.isHidden = false
            self.helpLabel.animateNext {
                self.helpDescriptionLabel.isHidden = false
                self.helpDescriptionLabel.animateNext {
                    self.startButton.isHidden = false
                    self.startButton.animateNext {
                        self.pulseTheIcon()
                    }
                }
            }
        }
    }
    
    private func pulseTheIcon()
    {
//        let pulseEffect = LFTPulseAnimation(repeatCount: Float.infinity, radius:200, position:imageView.frame.origin)
//        pulseEffect.position.y = pulseEffect.position.y - 20
//        pulseEffect.backgroundColor = UIColor.init(hex: "#FC5C4D").cgColor
//        view.sendSubview(toBack: pulseEffect)
//        imageView.layer.insertSublayer(pulseEffect, below: imageView.layer)
        view.layer.insertSublayer(pulsator, at: 0)
        pulsator.numPulse = 2
        pulsator.animationDuration = 3
        pulsator.backgroundColor = UIColor.init(hex: "#FC5C4D").cgColor
        pulsator.position = imageView.center
        pulsator.radius = 200
        pulsator.start()
        
        
    }
    
    @IBAction func startButtonClicked(_ sender: UIButton) {
        animateTheScene()
    }
    
    @IBAction func skipButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
