//
//  DetailBookViewController.swift
//  MyBookshelfApp
//
//  Created by 김보민 on 2021/03/09.
//

import UIKit

class DetailBookViewController: UIViewController {
	var isbn13: String? = ""
	private var bookDetailList = BookDetail()
	
	private var titleLabel 		= UILabel()
	private var subtitleLabel 	= UILabel()
	private var publisherLabel 	= UILabel()
	private var authorsLabel 	= UILabel()
	private var languageLabel 	= UILabel()
	private var isbn13Label 	= UILabel()
	private var isbn10Label 	= UILabel()
	private var priceLabel 		= UILabel()
	private var pagesLabel 		= UILabel()
	private var yearLabel 		= UILabel()
	private var descLabel 		= UILabel()
	private var urlLabel 		= UILabel()
	private var imageView 		= BookImageView()
	private let stackView: UIStackView = {
		let stackView = UIStackView(frame: .zero)
		stackView.axis = .vertical
		stackView.spacing = 10.0
		stackView.alignment = .leading
		return stackView
	}()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setup()
		self.setLayout()
	}
	
	private func setup() {
		self.fetchBooksDetail()
	}
	
	private func configure() {
		guard let url = URL(string: self.bookDetailList.image ?? "") else { return }
		
		self.titleLabel.text = "title : " + String(describing: self.bookDetailList.title)
		self.subtitleLabel.text = "subtitle : " + String(describing: self.bookDetailList.subtitle)
		self.publisherLabel.text = "publisher : " + String(describing: self.bookDetailList.publisher)
		self.authorsLabel.text = "authors : " + String(describing: self.bookDetailList.authors)
		self.languageLabel.text = "language : " + String(describing: self.bookDetailList.language)
		self.pagesLabel.text = "pages : " + String(describing: self.bookDetailList.pages)
		self.isbn13Label.text = "isbn13 : " + String(describing: self.bookDetailList.isbn13)
		self.isbn10Label.text = "isbn10 : " + String(describing: self.bookDetailList.isbn10)
		self.priceLabel.text = "price : " + String(describing: self.bookDetailList.price)
		self.yearLabel.text = "year : " + String(describing: self.bookDetailList.year)
		self.descLabel.text = "desc : " + String(describing: self.bookDetailList.desc)
		self.urlLabel.text = "url : " + String(describing: self.bookDetailList.url)
		self.imageView.loadImage(from: url)
	}
	
	private func fetchBooksDetail() {
		let bookRequest = BookAPI(bookDetailString: self.isbn13 ?? "")
		bookRequest.fetchBooksDetailList {[weak self] result in
			self?.bookDetailList = result
			DispatchQueue.main.async {
				self?.configure()
			}
		}
	}
	
	private func setLayout() {
		self.view.backgroundColor = .white
		
		self.view.addSubview(self.imageView)
		self.imageView.translatesAutoresizingMaskIntoConstraints = false
		self.imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30.0).isActive = true
		self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		
		self.stackView.addArrangedSubview(self.titleLabel)
		self.stackView.addArrangedSubview(self.subtitleLabel)
		self.stackView.addArrangedSubview(self.publisherLabel)
		self.stackView.addArrangedSubview(self.authorsLabel)
		self.stackView.addArrangedSubview(self.languageLabel)
		self.stackView.addArrangedSubview(self.pagesLabel)
		self.stackView.addArrangedSubview(self.isbn10Label)
		self.stackView.addArrangedSubview(self.isbn13Label)
		self.stackView.addArrangedSubview(self.priceLabel)
		self.stackView.addArrangedSubview(self.yearLabel)
		self.stackView.addArrangedSubview(self.descLabel)
		self.stackView.addArrangedSubview(self.urlLabel)
		self.stackView.translatesAutoresizingMaskIntoConstraints = false
		
		self.view.addSubview(self.stackView)
		self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		self.stackView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 10.0).isActive = true
		self.stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
	}
}
