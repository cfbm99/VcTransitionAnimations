//
//  TransitionAnimations.swift
//  VcTransitionAniamtions
//
//  Created by Apple on 2017/5/15.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

enum TransitionAniamtionsType {
    case push,pop
}

class TransitionAnimations: NSObject,UIViewControllerAnimatedTransitioning {
    
    let screen = UIScreen.main.bounds.size
    var transitionAniamtionsType: TransitionAniamtionsType = .push
    
    public init(type: TransitionAniamtionsType) {
        transitionAniamtionsType = type
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if transitionAniamtionsType == .push {
            pushAnimation(using: transitionContext)
        }else if transitionAniamtionsType == .pop {
            popAnimation(using: transitionContext)
        }
    }
    
    fileprivate func pushAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from),
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        let containerView = transitionContext.containerView
        
        toView.frame = CGRect(x: screen.width, y: 64, width: screen.width, height: screen.height - 64)
        containerView.addSubview(toView)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            fromView.alpha = 0.8
            fromView.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
            toView.frame = CGRect(x: 0, y: 64, width: self.screen.width, height: self.screen.height - 64)
        }) { (finish) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    fileprivate func popAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from),
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        let containerView = transitionContext.containerView
        
        toView.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
        toView.alpha = 0.8
        containerView.insertSubview(toView, at: 0)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            toView.alpha = 1
            toView.transform = CGAffineTransform.identity
            fromView.frame = CGRect(x: self.screen.width, y: 64, width: self.screen.width, height: self.screen.height - 64)
        }) { (finish) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }

}
