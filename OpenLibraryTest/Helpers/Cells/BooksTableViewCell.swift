//
//  BooksTableViewCell.swift
//  OpenLibraryTest
//
//  Created by West on 13.04.23.
//

import UIKit

//MARK: BooksTableViewCell

class BooksTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    private lazy var stackView: UIStackView = {
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
    
    private lazy var bookImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: LifeCycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookTitle.text = ""
        bookDate.text = ""
        bookImage.image = nil
    }
    
    //MARK: Setup
    
    func setup(model: ListOfBooksResponse.BookResponse) {
        setupUI()
        bookTitle.text = model.title
        if let earlierDate = model.first_publish_year {
            bookDate.text = "\(earlierDate)"
        }
    }
    
    func setupImage(image: UIImage?) {
        bookImage.image = image
    }
    
    //MARK: Private
    
    private func setupUI() {
        contentView.addSubview(stackView)
        contentView.addSubview(bookImage)
        stackView.addArrangedSubview(bookTitle)
        stackView.addArrangedSubview(bookDate)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bookImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            bookImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            bookImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            bookImage.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 12)
        ])
    }
}
