//
//  BookAPI.swift
//  MyBookshelfApp
//
//  Created by 김보민 on 2021/03/09.
//

import Foundation
import UIKit

enum BookInfoError:Error {
	case noDataAvailable
	case canNotProcessData
}

struct BookAPI {
	var resourceURL : URL? = nil

	init(searchString: String) {
		let bookSearchString : String = "https://api.itbook.store/1.0/search/\(searchString)"
		self.resourceURL = convertUrl(bookSearchString)
	}
	
	init(bookDetailString: String) {
		let bookDetailString : String = "https://api.itbook.store/1.0/books/\(bookDetailString)"
		self.resourceURL = convertUrl(bookDetailString)
	}
	
	func fetchBooksList(completion: @escaping(Result<([Book]), BookInfoError>) -> Void) {
		let dataTask = URLSession.shared.dataTask(with: self.resourceURL!) { data, _, _ in
			guard let jsonData = data else {
				completion(.failure(.noDataAvailable))
				return
			}
			do {
				let decoder = JSONDecoder()
				let bookInfoResponse = try decoder.decode(BookInfoResponse.self, from: jsonData)
				let bookDetails = bookInfoResponse.books
				completion(.success((bookDetails)))
			} catch {
				completion(.failure(.canNotProcessData))
			}
		}
		dataTask.resume()
	}
}


extension BookAPI {
	func convertUrl(_ resourceString : String) -> URL {
		guard let stringurlfixed = resourceString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let resourceURL = URL(string: stringurlfixed)
		else {
			print(resourceString)
			fatalError()
		}
		return resourceURL
	}
}
