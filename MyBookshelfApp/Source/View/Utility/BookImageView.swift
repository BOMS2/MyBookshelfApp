//
//  BookImageView.swift
//  MyBookshelfApp
//
//  Created by 김보민 on 2021/03/10.
//

import UIKit

class BookImageView: UIImageView {

	func loadImage(from url: URL) {
		let task  = URLSession.shared.dataTask(with: url) { (data, responds, error) in
			guard let data = data, let image = UIImage(data: data) else { return }
			
			DispatchQueue.main.async {
				self.image = image
			}
		}
		task.resume()
	}
}
