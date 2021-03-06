//
//  BookImageView.swift
//  MyBookshelfApp
//
//  Created by 김보민 on 2021/03/10.
//

import UIKit

class BookImageView: UIImageView {
	
	static let shared = NSCache<NSString, UIImage>()
	
	func setImageUrl(_ url: String) {
		let cacheKey = NSString(string: url)
		if let cachedImage = BookImageView.shared.object(forKey: cacheKey) {
			self.image = cachedImage
			return
		} else {
			if let imageUrl = URL(string: url) {
				URLSession.shared.dataTask(with: imageUrl) { (data, res, err) in
					if let _ = err {
						self.image = UIImage()
					} else {
						DispatchQueue.main.async {
							if let data = data, let image = UIImage(data: data) {
								BookImageView.shared.setObject(image, forKey: cacheKey)
								self.image = image
							}
						}
					}
				}.resume()
			}
		}
	}
}
