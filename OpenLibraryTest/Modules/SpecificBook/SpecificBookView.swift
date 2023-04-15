//
//  SpecificBookView.swift
//  OpenLibraryTest
//
//  Created by West on 13.04.23.
//
//

import UIKit

//MARK: Builder

final class SpecificBookViewBuilder {
    static func build(viewModel: SpecificBookViewModelProtocol) -> SpecificBookViewProtocol {
        return SpecificBookView(viewModel: viewModel)
    }
}

//MARK: Protocols

protocol SpecificBookViewProtocol: UIViewController, SpecificBookViewModelDelegate {
}

//MARK: SpecificBookView

class SpecificBookView: UIViewController, SpecificBookViewProtocol {
    
    //MARK: Properties
    
    private lazy var stackViewImageAndText: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 0
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackViewTitleAndInfo: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 0
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bookTitle: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.sizeToFit()
        view.textAlignment = .center
        view.textColor = UIColor(hexString: "222831")
        view.translatesAutoresizingMaskIntoConstraints = false
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 20.29 / view.font.lineHeight
        return view
    }()
    
    private lazy var bookDescription: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 21, weight: .regular)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .center
        view.sizeToFit()
        view.textColor = UIColor(hexString: "222831")
        view.translatesAutoresizingMaskIntoConstraints = false
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 20.29 / view.font.lineHeight
        return view
    }()
    
    private lazy var bookDate: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        view.sizeToFit()
        view.lineBreakMode = .byWordWrapping
        view.textColor = UIColor(hexString: "#AAAAAD")
        view.translatesAutoresizingMaskIntoConstraints = false
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 15.51 / view.font.lineHeight
        return view
    }()
    
    private lazy var bookAuthor: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        view.sizeToFit()
        view.lineBreakMode = .byWordWrapping
        view.textColor = UIColor(hexString: "#AAAAAD")
        view.translatesAutoresizingMaskIntoConstraints = false
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 15.51 / view.font.lineHeight
        return view
    }()
    
    private lazy var bookImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewModel: SpecificBookViewModelProtocol
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setup(view: self)
        viewModel.getBook()
        setupUI()
    }
    
    //MARK: Init
    
    init(viewModel: SpecificBookViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: DelegateFunctions
    
    func showResult(book: ListOfBooksResponse.BookResponse, image: UIImage) {
        bookImage.image = image
        bookTitle.text = book.title
        title = book.title
        if let date = book.first_publish_year {
            bookDate.text = "\(date)"
        }
        if let author = book.author_name {
            bookAuthor.text = author.first ?? ""
        }
        if let description = book.first_sentence {
            bookDescription.text = description.first ?? ""
        } else {
            bookDescription.text = "No description"
        }
    }
    
    //MARK: Private
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        view.addSubview(stackViewImageAndText)
        stackViewImageAndText.addArrangedSubview(bookImage)
        stackViewImageAndText.addArrangedSubview(stackViewTitleAndInfo)
        stackViewTitleAndInfo.addArrangedSubview(bookTitle)
        stackViewTitleAndInfo.addArrangedSubview(bookAuthor)
        stackViewTitleAndInfo.addArrangedSubview(bookDate)
        view.addSubview(bookDescription)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackViewImageAndText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            stackViewImageAndText.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackViewImageAndText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            stackViewImageAndText.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            bookDescription.topAnchor.constraint(equalTo: stackViewImageAndText.bottomAnchor, constant: 44),
            bookDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            bookDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ])
    }
}
