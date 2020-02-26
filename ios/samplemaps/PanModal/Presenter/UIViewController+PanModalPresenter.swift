//
//  UIViewController+PanModalPresenterProtocol.swift
//  PanModal
//
//  Copyright © 2019 Tiny Speck, Inc. All rights reserved.
//

#if os(iOS)
import UIKit

import PanModal


class UserGroupViewController: UIViewController, PanModalPresentable {
  
  var isShortFormEnabled = true
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  func findChildScrollViewDFS(view: UIView)-> UIScrollView? {
    var viewsToTraverse = [view]
    while !viewsToTraverse.isEmpty {
      let last = viewsToTraverse.last!
      viewsToTraverse.removeLast()
      if last is UIScrollView {
        return last as? UIScrollView
      }
      last.subviews.forEach { subview in
        viewsToTraverse.append(subview)
      }
    }
    return nil
  }
  
  var panScrollable: UIScrollView? {
    return findChildScrollViewDFS(view: self.view!)
  }
  
  var shortFormHeight: PanModalHeight {
    return isShortFormEnabled ? .contentHeight(300.0) : longFormHeight
  }
  
  var scrollIndicatorInsets: UIEdgeInsets {
    let bottomOffset = presentingViewController?.bottomLayoutGuide.length ?? 0
    return UIEdgeInsets(top: 0, left: 0, bottom: bottomOffset, right: 0)
  }
  
  var anchorModalToLongForm: Bool {
    return false
  }
  
  func shouldPrioritize(panModalGestureRecognizer: UIPanGestureRecognizer) -> Bool {
    let location = panModalGestureRecognizer.location(in: view)
    return location.y < 100
  }
  
  func willTransition(to state: PanModalPresentationController.PresentationState) {
    guard isShortFormEnabled, case .longForm = state
      else { return }
    
    //isShortFormEnabled = false
    panModalSetNeedsLayoutUpdate()
  }
  
}


extension UIViewController {
  @objc public func presentPanModal(view: UIView) {
    
    let viewControllerToPresent: UIViewController & PanModalPresentable = UserGroupViewController()
    viewControllerToPresent.view = view
    let sourceView: UIView? = nil, sourceRect: CGRect = .zero
    
    self.presentPanModal(viewControllerToPresent, sourceView: sourceView, sourceRect: sourceRect)
    
  }
  
}
#endif
