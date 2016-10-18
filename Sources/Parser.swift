//
//  Parser.swift
//  SwifterCSV
//
//  Created by Will Richardson on 13/04/16.
//  Copyright © 2016 JavaNut13. All rights reserved.
//

extension CSV {
    /// Parse the file and call a block on each row, passing it in as a list of fields
    /// limitTo will limit the result to a certain number of lines
    func enumerateAsArray(_ block: @escaping ([String]) -> (), limitTo: Int?, startAt: Int = 0) {
        // var currentIndex = text.startIndex
        // let endIndex = text.endIndex

        var state = State.start
        let doLimit = limitTo != nil
        let accumulate = Accumulator(block: block, delimiter: delimiter, startAt: startAt)

        // http://stackoverflow.com/questions/36194060/using-string-characterview-index-successor-in-for-statements
        // while currentIndex < endIndex

        for (_ , character) in text.characters.enumerated() {
            if doLimit && accumulate.count >= limitTo! {
                break
            }
            // state = state.nextState(accumulate, char: text[currentIndex])
            state = state.nextState(accumulate, char: character)
            switch state {
            case .error(let msg):
                fatalError(msg)
            default:
                break
            }
            // currentIndex = currentIndex.successor()
        }
        if accumulate.hasContent || (doLimit && accumulate.count < limitTo!) {
            accumulate.pushRow()
        }
    }
}
