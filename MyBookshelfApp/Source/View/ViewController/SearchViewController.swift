//
//  SearchViewController.swift
//  MyBookshelfApp
//
//  Created by 김보민 on 2021/03/09.
//

import UIKit

class SearchViewController: UIViewController {

	private var tableView = UITableView()
	private var searchBar = UISearchBar()
	private var searchText = ""
	private var books: Book? = nil
	private var booklist: [Book] = [] {
		didSet{
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setup()
		setLayout()
	}
	
	func setup() {
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.register(BookListCell.self, forCellReuseIdentifier: "BookListCell")
		self.searchBar.delegate = self
		
		requestWithSearchText(searchBarText: self.searchText)
	}
	
	func requestWithSearchText(searchBarText : String) {
		let bookRequest = BookAPI(searchString: searchBarText)
		bookRequest.fetchBooksList {[weak self] result in
			switch result {
			case .failure(let error):
				print(error)
			case .success((let bookInfo)):
				self?.booklist.append(contentsOf: bookInfo)
			}
		}
	}

	private func setLayout() {
		self.view.backgroundColor = .white
		self.view.addSubview(self.searchBar)
		self.searchBar.translatesAutoresizingMaskIntoConstraints = false
		if #available(iOS 11.0, *) {
			self.searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
		} else {
			self.searchBar.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
		}
		self.searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		self.searchBar.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
		
		self.view.addSubview(self.tableView)
		self.tableView.translatesAutoresizingMaskIntoConstraints = false
		self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		self.tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 5.0).isActive = true
		self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
	}
	

}

extension SearchViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.books = self.booklist[indexPath.row]
		let vc = DetailBookViewController()
		vc.books = self.books
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100.0
	}
}

extension SearchViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.booklist.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookListCell", for: indexPath) as? BookListCell else {
			return UITableViewCell()
		}
		let bookInfo = self.booklist[indexPath.row]
		cell.loadBookInfo(bookInfo: bookInfo)
		
		return cell
	}
}


extension SearchViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		var filteredBookList: [Book] = []
		self.searchText = searchText
		requestWithSearchText(searchBarText: searchText)
		if !searchText.isEmpty {
			for book in self.booklist {
				if book.title.lowercased().contains(searchText.lowercased()) {
					filteredBookList.append(book)
				}
			}
			self.booklist = filteredBookList
		}
		self.tableView.reloadData()
	}
}

