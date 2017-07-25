//
//  DateFormatter.swift
//  DateCellSwift
//
//  Created by user on 19.07.17.
//  Copyright © 2017 nyg. All rights reserved.
//

import Foundation

extension DateFormatter {

    convenience init(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) {
        self.init()
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
    }
}
