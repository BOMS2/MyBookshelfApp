//
//  Book.swift
//  MyBookshelfApp
//
//  Created by 김보민 on 2021/03/09.
//

struct BookInfoResponse: Codable {
	var error : String
	var total : String
	var page : String
	var books : [Book]
}

struct Book: Codable {
	var title : String
	var subtitle : String
	var isbn13 : String?
	var price : String
	var image : String
	var url : String
}
