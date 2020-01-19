//
//  SnackbarView.swift
//
//  Created by José Vildósola on 8/29/19.
//  Copyright © 2019 José Vildósola. All rights reserved.
//

import UIKit

class SnackbarView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    init(frame: CGRect, snackbarType: SnackbarType, message: String) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed("SnackbarView", owner: self, options: nil)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let top = contentView.topAnchor.constraint(equalTo: self.topAnchor)
        let leading = contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let trailing = contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        let bottom = contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 4
        layer.applySketchShadow()
        
        switch snackbarType {
        case .Success:
            iconImageView.image = UIImage(named: "success", in: Bundle.main, compatibleWith: nil)
        case .Failure:
            iconImageView.image = UIImage(named: "failure", in: Bundle.main, compatibleWith: nil)
        }
        lblMessage.text = message
        addSubview(contentView)
        
        NSLayoutConstraint.activate([top, leading, trailing, bottom])
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gestureRecognizer:)))
        
        panGesture.addTarget(self, action: #selector(handlePan(gestureRecognizer:)))
        
        self.addGestureRecognizer(panGesture)
        
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    @objc func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: UIApplication.shared.keyWindow)
        if let view = gestureRecognizer.view {
            if translation.y < 0 {
                view.center = CGPoint(x: view.center.x, y: view.center.y + translation.y)
                gestureRecognizer.setTranslation(CGPoint.zero, in: UIApplication.shared.keyWindow)
            }
        }
        if gestureRecognizer.state == .ended {
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.contentView.frame = CGRect(x: 0, y: -90, width: self.contentView.frame.size.width, height: 82)
            }, completion: { _ in
                self.contentView.removeFromSuperview()
            })
        }
    }
}

extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.15,
        x: CGFloat = 0,
        y: CGFloat = 6,
        blur: CGFloat = 12,
        spread: CGFloat = 0) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
