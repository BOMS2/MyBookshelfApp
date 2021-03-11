//
//  MemoViewController.swift
//  MyBookshelfApp
//
//  Created by 김보민 on 2021/03/11.
//

import UIKit

class MemoViewController: UIViewController {
	
	private let symbolLabel: UILabel = {
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
	private let saveButton: UIButton = {
		let button = UIButton()
		button.setTitle("✔️", for: .normal)
		button.setTitleColor(.black, for: .normal)
		return button
	}()
	var isbn13: String = ""
	private var memoList: [String] = [] {
		didSet{
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
	private var tableView = UITableView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setup()
		self.setLayout()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.setupList()
	}
}

extension MemoViewController {
	private func setup() {
		self.view.backgroundColor = .white
		self.saveButton.addTarget(self, action:#selector(self.saveMemo), for: .touchUpInside)
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.register(MemoListCell.self, forCellReuseIdentifier: "MemoListCell")
		self.tableView.separatorStyle = .none
		
		self.saveButton.setContentCompressionResistancePriority(.required, for: .horizontal)
	}
	
	private func setLayout() {
		self.view.addSubview(self.symbolLabel)
		self.view.addSubview(self.memo)
		self.view.addSubview(self.saveButton)
		self.view.addSubview(self.tableView)
		self.symbolLabel.translatesAutoresizingMaskIntoConstraints = false
		self.symbolLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
		self.symbolLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
		
		self.memo.translatesAutoresizingMaskIntoConstraints = false
		self.memo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
		self.memo.topAnchor.constraint(equalTo: self.symbolLabel.bottomAnchor).isActive = true
		self.memo.heightAnchor.constraint(equalToConstant: 80).isActive = true
		
		self.saveButton.translatesAutoresizingMaskIntoConstraints = false
		self.saveButton.centerYAnchor.constraint(equalTo: self.memo.centerYAnchor).isActive = true
		self.saveButton.leadingAnchor.constraint(equalTo: self.memo.trailingAnchor, constant: 10).isActive = true
		self.saveButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
		self.saveButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		self.tableView.translatesAutoresizingMaskIntoConstraints = false
		self.tableView.topAnchor.constraint(equalTo: self.memo.bottomAnchor, constant: 10).isActive = true
		self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
	}
	
	private func setupList() {
		guard let list = UserDefaults.standard.array(forKey: "\(self.isbn13)") as? [String] else { return }
		
		self.memoList = list
	}
	
	@objc func saveMemo() {
		guard let memo = self.memo.text, !memo.isEmpty else { return }
		
		self.memoList.append(memo)
		UserDefaults.standard.set(self.memoList, forKey: "\(self.isbn13)")
	}
}

extension MemoViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.memoList.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemoListCell", for: indexPath) as? MemoListCell else { return UITableViewCell() }
		
		let memoInfo = self.memoList[indexPath.row]
		cell.loadMemo(memo: memoInfo)
		
		return cell
	}
}

extension MemoViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
}
