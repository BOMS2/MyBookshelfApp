//
//  MemoViewController.swift
//  MyBookshelfApp
//
//  Created by 김보민 on 2021/03/11.
//

import UIKit

class MemoViewController: UIViewController {
	
	private let symbol: UILabel = {
		let label = UILabel()
		label.textColor = UIColor(red: 252/255, green: 60/255, blue: 68/255, alpha: 1)
		label.text = "\""
		label.font = label.font.withSize(100)
		return label
	}()
	private let memo: UITextField = {
		let text = UITextField()
		text.borderStyle = .roundedRect
		text.layer.borderColor = UIColor.yellow.cgColor
		text.placeholder = "Write a message about this book"
		text.backgroundColor = .white
		text.textColor = .black
		return text
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setup()
		self.setLayout()
	}
}

extension MemoViewController {
	private func setup() {
		self.view.backgroundColor = .white
	}
	
	private func setLayout() {
		self.view.addSubview(self.symbol)
		self.view.addSubview(self.memo)
		self.symbol.translatesAutoresizingMaskIntoConstraints = false
		self.symbol.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
		self.symbol.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		
		self.memo.translatesAutoresizingMaskIntoConstraints = false
		self.memo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		self.memo.topAnchor.constraint(equalTo: self.symbol.bottomAnchor, constant: 20).isActive = true
		self.memo.heightAnchor.constraint(equalToConstant: 100).isActive = true
	}
}
