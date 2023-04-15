//
//  ListOfBooks.swift
//  OpenLibraryTest
//
//  Created by West on 13.04.23.
//

import Foundation

struct ListOfBooksResponse: Codable {
    let start: Int?
    let numFound: Int?
    let docs: [BookResponse]?
    
    struct BookResponse: Codable {
        let title: String
        let author_name: [String]?
        let first_publish_year: Int?
        let publisher: [String]?
        let publish_date: [String]?
        let cover_i: Int?
        let isbn: [String]?
        let first_sentence: [String]?
    }
    
    static let `default` = ListOfBooksResponse(start: nil, numFound: nil, docs: nil)
}
