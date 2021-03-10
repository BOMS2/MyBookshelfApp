//
//  BookListCell.swift
//  MyBookshelfApp
//
//  Created by 김보민 on 2021/03/09.
//

import UIKit


class BookListCell: UITableViewCell {
	
	private let titleLabel = UILabel()
	private let subtitleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .lightGray
		label.font = label.font.withSize(12.0)
		return label
	}()
	private let priceLabel: UILabel = {
		let label = UILabel()
		label.textColor = .red
		return label
	}()
	public let bookImageView = BookImageView()
	private let stackView: UIStackView = {
		let stackView = UIStackView(frame: .zero)
		stackView.axis = .vertical
		stackView.spacing = 10.0
		stackView.alignment = .leading
		return stackView
	}()
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: "BookListCell")
		
		self.setup()
		self.layout()
	}
}


extension BookListCell {
	
	private func setup() {
		self.contentView.backgroundColor = .white
		self.titleLabel.numberOfLines = 0
		self.subtitleLabel.numberOfLines = 0
		self.stackView.setContentHuggingPriority(.required, for:.horizontal)
		self.priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
	}
	
	private func layout() {
		self.contentView.addSubview(self.bookImageView)
		self.bookImageView.translatesAutoresizingMaskIntoConstraints = false
		self.bookImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
		self.bookImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
		self.bookImageView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
		self.bookImageView.widthAnchor.constraint(equalTo: self.bookImageView.heightAnchor, multiplier: 3.0/4.0).isActive = true
		
		self.contentView.addSubview(self.stackView)
		self.stackView.addArrangedSubview(self.titleLabel)
		self.stackView.addArrangedSubview(self.subtitleLabel)
		
		self.stackView.translatesAutoresizingMaskIntoConstraints = false
		self.stackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
		self.stackView.leadingAnchor.constraint(equalTo: self.bookImageView.trailingAnchor).isActive = true
		
		self.contentView.addSubview(self.priceLabel)
		self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
		self.priceLabel.centerYAnchor.constraint(equalTo: self.stackView.centerYAnchor).isActive = true
		self.priceLabel.leadingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: 5.0).isActive = true
		self.priceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5.0).isActive = true
	}
	
	public func loadBookInfo(bookInfo : Book) {
		guard let url = URL(string: bookInfo.image) else { return }
		
		self.titleLabel.text = bookInfo.title
		self.subtitleLabel.text = bookInfo.subtitle
		self.priceLabel.text = bookInfo.price
		self.bookImageView.loadImage(from: url)
	}
}
