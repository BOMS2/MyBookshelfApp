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
	
	private let scrollView = UIScrollView()
	private let contentView = UIView()
	
	private var titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = UIColor(red: 252/255, green: 60/255, blue: 68/255, alpha: 1)
		label.textAlignment = .center
		label.font = label.font.withSize(20)
		return label
	}()
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
	private let imageView 		= BookImageView()
	private let urlButton: UIButton = {
		let button = UIButton()
		button.layer.borderWidth = 1
		button.layer.borderColor = UIColor.black.cgColor
		button.setTitle("MORE INFO", for: .normal)
		button.setTitleColor(.black, for: .normal)
		return button
	}()
	private let stackView: UIStackView = {
		let stackView = UIStackView(frame: .zero)
		stackView.axis = .vertical
		stackView.spacing = 10
		stackView.alignment = .leading
		return stackView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setup()
		self.setLayout()
	}
	
	private func configure() {
		guard let title = self.bookDetailList.title else { return }
		
		self.titleLabel.text = title
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
		self.imageView.setImageUrl(self.bookDetailList.image ?? "")
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
	
	@objc private func didButtonClick() {
		guard let url = self.bookDetailList.url else { return }
		
		if let url = URL(string: url) {
			if #available(iOS 10, *) {
				UIApplication.shared.open(url)
			} else {
				UIApplication.shared.openURL(url)
			}
		}
	}
}

extension DetailBookViewController {
	private func setup() {
		self.fetchBooksDetail()
		self.urlButton.addTarget(self, action: #selector(self.didButtonClick), for: .touchUpInside)
		self.titleLabel.numberOfLines = 0
		self.subtitleLabel.numberOfLines = 0
		self.descLabel.numberOfLines = 0
	}
	
	private func setLayout() {
		self.view.backgroundColor = .white
		
		view.addSubview(self.scrollView)
		self.scrollView.addSubview(self.contentView)
		self.contentView.addSubview(self.imageView)
		self.contentView.addSubview(self.titleLabel)
		self.contentView.addSubview(self.stackView)
		self.contentView.addSubview(self.urlButton)
		self.scrollView.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.translatesAutoresizingMaskIntoConstraints = false
		
		self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
		self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
		
		self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
		self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
		self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
		self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
		self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
		
		let contentViewHeightConstraint = self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor)
		contentViewHeightConstraint.priority = .defaultLow
		contentViewHeightConstraint.isActive = true
		
		self.imageView.translatesAutoresizingMaskIntoConstraints = false
		self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
		self.imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
		
		self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
		self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor).isActive = true
		self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
		
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
		
		self.stackView.translatesAutoresizingMaskIntoConstraints = false
		self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
		self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
		self.stackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor).isActive = true
		
		self.urlButton.translatesAutoresizingMaskIntoConstraints = false
		self.urlButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 10).isActive = true
		self.urlButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
		self.urlButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
		self.urlButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
		self.urlButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
	}
}
