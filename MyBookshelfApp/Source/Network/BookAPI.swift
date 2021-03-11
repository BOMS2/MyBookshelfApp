//
//  BookAPI.swift
//  MyBookshelfApp
//
//  Created by 김보민 on 2021/03/09.
//

import Foundation
import UIKit

enum BookError: Error {
	case norequest
	case nodata
}

struct BookAPI {
	var resourceURL : URL? = nil

	init(searchString: String) {
		self.resourceURL = URL(string: "https://api.itbook.store/1.0/search/\(searchString)")
	}
	
	init(bookDetailString: String) {
		self.resourceURL = URL(string: "https://api.itbook.store/1.0/books/\(bookDetailString)")
	}
	
	func fetchBooksList(completion : @escaping (_ result: [Book]) -> Void) {
		if let url = self.resourceURL {
			let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
				do {
					guard let data = data, let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode, error == nil else {
						throw error ?? BookError.nodata
					}
					
					let bookInfoResponse = try JSONDecoder().decode(BookInfo.self, from: data)
					let bookDetail = bookInfoResponse.books
					completion(bookDetail)
				} catch {
					print("Error (\(BookError.norequest)) : \(error)")
				}
			}
			task.resume()
		}
	}

	func fetchBooksDetailList(completion : @escaping (_ result: BookDetail) -> Void) {
		if let url = self.resourceURL {
			let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
				do {
					guard let data = data, let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode, error == nil else {
						throw error ?? BookError.nodata
					}
					
					let bookDetail = try JSONDecoder().decode(BookDetail.self, from: data)
					completion(bookDetail)
				} catch {
					print("Error (\(BookError.norequest)) : \(error)")
				}
			}
			task.resume()
		}
	}
}
