//
//  NormalGamepad.swift
//  Gamepad
//
//  Created by Gregory Qian on 2019/4/1.
//  Copyright © 2019 Gregory Qian. All rights reserved.
//

import UIKit

class NormalGamepad: UIView {
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        imageView = UIImageView()
        imageView.image = UIImage(named: "按钮")
        imageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        imageView.translatesAutoresizingMaskIntoConstraints = false

//        imageView.frame = self.bounds
        addSubview(imageView)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if #available(iOS 9.0, *) {
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
            imageView.topAnchor.constraint(equalTo: self.topAnchor)
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor)
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor)
        } else {
            // Fallback on earlier versions
        }


    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
