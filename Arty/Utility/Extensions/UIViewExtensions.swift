//
//  UIViewExtensions.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 11/02/2022.
//

import UIKit

extension UIView {
    func embedToSafeArea(view subView: UIView, insets: UIEdgeInsets = .zero) {
        addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: insets.top),
            subView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -insets.bottom),
            subView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
            subView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -insets.right)
        ])
    }
}
