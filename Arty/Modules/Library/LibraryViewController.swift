//
//  LibraryViewController.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 10/02/2022.
//

import UIKit
import Resolver

class LibraryViewController: UIViewController {
    
    // MARK: - Dependencies

    @Injected private var viewModel: LibraryViewModel
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Collection"

        setup()
    }
    
    // MARK: - Private

    private func setup() {
        view.backgroundColor = .black
        
        viewModel.fetchCollection { _,_  in
            print("done")
        }
    }
}
