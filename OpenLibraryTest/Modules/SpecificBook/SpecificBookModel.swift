//
//  SpecificBookModel.swift
//  OpenLibraryTest
//
//  Created by West on 13.04.23.
//

import UIKit

//MARK: Builder

final class SpecificBookModelBuilder {
    static func build(model: ListOfBooksResponse.BookResponse, image: UIImage) -> SpecificBookModelProtocol {
        return SpecificBookModel(model: model, image: image)
    }
}

//MARK: Protocols

protocol SpecificBookModelDelegate: AnyObject {
    func modelUpdateSuccessful(book: ListOfBooksResponse.BookResponse, image: UIImage)
}

protocol SpecificBookModelProtocol: ModelProtocol {
    func getBook()
}

//MARK: SpecificBookModel

class SpecificBookModel: SpecificBookModelProtocol {
    
    //MARK: Properties
    
    private let model: ListOfBooksResponse.BookResponse
    private let image: UIImage
    
    private weak var delegate: SpecificBookModelDelegate?
    
    //MARK: Init
    
    init(model: ListOfBooksResponse.BookResponse, image: UIImage) {
        self.model = model
        self.image = image
    }
    
    //MARK: DelegateSetup
    
    func setup(_ modelDelegate: AnyObject) {
        delegate = modelDelegate as? SpecificBookModelDelegate
    }
    
    //MARK: Functions
    
    func getBook() {
        delegate?.modelUpdateSuccessful(book: model, image: image)
    }
}
