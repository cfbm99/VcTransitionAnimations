//
//  ViewController.swift
//  VcTransitionAniamtions
//
//  Created by Apple on 2017/5/15.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func respondsToPushBtn(_ sender: UIButton) {
        self.navigationController?.pushViewController(BViewController(), animated: true)
    }

}

extension ViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return TransitionAnimations.init(type: .push)
        }else if operation == .pop {
            return TransitionAnimations.init(type: .pop)
        }else {
            return nil
        }
    }
    
}

