//
//  String+Extension.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 13/08/2021.
//

import Foundation

extension String {
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var htmlString: String? {
        return htmlToAttributedString?.string
    }
}
