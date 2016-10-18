//
//  CSVWithFoundation.swift
//  SwifterCSV
//
//  Created by Will Richardson on 15/04/16.
//  Copyright © 2016 JavaNut13. All rights reserved.
//

// Only use Foundation on OSX and iOS
#if !os(Linux)
import Foundation

extension CSV {
    /// Load a CSV file
    ///
    /// - name: name of the file (will be passed to String(contentsOfFile:encoding:) to load)
    /// - delimiter: character to split row and header fields by (default is ',')
    /// - encoding: encoding used to read file (default is NSUTF8StringEncoding)
    public convenience init(name: String, delimiter: Character = comma, encoding: String.Encoding = String.Encoding.utf8) throws {
        let contents = try String(contentsOfFile: name, encoding: encoding)

        self.init(string: contents, delimiter: delimiter)
    }

    /// Load a CSV file from a URL
    ///
    /// - url: url pointing to the file (will be passed to String(contentsOfURL:encoding:) to load)
    /// - delimiter: character to split row and header fields by (default is ',')
    /// - encoding: encoding used to read file (default is NSUTF8StringEncoding)
    public convenience init(url: URL, delimiter: Character = comma, encoding: String.Encoding = String.Encoding.utf8) throws {
        let contents = try String(contentsOf: url, encoding: encoding)

        self.init(string: contents, delimiter: delimiter)
    }

    /// Turn the CSV data into NSData using a given encoding
    public func dataUsingEncoding(_ encoding: String.Encoding) -> Data? {
        return description.data(using: encoding)
    }
}
#endif
