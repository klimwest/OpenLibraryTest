//
//  SpecificBookViewModel.swift
//  OpenLibraryTest
//
//  Created by West on 13.04.23.
//

import UIKit

//MARK: Builder

final class SpecificBookViewModelBuilder {
    static func build(model: SpecificBookModelProtocol) -> SpecificBookViewModelProtocol {
        return SpecificBookViewModel(model: model)
    }
}

//MARK: Protocols

protocol SpecificBookViewModelDelegate: AnyObject {
    func showResult(book: ListOfBooksResponse.BookResponse, image: UIImage)
}

protocol SpecificBookViewModelProtocol: ViewModelProtocol {
    func getBook()
}

//MARK: SpecificBookViewModel

class SpecificBookViewModel: SpecificBookViewModelProtocol, SpecificBookModelDelegate {
    
    //MARK: Properties
    
    private let model: SpecificBookModelProtocol
    
    private weak var delegate: SpecificBookViewModelDelegate?
    
    //MARK: Init
    
    init(model: SpecificBookModelProtocol) {
        self.model = model
        model.setup(self)
    }
    
    //MARK: DelegateSetup
    
    func setup(view viewModelViewDelegate: AnyObject) {
        delegate = viewModelViewDelegate as? SpecificBookViewModelDelegate
    }
    
    //MARK: Functions
    
    func getBook() {
        model.getBook()
    }
    
    func modelUpdateSuccessful(book: ListOfBooksResponse.BookResponse, image: UIImage) {
        delegate?.showResult(book: book, image: image)
    }
}
