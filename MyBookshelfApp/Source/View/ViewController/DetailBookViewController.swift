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
		label.textAlignment = .left
		label.font = label.font.withSize(20)
		label.numberOfLines = 0
		return label
	}()
	private var subtitleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .lightGray
		label.textAlignment = .left
		label.font = label.font.withSize(15)
		label.numberOfLines = 0
		return label
	}()
	private var publisherLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		return label
	}()
	private var authorsLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.font = .boldSystemFont(ofSize: 20)
		label.textAlignment = .left
		label.numberOfLines = 0
		return label
	}()
	private var languageLabel 	= UILabel()
	private var isbn13Label 	= UILabel()
	private var isbn10Label 	= UILabel()
	private var priceLabel: UILabel = {
		let label = UILabel()
		label.textColor = .blue
		label.numberOfLines = 0
		return label
	}()
	private var pagesLabel 		= UILabel()
	private var yearLabel 		= UILabel()
	private let imageView 		= BookImageView()
	private var descLabel: UILabel = {
		let label = UILabel()
		label.textColor = .lightGray
		label.font = label.font.withSize(15)
		label.numberOfLines = 0
		label.textAlignment = .left
		return label
	}()
	private let urlButton: UIButton = {
		let button = UIButton()
		button.layer.borderWidth = 1
		button.layer.borderColor = UIColor.black.cgColor
		button.setTitle(" MORE INFO ", for: .normal)
		button.setTitleColor(.black, for: .normal)
		return button
	}()
	private let stackView1: UIStackView = {
		let stackView = UIStackView(frame: .zero)
		stackView.axis = .vertical
		stackView.spacing = 10
		stackView.alignment = .leading
		return stackView
	}()
	private let stackView2: UIStackView = {
		let stackView = UIStackView(frame: .zero)
		stackView.axis = .vertical
		stackView.spacing = 10
		stackView.alignment = .leading
		return stackView
	}()
	private let reviewerLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.font = label.font.withSize(15)
		label.numberOfLines = 0
		label.textAlignment = .left
		return label
	}()
	private var lineView: UIView = {
		let view = UIView()
		view.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
		view.layer.borderWidth = 0.5
		view.layer.borderColor = UIColor.lightGray.cgColor
		view.backgroundColor = .clear
		return view
	}()
	private let memoLabel: UILabel = {
		let label = UILabel()
		label.textColor = .gray
		label.font = label.font.withSize(15)
		label.textAlignment = .right
		label.text = "See All > "
		return label
	}()
	private let reviewStackView: UIStackView = {
		let stackView = UIStackView(frame: .zero)
		stackView.axis = .horizontal
		return stackView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setup()
		self.setLayout()
	}
}

extension DetailBookViewController {
	private func setup() {
		self.fetchBooksDetail()
		self.buttonClick()
	}
	
	private func setLayout() {
		self.view.backgroundColor = .white
		
		view.addSubview(self.scrollView)
		self.scrollView.addSubview(self.contentView)
		self.contentView.addSubview(self.imageView)
		self.contentView.addSubview(self.stackView1)
		self.contentView.addSubview(self.stackView2)
		self.contentView.addSubview(self.descLabel)
		self.contentView.addSubview(self.lineView)
		self.contentView.addSubview(self.reviewStackView)
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
		
		self.stackView1.addArrangedSubview(self.titleLabel)
		self.stackView1.addArrangedSubview(self.subtitleLabel)
		self.stackView1.addArrangedSubview(self.authorsLabel)
		
		self.stackView1.translatesAutoresizingMaskIntoConstraints = false
		self.stackView1.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 30).isActive = true
		self.stackView1.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
		self.stackView1.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
		
		self.imageView.translatesAutoresizingMaskIntoConstraints = false
		self.imageView.topAnchor.constraint(equalTo: self.stackView1.bottomAnchor, constant: 20).isActive = true
		self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
		self.imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
		self.imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
		
		self.stackView2.addArrangedSubview(self.publisherLabel)
		self.stackView2.addArrangedSubview(self.languageLabel)
		self.stackView2.addArrangedSubview(self.pagesLabel)
		self.stackView2.addArrangedSubview(self.isbn10Label)
		self.stackView2.addArrangedSubview(self.isbn13Label)
		self.stackView2.addArrangedSubview(self.priceLabel)
		self.stackView2.addArrangedSubview(self.yearLabel)
		self.stackView2.addArrangedSubview(self.urlButton)
		
