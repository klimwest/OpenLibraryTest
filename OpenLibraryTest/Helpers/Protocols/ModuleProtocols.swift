//
//  ModuleProtocols.swift
//  OpenLibraryTest
//
//  Created by West on 13.04.23.
//

import Foundation

protocol ViewModelProtocol: AnyObject {
    func setup(view viewModelViewDelegate: AnyObject)
}

protocol ModelProtocol: AnyObject {
    func setup(_ modelDelegate: AnyObject)
}


