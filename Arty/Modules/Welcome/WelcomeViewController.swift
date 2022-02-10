//
//  WelcomeViewController.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 08/02/2022.
//

import UIKit
import Resolver

class WelcomeViewController: UIViewController {

    // MARK: - Dependencies

    @Injected private var router: WelcomeRouting

    // MARK: - UI

    private lazy var browseButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 5
        button.setTitle("Browse", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(onTapBrowse), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Rijksmuseum"
        setup()
    }

    // MARK: - Private

    private func setup() {
        view.backgroundColor = UIColor.black
        [browseButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        configureLayoutConstraints()
    }

    private func configureLayoutConstraints() {
        browseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        browseButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        browseButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        browseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    // MARK: - Actions

    @objc private func onTapBrowse() {
        router.didSelectLibrary(in: self)
    }
}
