//
//  VVDragerViewController.swift
//  VVDragerDemo
//
//  Created by atom on 2017/1/2.
//  Copyright © 2017年 atom. All rights reserved.
//

import UIKit

private let vMargin: CGFloat = 5

private let vEdgeMargin: CGFloat = 60

private let animDuration: TimeInterval = 0.25

enum VVDragerStyle {
    
    case defaultStyle
    
    case left
    
    case right
    
    case same
    
}

class VVDragerViewController: UIViewController {
    
     lazy var leftView: UIView = UIView()
    
     lazy var rightView: UIView = UIView()
    
     lazy var mainView: UIView = UIView()
    
    var vTargetRight: CGFloat = UIScreen.main.bounds.width - vEdgeMargin {
        
        didSet {
            
            if fabs(vTargetRight) > UIScreen.main.bounds.width {
                
                vTargetRight = UIScreen.main.bounds.width - vTargetRight
            
            } else {
                
                vTargetRight = fabs(vTargetRight)
            
            }
        
        }
    
    }
    
    var vTargetLeft: CGFloat = UIScreen.main.bounds.width - vEdgeMargin {
    
        
        didSet {
            
            if fabs(vTargetLeft) > UIScreen.main.bounds.width {
                
                vTargetLeft = vEdgeMargin - UIScreen.main.bounds.width
            
            } else {
                
                vTargetLeft = -fabs(vTargetLeft)
            
            }
        
        }
    
    }
    
    var vMaxY: CGFloat = 100
    
    var vDirection: VVDragerStyle = .left
    
    var isPanRightEable: Bool = false
    
    static var isDirection: Bool = false
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
        
        setupGes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension VVDragerViewController {
    
    fileprivate func setupUI() {
        
        view.backgroundColor = UIColor.lightGray
        
        leftView.frame = view.bounds
        
        leftView.backgroundColor = UIColor.white
        
        view.addSubview(leftView)
        
        
        rightView.frame = view.bounds
        
        rightView.backgroundColor = UIColor.white
        
        view.addSubview(rightView)
        
        
        mainView.frame = view.bounds
        
        mainView.backgroundColor = UIColor.white
        
        view.addSubview(mainView)
        
        mainView.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        
        mainView.layer.shadowOffset = CGSize(width: -2, height: -1)
        
        mainView.layer.shadowOpacity = 0.7
        
        mainView.layer.shadowRadius = 2
    
    }

}

extension VVDragerViewController {
    
    fileprivate func setupGes() {
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan(panGes:)))
        
        mainView.addGestureRecognizer(panGesture)
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tap(tapGes:)))
        
        mainView.addGestureRecognizer(tapgesture)
    
    }

}

extension VVDragerViewController {
    
    @objc fileprivate func tap(tapGes: UITapGestureRecognizer) {
        
        enableSubViews(isEable: false)
        
        UIView.animate(withDuration: animDuration) {
            
            self.mainView.frame = self.view.frame
        
        }
    
    }
    
    @objc fileprivate func pan(panGes: UIPanGestureRecognizer) {
    
        
        setupFrameOffset(panGes: panGes)
    
    }
    
