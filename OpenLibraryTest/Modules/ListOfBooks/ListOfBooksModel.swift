//
//  ListOfBooksModel.swift
//  OpenLibraryTest
//
//  Created by West on 13.04.23.
//

import UIKit

//MARK: Builder

final class ListOfBooksModelBuilder {
    static func build(model: ListOfBooksResponse, networkManager: NetworkManagerProtocol) -> ListOfBooksModelProtocol {
        return ListOfBooksModel(model: model, networkManager: networkManager)
    }
}

//MARK: Protocols

protocol ListOfBooksModelDelegate: AnyObject {
    func modelUpdateSuccessful(books: ListOfBooksResponse, images: [UIImage?])
    func modelUpdateFailed(error: Error)
}

protocol ListOfBooksModelProtocol: ModelProtocol {
    func getBooks()
    func getCovers(books: ListOfBooksResponse)
}

//MARK: ListOfBooksModel

class ListOfBooksModel: ListOfBooksModelProtocol {
    
    //MARK: Properties
    
    private let networkManager: NetworkManagerProtocol
    
    private var model: ListOfBooksResponse
    private var loadedImages = [UIImage?]()
    
    private weak var delegate: ListOfBooksModelDelegate?
    
    //MARK: Init
    
    init(model: ListOfBooksResponse, networkManager: NetworkManagerProtocol) {
        self.model = model
        self.networkManager = networkManager
    }
    
    //MARK: DelegateSetup
    
    func setup(_ modelDelegate: AnyObject) {
        delegate = modelDelegate as? ListOfBooksModelDelegate
    }
    
    //MARK: Functions
    
    func getBooks() {
        networkManager.getBooks { [weak self] books, error in
            guard let error = error else {
                self?.model = books ?? ListOfBooksResponse.default
                self?.getCovers(books: books ?? ListOfBooksResponse.default)
                return
            }
            self?.delegate?.modelUpdateFailed(error: error)
        }
    }
    
    func getCovers(books: ListOfBooksResponse) {
        guard let books = books.docs else {
            return
        }
        let group = DispatchGroup()
        for book in books {
            group.enter()
            networkManager.getImage(coverID: book.cover_i ?? 0) { [weak self] image in
                self?.loadedImages.append(image)
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.main) { [weak self] in
            guard let model = self?.model else {
                return
            }
            self?.delegate?.modelUpdateSuccessful(books: model, images: self?.loadedImages ?? [UIImage]())
        }
    }
}
