//
//  ListOfBooksView.swift
//  OpenLibraryTest
//
//  Created by West on 13.04.23.
//

import UIKit

//MARK: Builder

final class ListOfBooksViewBuilder {
    static func build(viewModel: ListOfBooksViewModelProtocol) -> ListOfBooksViewProtocol {
        return ListOfBooksView(viewModel: viewModel)
    }
}

//MARK: Protocols

protocol ListOfBooksViewProtocol: UIViewController, ListOfBooksViewModelDelegate {
}

//MARK: ListOfBooksView

class ListOfBooksView: UIViewController, ListOfBooksViewProtocol {
    
    //MARK: Properties
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.register(BooksTableViewCell.self, forCellReuseIdentifier: "cell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewModel: ListOfBooksViewModelProtocol
    
    private var model = [ListOfBooksResponse.BookResponse]()
    private var loadedImages = [UIImage?]()
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setup(view: self)
        viewModel.getBooks()
        setupUI()
        activityIndicator.startAnimating()
    }
    
    //MARK: Init
    
    init(viewModel: ListOfBooksViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    
    func showResult(books: ListOfBooksResponse, images: [UIImage?]) {
        model = books.docs ?? [ListOfBooksResponse.BookResponse]()
        loadedImages = images
        tableView.reloadData()
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func handleError(error: Error) {
        let alert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
        let tryAgainAction = UIAlertAction(title: "Try Again", style: .default) { [weak self] _ in
            self?.viewModel.getBooks()
        }
        alert.addAction(tryAgainAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    //MARK: Private
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Books"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: view.topAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

//MARK: Extensions

extension ListOfBooksView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? BooksTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(model: model[indexPath.row])
        
        
        if indexPath.row < loadedImages.count, let image = loadedImages[indexPath.row] {
            cell.setupImage(image: image)
        } else {
            cell.setupImage(image: UIImage(named: "default"))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.goToSpecificBook(book: model[indexPath.row], image: loadedImages[indexPath.row] ?? UIImage())
    }
}
