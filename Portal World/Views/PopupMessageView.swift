//
//  PopupMessageView.swift
//  Portal World
//
//  Created by يعرب المصطفى on 7/30/18.
//  Copyright © 2018 yarob. All rights reserved.
//

import UIKit

class PopupMessageView: UIView {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        customInit()
    }
    
    private func customInit()
    {
        Bundle.main.loadNibNamed("PopupMessageView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.layer.cornerRadius = contentView.layer.cornerRadius
        
    }
    
}
