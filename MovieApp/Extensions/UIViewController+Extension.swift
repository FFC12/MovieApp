//
//  UIViewController+Extension.swift
//  MovieApp
//
//  Created by Furkan Fatih Cetindil
//
import UIKit

extension UIViewController {
    func showToast(message: String, font: UIFont = .systemFont(ofSize: 12.0)) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 0.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        let textSize = toastLabel.intrinsicContentSize
        let padding: CGFloat = 16
        let width = min(textSize.width + 2 * padding, self.view.frame.width - 2 * padding)
        let height = textSize.height + 2 * padding
        let x = (self.view.frame.width - width) / 2
        let y = (self.view.frame.height - height) / 2  // Centered Y position
        
        toastLabel.frame = CGRect(x: x, y: y, width: width, height: height)
        
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            toastLabel.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.25, delay: 1.0, options: .curveEaseInOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: { _ in
                toastLabel.removeFromSuperview()
            })
        })
    }
}
