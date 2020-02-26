//
//  UIViewController+PanModalPresenterProtocol.swift
//  PanModal
//
//  Copyright © 2019 Tiny Speck, Inc. All rights reserved.
//

#if os(iOS)
import UIKit

import PanModal

struct UserGroupHeaderPresentable: Equatable {

    let handle: String
    let description: String
    let memberCount: Int

}

class UserGroupHeaderView: UIView {

    struct Constants {
        static let contentInsets = UIEdgeInsets(top: 12.0, left: 16.0, bottom: 12.0, right: 16.0)
    }

    // MARK: - Views
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Lato-Bold", size: 17.0)
        label.textColor = #colorLiteral(red: 0.8196078431, green: 0.8235294118, blue: 0.8274509804, alpha: 1)
        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = #colorLiteral(red: 0.7019607843, green: 0.7058823529, blue: 0.7137254902, alpha: 1)
        label.font = UIFont(name: "Lato-Regular", size: 13.0)
        return label
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.8235294118, blue: 0.8274509804, alpha: 1).withAlphaComponent(0.11)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.1137254902, blue: 0.1294117647, alpha: 1)

        addSubview(stackView)
        addSubview(seperatorView)

        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout
    func setupConstraints() {

        stackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.contentInsets.top).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.contentInsets.left).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.contentInsets.right).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.contentInsets.bottom).isActive = true

        seperatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        seperatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        seperatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
    }

    // MARK: - View Configuration
    func configure(with presentable: UserGroupHeaderPresentable) {
        titleLabel.text = "@\(presentable.handle)"
        subtitleLabel.text = "\(presentable.memberCount) members  |  \(presentable.description)"
    }

}

class UserGroupViewController: UIViewController, PanModalPresentable {

    var isShortFormEnabled = true

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    let headerView = UserGroupHeaderView()

    let headerPresentable = UserGroupHeaderPresentable.init(handle: "ios-engs", description: "iOS Engineers", memberCount: 10)
  
  func findChildScrollView(view: UIView) -> UIScrollView? {
    if view.subviews.count == 0 {
      return nil
    }
    let fisrtChild = view.subviews[0]
    if fisrtChild is UIScrollView {
      return fisrtChild as? UIScrollView
    }
    return findChildScrollView(view: fisrtChild)
  }
  
    var panScrollable: UIScrollView? {
      
      return findChildScrollView(view: self.view!)
    }

    var shortFormHeight: PanModalHeight {
        return isShortFormEnabled ? .contentHeight(300.0) : longFormHeight
    }

    var scrollIndicatorInsets: UIEdgeInsets {
        let bottomOffset = presentingViewController?.bottomLayoutGuide.length ?? 0
        return UIEdgeInsets(top: headerView.frame.size.height, left: 0, bottom: bottomOffset, right: 0)
    }

    var anchorModalToLongForm: Bool {
        return false
    }

    func shouldPrioritize(panModalGestureRecognizer: UIPanGestureRecognizer) -> Bool {
        let location = panModalGestureRecognizer.location(in: view)
        return headerView.frame.contains(location)
    }

    func willTransition(to state: PanModalPresentationController.PresentationState) {
        guard isShortFormEnabled, case .longForm = state
            else { return }

        isShortFormEnabled = false
        panModalSetNeedsLayoutUpdate()
    }

}

class UserGroupStackedViewController: UserGroupViewController {
    override var shortFormHeight: PanModalHeight {
        return longFormHeight
    }
}


extension UIViewController {
  @objc public func presentPanModal(view: UIView) {

    let viewControllerToPresent: UIViewController & PanModalPresentable = UserGroupStackedViewController()
      viewControllerToPresent.view = view
      let sourceView: UIView? = nil, sourceRect: CGRect = .zero
    
    self.presentPanModal(viewControllerToPresent, sourceView: sourceView, sourceRect: sourceRect)

    }

}
#endif