		self.stackView2.translatesAutoresizingMaskIntoConstraints = false
		self.stackView2.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 20).isActive = true
		self.stackView2.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
		self.stackView2.topAnchor.constraint(equalTo: self.imageView.topAnchor).isActive = true
		
		self.lineView.translatesAutoresizingMaskIntoConstraints = false
		self.lineView.topAnchor.constraint(equalTo: self.stackView2.bottomAnchor, constant: 40).isActive = true
		self.lineView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
		self.lineView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
		self.lineView.heightAnchor.constraint(equalToConstant: 50).isActive = true
		
		self.reviewStackView.addArrangedSubview(self.reviewerLabel)
		self.reviewStackView.addArrangedSubview(self.memoLabel)
		self.reviewStackView.translatesAutoresizingMaskIntoConstraints = false
		self.reviewStackView.centerYAnchor.constraint(equalTo: self.lineView.centerYAnchor).isActive = true
		self.reviewStackView.leadingAnchor.constraint(equalTo: self.lineView.leadingAnchor, constant: 10).isActive = true
		self.reviewStackView.trailingAnchor.constraint(equalTo: self.lineView.trailingAnchor, constant: -10).isActive = true
		
		self.descLabel.translatesAutoresizingMaskIntoConstraints = false
		self.descLabel.topAnchor.constraint(equalTo: self.lineView.bottomAnchor, constant: 30).isActive = true
		self.descLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
		self.descLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
		
		self.reviewerLabel.setContentHuggingPriority(.required, for: .horizontal)
		self.memoLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
	}
	
	private func configure() {
		guard let title = self.bookDetailList.title else { return }
		
		self.titleLabel.text = title
		self.subtitleLabel.text = self.bookDetailList.subtitle ?? ""
		self.publisherLabel.text = "[ " + (self.bookDetailList.publisher ?? "") + " ]"
		self.authorsLabel.text = self.bookDetailList.authors ?? ""
		self.languageLabel.text = self.bookDetailList.language ?? ""
		self.pagesLabel.text = (self.bookDetailList.pages ?? "") + " pages"
		self.isbn13Label.text = "isbn13 : " + (self.bookDetailList.isbn13 ?? "")
		self.isbn10Label.text = "isbn10 : " + (self.bookDetailList.isbn10 ?? "")
		self.priceLabel.text = self.bookDetailList.price ?? ""
		self.yearLabel.text = "in " + (self.bookDetailList.year ?? "")
		self.descLabel.text = self.bookDetailList.desc ?? ""
		self.imageView.setImageUrl(self.bookDetailList.image ?? "")
	}
	
	private func fetchBooksDetail() {
		let bookRequest = BookAPI(bookDetailString: self.isbn13 ?? "")
		bookRequest.fetchBooksDetailList {[weak self] result in
			self?.bookDetailList = result
			DispatchQueue.main.async {
				self?.configure()
				self?.setReviewer()
			}
		}
	}
	
	private func buttonClick() {
		self.urlButton.addTarget(self, action: #selector(self.urlButtonClick), for: .touchUpInside)
		let tap = UITapGestureRecognizer(target: self, action: #selector(self.memoButtonClick))
		self.memoLabel.isUserInteractionEnabled = true
		self.memoLabel.addGestureRecognizer(tap)
	}
	
	@objc private func urlButtonClick() {
		guard let url = self.bookDetailList.url else { return }
		
		if let url = URL(string: url) {
			if #available(iOS 10, *) {
				UIApplication.shared.open(url)
			} else {
				UIApplication.shared.openURL(url)
			}
		}
	}
	
	@objc private func memoButtonClick() {
		guard let isbn13 = self.bookDetailList.isbn13 else { return }
		
		let vc = MemoViewController()
		vc.isbn13 = isbn13
		self.navigationController?.present(vc, animated: true, completion: nil)
	}
	
	private func setReviewer() {
		guard let key = self.bookDetailList.isbn13 else { return }
		
		let count = UserDefaults.standard.array(forKey: key)?.count
		self.reviewerLabel.text = "Reviewers (\(count ?? 0))"
	}
}