    fileprivate func setupFrameOffset(panGes: UIPanGestureRecognizer){
    
        let tranP = panGes.translation(in: mainView)
        
        let velocity = panGes.velocity(in: mainView)
        
        if tranP.x > 0 {
            
            VVDragerViewController.isDirection = false
        
        } else if (tranP.x < 0 ){
        
            VVDragerViewController.isDirection = true
        }
        
        if !isPanRightEable, tranP.x < 0 {
            
            if mainView.frame.origin.x == 0 {
                
                mainView.frame = frameWithOffsetX(offsetX: 0)
            
            } else {
            
                mainView.frame.origin.x += tranP.x
                
                if mainView.frame.origin.x <= 0 {
                    
                    mainView.frame.origin.x = 0
                
                }
                
                let maxOffsetY: CGFloat = changeStyleWithDirection(type: vDirection)
                
                mainView.frame.origin.y = fabs(mainView.frame.origin.x * maxOffsetY / UIScreen.main.bounds.width)
            
                mainView.frame.size.height = UIScreen.main.bounds.height - 2 * mainView.frame.origin.y
                
                
            }
            
            panGes.setTranslation(CGPoint.zero, in: mainView)
            
            return
        
        }
        
        mainView.frame = frameWithOffsetX(offsetX: tranP.x)
        
        if mainView.frame.origin.x > 0 {
            
            rightView.isHidden = true
            
            mainView.layer.shadowOffset = CGSize(width: -3, height: -1)
        
        }
        
        if mainView.frame.origin.x == 0 {
            
            
        
        }
        
        if mainView.frame.origin.x < 0 {
            
            rightView.isHidden = false
            
            mainView.layer.shadowOffset = CGSize(width: 3, height: 1)
        
        }
        
        if panGes.state == .ended {
            
            var target: CGFloat = 0
            
            if mainView.frame.origin.x > 0 {
                
                if velocity.x >= 0 {
                    
                    
                    if mainView.frame.origin.x > vMargin {
                    
                        target = vTargetRight
                    }
                
                } else {
                
                    if mainView.frame.origin.x < UIScreen.main.bounds.width - vMargin {
                    
                        target = 0
                    }
                }
            
            }
            
            if mainView.frame.origin.x < 0 {
                
                if VVDragerViewController.isDirection {
                
                    if mainView.frame.maxX < UIScreen.main.bounds.width - vMargin {
                        
                        target = -fabs(vTargetLeft)
                    
                    }
                }
                
            }
            
            let offset: CGFloat = target - mainView.frame.origin.x
            
            UIView.animate(withDuration: animDuration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 2, options: [], animations: { 
                self.mainView.frame = self.frameWithOffsetX(offsetX: offset)
            }, completion: { (_) in
                
            })
        
        }
        
        if mainView.frame.origin.x > vTargetRight {
            
            mainView.frame.origin.x = vTargetRight
        
        }
        
        panGes.setTranslation(CGPoint.zero, in: mainView)
    }
    
    fileprivate func frameWithOffsetX(offsetX: CGFloat) -> CGRect {
    
        mainView.frame.origin.x += offsetX
        
        let maxOffsetY: CGFloat = changeStyleWithDirection(type: vDirection)
        
        mainView.frame.origin.y = fabs(mainView.frame.origin.x * maxOffsetY)
        
        mainView.frame.size.height = UIScreen.main.bounds.height - 2 * mainView.frame.origin.y
        
        return mainView.frame
    }
    
    fileprivate func changeStyleWithDirection(type: VVDragerStyle) -> CGFloat {
    
        var maxOffsetY: CGFloat = vMaxY
        
        if mainView.frame.origin.x > 0 {
            
            switch type {
            case .left, .same:
                maxOffsetY = 0
            default:
                maxOffsetY = vMaxY
            }
        
        }
        
        if mainView.frame.origin.x < 0 {
            
            switch type {
            case .right, .same:
                maxOffsetY = 0
            default:
                maxOffsetY = vMaxY
            }
        }
        
        return maxOffsetY
    }

}

extension VVDragerViewController {
    
    func leftPanClick(btn: UIButton) {
        
        enableSubViews(isEable: true)
        
        btn.isSelected = !btn.isSelected
        
        if mainView.frame.origin.x >= 0 {
            
            rightView.isHidden = true
            
            leftView.isHidden = false
            
            changeStatusWithLeft()
        
        }
        
    
    }
    
    fileprivate func enableSubViews(isEable: Bool) {
        
        for subView in mainView.subviews {
            
            if isEable {
                
                subView.isUserInteractionEnabled = false
                
            } else {
                
                subView.isUserInteractionEnabled = true
            
            }
        
        
        }
        
        
    
    }
    
    fileprivate func changeStatusWithLeft() {
        
        var offset: CGFloat = 0
        
        if mainView.frame.origin.x == 0 {
            
            offset = vTargetRight
        } else {
            
            offset = -fabs(vTargetLeft)
        }
        
        UIView.animate(withDuration: animDuration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 2, options: [], animations: { 
            self.mainView.frame = self.frameWithOffsetX(offsetX: offset)
        }) { (_) in
            
        }
    }

}
