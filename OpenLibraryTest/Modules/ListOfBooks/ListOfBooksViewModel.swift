//
//  ListOfBooksViewModel.swift
//  OpenLibraryTest
//
//  Created by West on 13.04.23.
//

import UIKit

//MARK: Builder

final class ListOfBooksViewModelBuilder {
    static func build(model: ListOfBooksModelProtocol, coordinator: Coordinator) -> ListOfBooksViewModelProtocol {
        return ListOfBooksViewModel(model: model, coordinator: coordinator)
    }
}

//MARK: Protocols

protocol ListOfBooksViewModelDelegate: AnyObject {
    func showResult(books: ListOfBooksResponse, images: [UIImage?])
    func handleError(error: Error)
}

protocol ListOfBooksViewModelProtocol: ViewModelProtocol {
    func getBooks()
    func goToSpecificBook(book: ListOfBooksResponse.BookResponse, image: UIImage)
}

//MARK: ListOfBooksViewModel

class ListOfBooksViewModel: ListOfBooksViewModelProtocol, ListOfBooksModelDelegate {
    
    //MARK: Properties
    
    private let model: ListOfBooksModelProtocol
    private let coordinator: Coordinator
    
    private weak var delegate: ListOfBooksViewModelDelegate?
    
    //MARK: Init
    
    init(model: ListOfBooksModelProtocol, coordinator: Coordinator) {
        self.model = model
        self.coordinator = coordinator
        model.setup(self)
    }
    
    //MARK: Functions
    
    func setup(view viewModelViewDelegate: AnyObject) {
        delegate = viewModelViewDelegate as? ListOfBooksViewModelDelegate
    }
    
    func getBooks() {
        model.getBooks()
    }
    
    func goToSpecificBook(book: ListOfBooksResponse.BookResponse, image: UIImage) {
        coordinator.goToSpecificBook(book: book, image: image)
    }
    
    
    func modelUpdateSuccessful(books: ListOfBooksResponse, images: [UIImage?]) {
        delegate?.showResult(books: books, images: images)
    }
    
    func modelUpdateFailed(error: Error) {
        delegate?.handleError(error: error)
    }
}
