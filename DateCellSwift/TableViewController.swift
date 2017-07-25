//
//  TableViewController.swift
//  DateCellSwift
//
//  Created by user on 16.07.17.
//  Copyright © 2017 nyg. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    // MARK: Configuration

    // row count per section, here: 3 sections of 2, 5 and 2 rows each
    let rowCount = [ 2, 5, 2 ]

    // index path of all the date label cells
    var dateLabels = [
        IndexPath(row: 1, section: 0),
        IndexPath(row: 1, section: 1),
        IndexPath(row: 3, section: 1),
        IndexPath(row: 0, section: 2),
        IndexPath(row: 1, section: 2) ]

    // MARK: Properties

    var selectedDateLabel: IndexPath?

    // MARK: Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return rowCount.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount[section] + (selectedDateLabel?.section == section ? 1 : 0)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if selectedDateLabel == indexPath.previousRow {
            return datePickerCell(for: indexPath)
        }

        if dateLabels.contains(indexPath) {
            return dateLabelCell(for: indexPath)
        }

        return normalCell(for: indexPath)
    }

    // MARK: Table view delegate

    // necessary for date picker cells to resize automatically
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // if selected row is a date label
        if dateLabels.contains(indexPath) {

            let showDatePicker = selectedDateLabel != indexPath
            var currentIndexPath = indexPath

            // hide any date picker already being displayed
            if let selected = selectedDateLabel {

                // move date labels and current index path back one row to reflect removed date picker
                dateLabels = dateLabels.map {
                    selected.isBeforeInSection($0) ? $0.previousRow : $0
                }

                if selected.isBeforeInSection(indexPath) {
                    currentIndexPath = indexPath.previousRow
                }

                // update date label cell with value of the date picker cell
                updateDateLabel(at: selected)

                selectedDateLabel = nil
                tableView.deleteRows(at: [ selected.nextRow ], with: .top)
            }

            // show date picker
            if showDatePicker {

                // advance date labels one row to reflect added date picker
                dateLabels = dateLabels.map {
                    currentIndexPath.isBeforeInSection($0) ? $0.nextRow : $0
                }

                selectedDateLabel = currentIndexPath
                tableView.insertRows(at: [ currentIndexPath.nextRow ], with: .top)
            }
        }
        else {
            print("Normal cell tapped")
        }
    }

    func updateDateLabel(at indexPath: IndexPath) {

        guard let dateLabelCell = tableView.cellForRow(at: indexPath),
              let datePickerCell = tableView.cellForRow(at: indexPath.nextRow) as? DatePickerCell
        else {
                fatalError("Could not retrieve proper cells")
        }

        dateLabelCell.detailTextLabel?.text = datePickerCell.dateString
    }

    // MARK: Cell creation

    func dateLabelCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dateLabelCell", for: indexPath)
        cell.textLabel?.text = "Date Label Cell \(indexPath.description)"
        cell.selectionStyle = .none
        return cell
    }

    func datePickerCell(for indexPath: IndexPath) -> UITableViewCell {

        guard let dateLabelCell = tableView.cellForRow(at: indexPath.previousRow),
              let datePickercell = tableView.dequeueReusableCell(withIdentifier: "datePickerCell", for: indexPath) as? DatePickerCell
        else {
            fatalError("Could not retrieve date proper cells")
        }

        datePickercell.selectionStyle = .none
        datePickercell.dateString = dateLabelCell.detailTextLabel?.text

        return datePickercell
    }

    func normalCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath)
        cell.textLabel?.text = "Normal Cell \(indexPath.description)"
        cell.selectionStyle = .none
        return cell
    }
}
