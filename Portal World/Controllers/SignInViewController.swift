//
//  SignInViewController.swift
//  Portal World
//
//  Created by يعرب المصطفى on 8/2/18.
//  Copyright © 2018 yarob. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Spring

class SignInViewController: UIViewController {

 
    
   
    
    @IBOutlet weak var logoImageView: SpringImageView!
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginViewButton: CustomizableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setGestureReconizer()
        setEnterAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setGestureReconizer()
    {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(loginTapped))
        loginViewButton.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func loginTapped()
    {
        loginLabel.isHidden = true
        activityIndicator.startAnimating()
        //performSegue(withIdentifier: "loginViewButton", sender: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: "toStatusViewController", sender: nil)
        }
        
    }
    
    
    private func setEnterAnimation()
    {
        logoImageView.animation = "fadeInDown"
        logoImageView.duration = 1.5
        logoImageView.force = 1.5
        logoImageView.animateNext {
            
        }
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
