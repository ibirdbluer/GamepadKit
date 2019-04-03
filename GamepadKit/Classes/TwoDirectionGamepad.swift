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

    public var upImageView: UIImageView!
    public var downImageView: UIImageView!
    public var bgImageview: UIImageView!
    public var downImages: [String]?
    public var upImages: [String]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        bgImageview = UIImageView()
        bgImageview.contentMode = .scaleAspectFit
        bgImageview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bgImageview)
        
        upImageView = UIImageView()
        upImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(upImageView)

        downImageView = UIImageView()
        downImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(downImageView)
        
        if #available(iOS 9.0, *) {
            bgImageview.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            bgImageview.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            bgImageview.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            bgImageview.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
            
            upImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            upImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -23).isActive = true
            upImageView.widthAnchor.constraint(equalToConstant: 45).isActive = true
            upImageView.heightAnchor.constraint(equalToConstant: 33).isActive = true
            
            downImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            downImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 23).isActive = true
            downImageView.widthAnchor.constraint(equalToConstant: 45).isActive = true
            downImageView.heightAnchor.constraint(equalToConstant: 33).isActive = true
            
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func up() {
        guard upImages?[1] != nil else { return }
        guard downImages?[0] != nil else { return }
        upImageView.image = UIImage(named: upImages![1])
        downImageView.image = UIImage(named: downImages![0])
    }
    
    func down() {
        guard upImages?[0] != nil else { return }
        guard downImages?[1] != nil else { return }
        upImageView.image = UIImage(named: upImages![0])
        downImageView.image = UIImage(named: downImages![1])
    }
    
    func clear() {
        guard upImages?[0] != nil else { return }
        guard downImages?[0] != nil else { return }
        upImageView.image = UIImage(named: upImages![0])
        downImageView.image = UIImage(named: downImages![0])
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
