//
//  VVViewController.swift
//  VVDragerDemo
//
//  Created by atom on 2017/1/2.
//  Copyright © 2017年 atom. All rights reserved.
//

import UIKit

class VVViewController: VVDragerViewController {
    
    fileprivate lazy var navView: VVNavgationView = VVNavgationView.navView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
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

extension VVViewController {

    fileprivate func setupUI() {
        
        mainView.addSubview(navView)
        
        navView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 64)
        
        navView.leftButton.addTarget(self, action: #selector(leftClick(btn:)), for: .touchUpInside)
        
    
        
    }
    
    @objc fileprivate func leftClick(btn: UIButton) {
        
        //leftClick(btn: btn)
        
    }
    
}
