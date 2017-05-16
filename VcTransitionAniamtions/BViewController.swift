//
//  BViewController.swift
//  VcTransitionAniamtions
//
//  Created by Apple on 2017/5/15.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

class BViewController: UIViewController {
    
    var interactiveTransition: UIPercentDrivenInteractiveTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeInterface()
    }
    
    func initializeInterface() {
        self.navigationController?.delegate = self
        view.backgroundColor = UIColor.yellow
        let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(respondsToPanGesture))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc fileprivate func respondsToPanGesture(pan: UIPanGestureRecognizer) {
        let moveX = pan.translation(in: pan.view).x
        let percent = moveX / screen.width
        switch pan.state {
        case .began:
            interactiveTransition = UIPercentDrivenInteractiveTransition()
            navigationController?.popViewController(animated: true)
        case .changed:
            interactiveTransition?.update(percent)
        case .ended:
            if percent > 0.5 {
                interactiveTransition?.finish()
            }else {
                interactiveTransition?.cancel()
            }
            interactiveTransition = nil
        default:
            print("default")
        }
        
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

extension BViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return TransitionAnimations.init(type: .push)
        }else if operation == .pop {
            return TransitionAnimations.init(type: .pop)
        }else {
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition
    }
    
}

