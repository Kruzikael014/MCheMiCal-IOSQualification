//
//  Utility.swift
//  MCheMiCal
//
//  Created by Marchel Hermanliansyah on 01/05/23.
//

import UIKit

class Util {
    static func showToast(message: String, duration: TimeInterval = 2.0) {
        if let window = UIApplication.shared.keyWindow {
            let toast = UILabel()
            toast.text = message
            toast.font = UIFont.systemFont(ofSize: 14)
            toast.textColor = UIColor.white
            toast.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            toast.textAlignment = .center
            toast.alpha = 0.0
            toast.layer.cornerRadius = 10
            toast.clipsToBounds  =  true
            window.addSubview(toast)

            toast.translatesAutoresizingMaskIntoConstraints = false
            toast.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
            toast.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -40).isActive = true
            toast.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true

            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                toast.alpha = 1.0
            }, completion: { _ in
                UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseOut, animations: {
                    toast.alpha = 0.0
                }, completion: {_ in
                    toast.removeFromSuperview()
                })
            })
        }
    }
}

