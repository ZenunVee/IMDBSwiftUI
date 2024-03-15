//
//  Extensions.swift
//  TinyBigMovie
//
//  Created by Zenun Vucetovic on 3/14/24.
//

import Foundation
import UIKit
import SwiftUI

// Extension for the poster image URL
extension URL {
    static func tmdbImageURL(forPath path: String?, size: String = "w500") -> URL? {
        guard let path = path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/\(size)\(path)")
    }
}

// Extension to extract year from the release date of movie
extension String {
    func yearFromDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            return "\(year)"
        }
        return ""
    }
}

// Extension to convert runtime int into readable text
extension Int {
    var formattedRuntime: String {
        let hours = self / 60
        let minutes = self % 60
        return "\(hours)h \(minutes)m"
    }
}

// Extension to turn a hex value into a SwiftUI Color
extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        print(cleanHexCode)
        var rgb: UInt64 = 0

        Scanner(string: cleanHexCode).scanHexInt64(&rgb)

        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}

