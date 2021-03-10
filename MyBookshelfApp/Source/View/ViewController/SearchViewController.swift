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
		
		self.setup()
		self.setLayout()
	}
	
	private func setup() {
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.register(BookListCell.self, forCellReuseIdentifier: "BookListCell")
		self.searchBar.delegate = self
		
		self.requestText(searchText: self.searchText)
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
		self.tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor).isActive = true
		self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
	}
	
	private func requestText(searchText : String) {
		let bookRequest = BookAPI(searchString: searchText)
		bookRequest.fetchBooksList {[weak self] result in
			self?.booklist.append(contentsOf: result)
		}
	}
}


extension SearchViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.books = self.booklist[indexPath.row]
		let vc = DetailBookViewController()
		vc.isbn13 = self.books?.isbn13
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 200.0
	}
}


extension SearchViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.booklist.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookListCell", for: indexPath) as? BookListCell else { return UITableViewCell() }
		
		let bookInfo = self.booklist[indexPath.row]
		cell.loadBookInfo(bookInfo: bookInfo)
		
		return cell
	}
}


extension SearchViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		var filteredBookList: [Book] = []
		self.searchText = searchText
		self.requestText(searchText: searchText)
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
