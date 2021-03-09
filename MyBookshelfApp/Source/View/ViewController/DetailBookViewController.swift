//
//  DetailBookViewController.swift
//  MyBookshelfApp
//
//  Created by 김보민 on 2021/03/09.
//

import UIKit

class DetailBookViewController: UIViewController {
	var books: Book? = nil
	
	private var titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		return label
	}()
	
	private var subtitleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		return label
	}()
	
	private var isbn13Label: UILabel = {
		let label = UILabel()
		label.textColor = .black
		return label
	}()
	
	private var priceLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		return label
	}()
	
	private var imageView = UIImageView()
	
	private var urlLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		return label
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setup()
		setLayout()
	}
	
	private func setup() {
		
		self.titleLabel.text = "title : " + String(describing: self.books?.title ?? "")
		self.subtitleLabel.text = "subtitle : " + String(describing: self.books?.subtitle ?? "")
		self.isbn13Label.text = "isbn13 : " + String(describing: self.books?.isbn13 ?? "")
		self.priceLabel.text = "price : " + String(describing: self.books?.price ?? "")
		self.urlLabel.text = "url : " + String(describing: self.books?.url ?? "")
		self.loadImage(from: self.convertUrl(self.books?.image ?? ""))
	}
	
	private func setLayout() {
		self.view.backgroundColor = .white
		self.view.addSubview(self.imageView)
		self.imageView.translatesAutoresizingMaskIntoConstraints = false
		self.imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30.0).isActive = true
		self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		
		self.view.addSubview(self.titleLabel)
		self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
		self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 10.0).isActive = true
		self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		
		self.view.addSubview(self.subtitleLabel)
		self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
		self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10.0).isActive = true
		self.subtitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		
		self.view.addSubview(self.isbn13Label)
		self.isbn13Label.translatesAutoresizingMaskIntoConstraints = false
		self.isbn13Label.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: 10.0).isActive = true
		self.isbn13Label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		
		self.view.addSubview(self.priceLabel)
		self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
		self.priceLabel.topAnchor.constraint(equalTo: self.isbn13Label.bottomAnchor, constant: 10.0).isActive = true
		self.priceLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		
		self.view.addSubview(self.urlLabel)
		self.urlLabel.translatesAutoresizingMaskIntoConstraints = false
		self.urlLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 10.0).isActive = true
		self.urlLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
	}
}


extension DetailBookViewController {
	func loadImage(from url: URL) {
		var task : URLSessionDataTask!
		task  = URLSession.shared.dataTask(with: url) { (data, responds, error) in
			guard let data = data, let newImage = UIImage(data: data) else {
				return
			}
			DispatchQueue.main.async {
				self.imageView.image = newImage
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
