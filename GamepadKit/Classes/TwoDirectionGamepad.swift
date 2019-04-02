//
//  TwoDirectionGamepad.swift
//  Gamepad
//
//  Created by Gregory Qian on 2019/4/1.
//  Copyright © 2019 Gregory Qian. All rights reserved.
//

import UIKit

class TwoDirectionGamepad: UIView {

//    @IBOutlet weak var upImageView: UIImageView!
//    @IBOutlet weak var downImageView: UIImageView!

    var upImageView: UIImageView!
    var downImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        upImageView = UIImageView()
        upImageView.image = UIImage(named: "未选中-上")
        addSubview(upImageView)
        
        downImageView = UIImageView()
        downImageView.image = UIImage(named: "未选中-下")
        addSubview(downImageView)
    }
    
    func up() {
        upImageView.image = UIImage(named: "选中-上")
        downImageView.image = UIImage(named: "未选中-下")
    }
    
    func down() {
        upImageView.image = UIImage(named: "未选中-上")
        downImageView.image = UIImage(named: "选中-下")
    }
    
    func clear() {
        upImageView.image = UIImage(named: "未选中-上")
        downImageView.image = UIImage(named: "未选中-下")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
