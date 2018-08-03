//
//  LoginViewController.swift
//  GMapsPractice
//
//  Created by يعرب المصطفى on 4/20/18.
//  Copyright © 2018 yarob. All rights reserved.
//

import UIKit
import Segmentio
import Spring

class LoginViewController: UIViewController {

    @IBOutlet weak var segmentControl: Segmentio!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var statusImage: SpringImageView!
    
    @IBOutlet weak var statusTitleLabel: SpringLabel!
    
    @IBOutlet weak var statusDescriptionLabel: SpringLabel!
    
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.statusTitleLabel.textColor = Colors.mainColor

        // Do any additional setup after loading the view.
        setSegmentControl()
    }
    
    @IBAction func logouButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func changeStatusRequest(status : Int)
    {
        Service.changeStatus(statusType: status) { ( error) in
            print("done")
        }
    }
    
    
}

extension LoginViewController
{
    func setSegmentControl()
    {
        var content = [SegmentioItem]()
        
        let stuItem = SegmentioItem(
            title: "available", image: nil
        )
        
        let driverItem = SegmentioItem(
            title: "busy", image: nil
        )
        
        let unAvailableItem = SegmentioItem(
            title: "unavailable", image: nil
        )
        content.append(stuItem)
        content.append(driverItem)
        content.append(unAvailableItem)
        
        
        let fontSize:CGFloat = 15.0
        var titleFont = UIFont(name: "Avenir Next", size: fontSize)!
        titleFont = UIFont.boldSystemFont(ofSize: titleFont.pointSize)
    
        let states = SegmentioStates(
            defaultState: SegmentioState(
                backgroundColor: .clear,
                titleFont: titleFont,
                titleTextColor: .black
            ),
            selectedState: SegmentioState(
                backgroundColor: .clear,
                titleFont: titleFont,
                titleTextColor: .black
            ),
            highlightedState: SegmentioState(
                backgroundColor: .clear,
                titleFont: titleFont,
                titleTextColor: .white
            )
        )
        
        
        let options = SegmentioOptions(
            backgroundColor: .clear,
            //segmentPosition: SegmentioPosition,
            scrollEnabled: true,
            indicatorOptions: SegmentioIndicatorOptions(type: .top, ratio: 1, height: 5, color: Colors.mainColor),
            horizontalSeparatorOptions: SegmentioHorizontalSeparatorOptions(type: .none, height: 20, color: UIColor.red),
            verticalSeparatorOptions: SegmentioVerticalSeparatorOptions(ratio: 0.6, color: UIColor(hex: "F0F2F6")),
            imageContentMode: .center,
            labelTextAlignment: .center,
            segmentStates: states
        )
        
        
        
    
        
        segmentControl.selectedSegmentioIndex = 0
        segmentControl.setup(
            content: content,
            style: SegmentioStyle.onlyLabel,
            options: options
        )
        
        segmentControl.valueDidChange = { segmentio, segmentIndex in
            self.counter = self.counter + 1
            var newStatus = 0
            if self.counter == 4
            {
                self.performSegue(withIdentifier: "toHelpView", sender: nil)
                return
            }
            let image : UIImage!
            let selectedIndex = segmentio.selectedSegmentioIndex
            let selectedColor:UIColor!
            if selectedIndex == 0
            {
                newStatus = 1
               image = UIImage(named: "like")
                selectedColor = Colors.mainColor
                self.statusTitleLabel.textColor = selectedColor
                self.statusTitleLabel.text = "Available"
                self.statusDescriptionLabel.text = "I am now available and ready to help anyone waiting for me"
                
            }else if selectedIndex == 1
            {
                newStatus = 2
                selectedColor = UIColor(hex: "#ecac15")
                image = UIImage(named: "stop")
                self.statusTitleLabel.textColor = selectedColor
                self.statusTitleLabel.text = "Busy"
                self.statusDescriptionLabel.text = "I am helping someone at the current time and will be available soon"
            }else
            {
                newStatus = 3
                selectedColor = UIColor(hex: "#c61a14")
                self.statusTitleLabel.textColor = selectedColor
                image = UIImage(named: "dislike")
                self.statusTitleLabel.text = "Unavailable"
                self.statusDescriptionLabel.text = "I am unavailable and not ready to help anyone at the time being"
            }
            
            self.changeStatusRequest(status: newStatus)
            self.statusImage.animation = "zoomOut"
            self.statusImage.duration = 0.4
            self.statusImage.animateNext {
                self.statusImage.image = image
                self.statusImage.animation = "zoomIn"
                self.statusImage.duration = 0.4
                self.statusImage.animate()
            }
            
        }
    }
    
    
}
