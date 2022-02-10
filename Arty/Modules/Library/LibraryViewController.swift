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

        setup()
    }
    
    // MARK: - Private

    private func setup() {
        view.backgroundColor = .red
        
        viewModel.fetchCollection { _,_  in
            print("done")
        }
    }
}
