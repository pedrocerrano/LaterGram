//
//  DateFormatter.swift
//  LaterGram
//
//  Created by iMac Pro on 3/14/23.
//

import Foundation

extension Date {
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
