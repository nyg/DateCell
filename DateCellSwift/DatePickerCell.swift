//
//  DatePickerCell.swift
//  DateCellSwift
//
//  Created by user on 18.07.17.
//  Copyright © 2017 nyg. All rights reserved.
//

import UIKit

class DatePickerCell: UITableViewCell {

    static let df = DateFormatter(dateStyle: .medium, timeStyle: .none)

    @IBOutlet weak var datePicker: UIDatePicker!

    var dateString: String? {

        get {
            return DatePickerCell.df.string(from: datePicker.date)
        }

        set(string) {

            if let date = DatePickerCell.df.date(from: string ?? "") {
                datePicker.date = date
            }
            else {
                datePicker.date = Date()
            }
        }
    }
}
