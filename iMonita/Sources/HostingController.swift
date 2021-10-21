//
//  HostingController.swift
//  iMonitaKit
//
//  Created by Petr Guan on 2021/10/21.
//

import Combine
import SwiftUI
import UIKit

/// HostingController is used to bridge SwiftUI view to UIKit,
/// it provides draggable and haptic feedback for the view.
public final class HostingController<Content>: UIHostingController<Content> where Content: View {
    private let panGesture = UIPanGestureRecognizer()
    
    public private(set) var subject: PassthroughSubject<CGRect, Never>?
    
    public init(rootView: Content, frame: CGRect, shouldMemorizeLastPosition: Bool = false) {
        super.init(rootView: rootView)
        
        panGesture.addTarget(self, action: #selector(handleMonitorDragged(_:)))
        view.backgroundColor = .clear
        view.addGestureRecognizer(panGesture)
        view.frame = frame
        
        if shouldMemorizeLastPosition {
            subject = PassthroughSubject<CGRect, Never>()
        }
    }
    
    @objc dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let superview = view.superview else {
            return
        }
        
        let size = view.frame.size
        if !isViewInsideSuperview(superview) {
            // Move the view to a designated position
            view.frame = CGRect(x: superview.safeAreaInsets.left, y: superview.bounds.height - superview.safeAreaInsets.bottom - size.height - 40.0, width: size.width, height: size.height)
        }
        
        subject?.send(view.frame)
    }
    
    private func isViewInsideSuperview(_ superview: UIView) -> Bool {
        let centerX = (view.frame.minX + view.frame.maxX) / 2
        let centerY = (view.frame.minY + view.frame.maxY) / 2
        
        if centerX < 0 || centerX > superview.bounds.width || centerY < 0 || centerY > superview.bounds.height {
            return false
        }
        else {
            return true
        }
    }
    
    // MARK: - Gesture Handler
    
    @objc private func handleMonitorDragged(_ sender: UIPanGestureRecognizer) {
        handleViewDragged(view, sender: sender)
    }
    
    private func handleViewDragged(_ view: UIView, sender: UIPanGestureRecognizer) {
        let parentView = view.superview
        parentView?.bringSubviewToFront(view)
        let translation = sender.translation(in: parentView)
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: parentView)
        // Haptic feedback while dragging the monitor view
        switch sender.state {
        case .began:
            applyDraggingHapticFeedback(triggerImpact: true) {
                let scale: CGFloat = 1.08
                view.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        case .cancelled, .ended:
            applyDraggingHapticFeedback {
                view.transform = .identity
            }
        default:
            break
        }
    }
    
    private func applyDraggingHapticFeedback(triggerImpact: Bool = false, _ animations: @escaping () -> Void) {
        if triggerImpact {
            //let feedbackGenerator = FeedbackGenerator(.impact(style: .light))
            //feedbackGenerator.prepare()
            //feedbackGenerator.impactOccurred()
        }
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: []) {
            animations()
        }
    }
}
