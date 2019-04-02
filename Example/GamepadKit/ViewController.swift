//
//  ViewController.swift
//  GamepadKit
//
//  Created by ibirdbluer on 04/02/2019.
//  Copyright (c) 2019 ibirdbluer. All rights reserved.
//

import UIKit
import GamepadKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let gamepad1 = GamepadView(directions: 2)
        //        gamepad1.backgroundColor = UIColor.lightGray
        gamepad1.frame = CGRect(x: 0, y: 0, width: 200, height: view.bounds.height)
        gamepad1.bgImageName = "摇杆背景"
        view.addSubview(gamepad1)
        
        let gamepad2 = GamepadView(directions: 4)
        //        gamepad2.backgroundColor = UIColor.lightGray
        gamepad2.frame = CGRect(x: view.bounds.width-200, y: 0, width: 200, height: view.bounds.height)
        gamepad2.bgImageName = "按钮"
        view.addSubview(gamepad2)
        
        gamepad2.actionHandler = { type in
            switch type {
            case .up:
                print("2 up")
            case .down:
                print("2 down")
            case .left:
                print("2 left")
            case .right:
                print("2 right")
            default:
                print("2 none")
            }
        }
        
        gamepad1.actionHandler = { type in
            switch type {
            case .up:
                print("1 up")
            case .down:
                print("1 down")
            case .left:
                print("1 left")
            case .right:
                print("1 right")
            default:
                print("1 none")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

