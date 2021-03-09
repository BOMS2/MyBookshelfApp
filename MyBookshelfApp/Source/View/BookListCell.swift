//
//  BookListCell.swift
//  MyBookshelfApp
//
//  Created by 김보민 on 2021/03/09.
//

import UIKit

class BookListCell: UITableViewCell {
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		return label
	}()
	
	public let bookImageView = UIImageView()
	
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: "BookListCell")
		
		self.setup()
	}
}


extension BookListCell {
	private func setup() {
		self.contentView.backgroundColor = .white
		
		self.contentView.addSubview(self.bookImageView)
		self.bookImageView.translatesAutoresizingMaskIntoConstraints = false
		self.bookImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
		self.bookImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
		self.bookImageView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
		self.bookImageView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true

		self.contentView.addSubview(self.titleLabel)
		self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
		self.titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
		self.titleLabel.leadingAnchor.constraint(equalTo: self.bookImageView.trailingAnchor, constant: 10.0).isActive = true
		self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
	}
	
	public func loadBookInfo(bookInfo : Book) {
		self.titleLabel.text = bookInfo.title
		self.loadImage(from: self.convertUrl(bookInfo.image))
	}
}

extension BookListCell {
	func loadImage(from url: URL) {
		var task : URLSessionDataTask!
		task  = URLSession.shared.dataTask(with: url) { (data, responds, error) in
			guard let data = data, let newImage = UIImage(data: data) else {
				return
			}
			DispatchQueue.main.async {
				self.bookImageView.image = newImage
			}
		}
		task.resume()
	}
	
	func convertUrl(_ resourceString : String) -> URL {
		guard let stringurlfixed = resourceString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let resourceURL = URL(string: stringurlfixed)
		else {
			print(resourceString)
			fatalError()
		}
		return resourceURL
	}
}
