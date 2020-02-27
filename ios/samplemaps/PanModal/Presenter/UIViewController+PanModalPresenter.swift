//
//  UIViewController+PanModalPresenterProtocol.swift
//  PanModal
//
//  Copyright © 2019 Tiny Speck, Inc. All rights reserved.
//

#if os(iOS)
import UIKit

import PanModal


class PanModalViewController: UIViewController, PanModalPresentable {
  var config: Dictionary<String, Any> = [:]
  convenience init(config: Dictionary<String, Any>) {
    self.init()
    self.config = config
  }

  
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
    let height: CGFloat = config["shortFormHeight"] == nil ? 300 : config["shortFormHeight"] as! CGFloat
    return isShortFormEnabled ? .contentHeight(height) : longFormHeight
  }
  
  var topOffset: CGFloat {
    let topOffset: CGFloat = config["topOffset"] == nil ? 42.0 : config["topOffset"] as! CGFloat
    return topLayoutGuide.length + topOffset
  }
  
  var isShortFormEnabledInternal = 2
  var isShortFormEnabled: Bool {
    if isShortFormEnabledInternal > 0 && (config["startFromShortForm"] == nil || !(config["startFromShortForm"] as! Bool)) {
      isShortFormEnabledInternal -= 1
      return false
    }
    return config["isShortFormEnabled"] == nil ? true : config["isShortFormEnabled"] as! Bool
  }
  
  var longFormHeight: PanModalHeight {
    return .maxHeight
  }
  
  var cornerRadius: CGFloat {
    return config["cornerRadius"] == nil ? 8 : config["cornerRadius"] as! CGFloat
  }
  
  var springDamping: CGFloat {
    return config["springDamping"] == nil ? 0.8 : config["springDamping"] as! CGFloat
  }
  
  var transitionDuration: Double {
    return config["transitionDuration"] == nil ? 0.5 : config["transitionDuration"] as! Double
  }
  
  var anchorModalToLongForm: Bool {
    return config["anchorModalToLongForm"] == nil ? true : config["anchorModalToLongForm"] as! Bool
  }
  
  var allowsDragToDismiss: Bool {
    return config["allowsDragToDismiss"] == nil ? true : config["allowsDragToDismiss"] as! Bool
  }
  
  var allowsTapToDismiss: Bool {
    return config["allowsTapToDismiss"] == nil ? true : config["allowsTapToDismiss"] as! Bool
  }
  
  var isUserInteractionEnabled: Bool {
    return config["isUserInteractionEnabled"] == nil ? true : config["isUserInteractionEnabled"] as! Bool
  }
  
  var isHapticFeedbackEnabled: Bool {
    return config["isHapticFeedbackEnabled"] == nil ? true : config["isHapticFeedbackEnabled"] as! Bool
  }
  
  var shouldRoundTopCorners: Bool {
    return config["shouldRoundTopCorners"] == nil ? true : config["shouldRoundTopCorners"] as! Bool
  }
  
  var showDragIndicator: Bool {
    return config["showDragIndicator"] == nil ? true : config["showDragIndicator"] as! Bool
  }
  
  var scrollIndicatorInsets: UIEdgeInsets {
    let bottomOffset = presentingViewController?.bottomLayoutGuide.length ?? 0
    return UIEdgeInsets(top: 0, left: 0, bottom: bottomOffset, right: 0)
  }

  
  func shouldPrioritize(panModalGestureRecognizer: UIPanGestureRecognizer) -> Bool {
    let headerHeight: CGFloat = config["headerHeight"] == nil ? 21 : config["headerHeight"] as! CGFloat
    let location = panModalGestureRecognizer.location(in: view)
    return location.y < headerHeight
  }
  
}


extension UIViewController {
  @objc public func presentPanModal(view: UIView, config: Dictionary<String, Any>) {
    
    let viewControllerToPresent: UIViewController & PanModalPresentable = PanModalViewController(config: config)
    viewControllerToPresent.view = view
    let sourceView: UIView? = nil, sourceRect: CGRect = .zero
    
    self.presentPanModal(viewControllerToPresent, sourceView: sourceView, sourceRect: sourceRect)
    
  }
  
}
#endif
