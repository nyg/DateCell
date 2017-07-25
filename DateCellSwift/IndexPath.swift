//
//  IndexPath.swift
//  DateCellSwift
//
//  Created by user on 18.07.17.
//  Copyright © 2017 nyg. All rights reserved.
//

import Foundation

extension IndexPath {

    func isBeforeInSection(_ other: IndexPath) -> Bool {
        return section == other.section && row < other.row
    }

    var previousRow: IndexPath {
        return IndexPath(row: row - 1, section: section)
    }

    var nextRow: IndexPath {
        return IndexPath(row: row + 1, section: section)
    }
}
