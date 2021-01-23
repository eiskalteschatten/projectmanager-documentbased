//
//  Helpers.swift
//  ProjectManager
//
//  Created by Alex Seifert on 23/01/2021.
//

import Foundation

func getLocalizedDate(date: Date = Date()) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .full
    dateFormatter.timeStyle = .none
    dateFormatter.locale = Locale.autoupdatingCurrent
    return dateFormatter.string(from: date)
}

func getLocalizedShortDateTime(date: Date = Date()) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .short
    dateFormatter.locale = Locale.autoupdatingCurrent
    return dateFormatter.string(from: date)
}

func getLocalizedDateWithFormat(date: Date = Date(), format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.locale = Locale.autoupdatingCurrent
    return dateFormatter.string(from: date)
}

func getLocalizedTime(date: Date = Date()) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .none
    dateFormatter.timeStyle = .short
    dateFormatter.locale = Locale.autoupdatingCurrent
    return dateFormatter.string(from: date)
}
