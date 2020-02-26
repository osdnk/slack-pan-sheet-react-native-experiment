//
//  SampleViewController.swift
//  PanModal
//
//  Created by Stephen Sowole on 10/9/18.
//  Copyright © 2018 PanModal. All rights reserved.
//

import UIKit
import Foundation

@objc class SampleViewController: UIViewController {

  
  @objc public init() {
    super.init(nibName:nil, bundle:nil)
//    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//      self.presentPanModal()
//    }
  }
  
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

protocol RowPresentable {
  var string: String { get }
  var rowVC: UIViewController & PanModalPresentable { get }
}

private extension SampleViewController {
  
  enum RowType: Int, CaseIterable {
    case basic
    case fullScreen
    case alert
    case transientAlert
    case userGroups
    case stacked
    case navController
    
    
    var presentable: RowPresentable {
      switch self {
      case .basic: return Basic()
      case .fullScreen: return FullScreen()
      case .alert: return Alert()
      case .transientAlert: return TransientAlert()
      case .userGroups: return UserGroup()
      case .stacked: return Stacked()
      case .navController: return UserGroup()
      }
    }
    
    struct Basic: RowPresentable {
      let string: String = "Basic"
      let rowVC: PanModalPresentable.LayoutType = BasicViewController()
    }
    
    struct FullScreen: RowPresentable {
      let string: String = "Full Screen"
      let rowVC: PanModalPresentable.LayoutType = FullScreenNavController()
    }
    
    struct Alert: RowPresentable {
      let string: String = "Alert"
      let rowVC: PanModalPresentable.LayoutType = AlertViewController()
    }
    
    struct TransientAlert: RowPresentable {
      let string: String = "Alert (Transient)"
      let rowVC: PanModalPresentable.LayoutType = TransientAlertViewController()
    }
    
    struct UserGroup: RowPresentable {
      let string: String = "User Groups"
      let rowVC: PanModalPresentable.LayoutType = AlertViewController()
    }
    
    struct Stacked: RowPresentable {
        let string: String = "User Groups (Stacked)"
        let rowVC: PanModalPresentable.LayoutType = UserGroupStackedViewController()
    }
  }
}
