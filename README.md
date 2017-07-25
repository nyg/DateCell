# DateCellSwift

## Description

Apple's DateCell code sample rewritten in Swift in a much more configurable way. Check `rowCount` and `dateLabels` in the `TableViewController`.

```swift
// row count per section, here: 3 sections of 2, 5 and 2 rows each
let rowCount = [ 2, 5, 2 ]

// index path of all the date label cells
var dateLabels = [
    IndexPath(row: 1, section: 0),
    IndexPath(row: 1, section: 1),
    IndexPath(row: 3, section: 1),
    IndexPath(row: 0, section: 2),
    IndexPath(row: 1, section: 2) ]
```

## Note

The index path show in each cell may at time be incorrect because the cell was not refreshed. This is not an issue as in real applications we rarely display the index path to the user...

## Screenshot

![](http://i.imgur.com/pAFg2ap.png)