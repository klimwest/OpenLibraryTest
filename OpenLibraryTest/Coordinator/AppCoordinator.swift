//
//  AppCoordinator.swift
//  OpenLibraryTest
//
//  Created by West on 13.04.23.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
    func goToSpecificBook(book: ListOfBooksResponse.BookResponse, image: UIImage)
}

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let networkManager = NetworkManagerBuilder.build()
        let model = ListOfBooksModelBuilder.build(model: ListOfBooksResponse.default, networkManager: networkManager)
        let viewModel = ListOfBooksViewModelBuilder.build(model: model, coordinator: self)
        let view = ListOfBooksViewBuilder.build(viewModel: viewModel)
        model.setup(viewModel)
        navigationController.pushViewController(view, animated: true)
    }
    
    func goToSpecificBook(book: ListOfBooksResponse.BookResponse, image: UIImage) {
        let model = SpecificBookModelBuilder.build(model: book, image: image)
        let viewModel = SpecificBookViewModelBuilder.build(model: model)
        let view = SpecificBookViewBuilder.build(viewModel: viewModel)
        model.setup(viewModel)
        navigationController.pushViewController(view, animated: true)
    }
}
