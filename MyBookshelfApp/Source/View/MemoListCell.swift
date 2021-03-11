//
//  MemoListCell.swift
//  MyBookshelfApp
//
//  Created by 김보민 on 2021/03/11.
//

import UIKit

class MemoListCell: UITableViewCell {
	
	private var memo: UILabel = {
		let label = UILabel()
		label.textColor = .darkGray
		label.textAlignment = .center
		label.numberOfLines = 0
		label.lineBreakMode = .byWordWrapping
		return label
	}()
	private var line: UIView = {
		let view = UIView()
		view.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
		view.backgroundColor = UIColor(red: 252/255, green: 60/255, blue: 68/255, alpha: 1)
		return view
	}()
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: "MemoListCell")
		
		self.setup()
		self.layout()
	}
}

extension MemoListCell {
	
	private func setup() {
		self.contentView.backgroundColor = .white
	}
	
	private func layout() {
		self.contentView.addSubview(self.memo)
		self.contentView.addSubview(self.line)
		self.memo.translatesAutoresizingMaskIntoConstraints = false
		self.memo.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
		self.memo.bottomAnchor.constraint(equalTo: self.line.topAnchor, constant: -10).isActive = true
		self.memo.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
		self.memo.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
		
		self.contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
		
		self.line.translatesAutoresizingMaskIntoConstraints = false
		self.line.widthAnchor.constraint(equalToConstant: 100).isActive = true
		self.line.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
		self.line.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
		self.line.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
	}
	
	public func loadMemo(memo : String) {
		self.memo.text =  memo
	}
}
