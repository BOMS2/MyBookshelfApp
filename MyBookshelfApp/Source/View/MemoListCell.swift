//
//  MemoListCell.swift
//  MyBookshelfApp
//
//  Created by 김보민 on 2021/03/11.
//

import UIKit

class MemoListCell: UITableViewCell {
	
	private var memo = UILabel()
	
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
		self.
	}
	
	private func layout() {
		self.contentView.addSubview(self.memo)
		self.memo.translatesAutoresizingMaskIntoConstraints = false
		self.memo.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
		self.memo.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
	}
	
	public func loadMemo(memo : String) {
		self.memo.text = memo
	}
}
