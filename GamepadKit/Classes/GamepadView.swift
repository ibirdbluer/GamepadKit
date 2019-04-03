//
//  GamepadView.swift
//  Gamepad
//
//  Created by Gregory Qian on 2019/3/29.
//  Copyright © 2019 Gregory Qian. All rights reserved.
//

import UIKit

public enum GamepadActionType {
    case none
    case up
    case down
    case left
    case right
}

open class GamepadView: UIView {
    
    //    public lazy var imageView: UIImageView = {
    //        return UIImageView()
    //    }()
    //
    
    open var actionHandler: ((GamepadActionType)->Void)?
    
    public lazy var holdImageView: UIImageView = {
        return UIImageView()
    }()
    
    var gamepadV: UIView?
    var gamepadCenter: CGPoint = .zero
    public var bgImageName: String? {
        didSet {
            DispatchQueue.main.async {
                if let v = self.gamepadV as? NormalGamepad {
                    v.imageView.image = UIImage(named: self.bgImageName!)
                }
                if let v = self.gamepadV as? TwoDirectionGamepad {
                    v.bgImageview.image = UIImage(named: self.bgImageName!)
                }
            }
        }
    }
    
    public var upImageNames: [String]? {
        didSet {
            DispatchQueue.main.async {
                if let v = self.gamepadV as? TwoDirectionGamepad {
                    v.upImages = self.upImageNames
                }
            }
        }
    }
    
    public var downImageNames: [String]? {
        didSet {
            DispatchQueue.main.async {
                if let v = self.gamepadV as? TwoDirectionGamepad {
                    v.downImages = self.downImageNames
                }
            }
        }
    }
    
    public var directions: Int = 4 {
        didSet {
            if directions == 4 {
                
            }else {
                
            }
        }
    }
    public var gamepadWidth: CGFloat = 115
    public var holdpadWidth: CGFloat = 40
    
    private var maxLength: CGFloat = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    convenience public init(directions: Int) {
        self.init()
        self.directions = directions
        
    }
    
    private func setup() {
        backgroundColor = .clear
        
    }
    
    override open func layoutSubviews() {
        if gamepadV != nil {
            maxLength = gamepadWidth/2 - holdpadWidth/2
            print("max length: \(maxLength)")
        }
        super.layoutSubviews()
    }
    
    
    private var holdViewLeadingConstraint: NSLayoutConstraint?
    private var holdViewTopConstraint: NSLayoutConstraint?
    private var holdViewWidthConstraint: NSLayoutConstraint?
    private var holdViewHeightConstraint: NSLayoutConstraint?
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            print("test 5")
            let location = touch.location(in: self)
            gamepadCenter = location
            
            if directions == 4 {
                gamepadV = NormalGamepad()
                guard gamepadV != nil else { return }
                if let v = self.gamepadV as? NormalGamepad {
                    v.imageView.image = UIImage(named: self.bgImageName!)
                }
                gamepadV!.translatesAutoresizingMaskIntoConstraints = false
                //                gamepadV!.backgroundColor = UIColor.lightGray
                addSubview(gamepadV!)
                
                if #available(iOS 9.0, *) {
                    gamepadV!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: location.x-gamepadWidth/2).isActive = true
                    gamepadV!.topAnchor.constraint(equalTo: self.topAnchor, constant: location.y-gamepadWidth/2).isActive = true
                    gamepadV!.widthAnchor.constraint(equalToConstant: gamepadWidth).isActive = true
                    gamepadV!.heightAnchor.constraint(equalToConstant: gamepadWidth).isActive = true
                } else {
                    // Fallback on earlier versions
                }
                
                
                
                holdImageView.image = UIImage(named: "按钮中间部分")
                addSubview(holdImageView)
                holdImageView.frame = CGRect(x: 0, y: 0, width: holdpadWidth, height: holdpadWidth)
                holdImageView.center = location
                
            }else {
                gamepadV = TwoDirectionGamepad()
                guard gamepadV != nil else { return }
                
                if let v = self.gamepadV as? TwoDirectionGamepad {
                    v.downImages = self.downImageNames
                    v.upImages = self.upImageNames
                    v.bgImageview.image = UIImage(named: self.bgImageName!)
                }
                
                gamepadV!.translatesAutoresizingMaskIntoConstraints = false
                //                gamepadV!.backgroundColor = UIColor.lightGray
                addSubview(gamepadV!)
                
                if #available(iOS 9.0, *) {
                    gamepadV!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: location.x-gamepadWidth/2).isActive = true
                    gamepadV!.topAnchor.constraint(equalTo: self.topAnchor, constant: location.y-gamepadWidth/2).isActive = true
                    gamepadV!.widthAnchor.constraint(equalToConstant: gamepadWidth).isActive = true
                    gamepadV!.heightAnchor.constraint(equalToConstant: gamepadWidth).isActive = true
                } else {
                    // Fallback on earlier versions
                }
                
                
                
            }
            
            layoutIfNeeded()
            
        }
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            print("location: \(location), center: \(gamepadCenter)")
            if directions == 4 {
                holdImageView.center = location
                moveRockerTo(location)
            }else {
                guard let pad = gamepadV as? TwoDirectionGamepad else { return }
                let length = gamepadCenter.y - location.y
                if length > maxLength/3 {
                    pad.up()
                    actionHandler?(.up)
                }else if length < -maxLength/3 {
                    pad.down()
                    actionHandler?(.down)
                }else {
                    pad.clear()
                    actionHandler?(.none)
                }
            }
            
        }
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesEnded")
        if gamepadV!.superview != nil {
            gamepadV!.removeFromSuperview()
        }
        if holdImageView.superview != nil {
            holdImageView.removeFromSuperview()
        }
        actionHandler?(.none)
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesCancelled")
        //        guard imageView.superview != nil else {
        //            print("touchesCancelled nil")
        //            return }
        //        imageView.removeFromSuperview()
        //        holdImageView.removeFromSuperview()
    }
    
    private func moveRockerTo(_ location: CGPoint) {
        let length = gamepadCenter.lengthTo(location)
        if length < maxLength*2/3 {
            print("not enable")
            return
        }
        if length > maxLength {
            let x = (location.x - gamepadCenter.x)*maxLength/length+gamepadCenter.x
            let y = (location.y - gamepadCenter.y)*maxLength/length+gamepadCenter.y
            holdImageView.center = CGPoint(x: x, y: y)
        }else {
            holdImageView.center = location
        }
        
        calculateDirectionInfo()
        
    }
    
    private func calculateDirectionInfo() {
        let y = gamepadCenter.y - holdImageView.center.y
        let x = gamepadCenter.x - holdImageView.center.x
        let d = atan2(x, y)
        if d > CGFloat.pi/4 && d < 3*CGFloat.pi/4 {
            actionHandler?(.left)
        }else if d > 3*CGFloat.pi/4 || d < -3*CGFloat.pi/4 {
            actionHandler?(.down)
        }else if d > -3*CGFloat.pi/4 && d < -CGFloat.pi/4 {
            actionHandler?(.right)
        }else if d > -CGFloat.pi/4 && d < CGFloat.pi/4 {
            actionHandler?(.up)
        }
        if x == 0 && y == 0 {
            actionHandler?(.none)
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

extension CGPoint {
    func lengthTo(_ point: CGPoint) -> CGFloat {
        return sqrt(pow((self.x - point.x), 2) + pow((self.y - point.y), 2));
    }
}
