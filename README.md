# VariableDataTable

Variable Data Table for iOS + Swift 3+

Once in a while, there is a need for iOS developers to display simple data in an x.y table layout, however it might seem to be too cumbersome to use UITableView for this. Say we want to display a horizontal datatable, where the overhead cell contains several column identifiers, such as Name, Surname, Age, Job and the rows beneath contain raw data from a datasource. It could be done relatively easily but one has to assemble it manually from a visual perspective. Say we want to have multiple tables like this in one app, or in one view, but with different frames, fonts, colors, or number of rows/columns. Say we want to display this table within a UITableViewCell. Would we nest another UITableView in it to achieve this?

That's where VariableDataTable comes in. Despite TableView being more flexible, because VDTable is assembled from UIViews anyway and TableView is dequeued and optimized, VDTable’s cells can't be buttons, the DataTable cannot be scrolled by default (unless embedded in a Scroll View), it’s important to know that VDTable is meant to be used just to display simple data, as quickly and painlessly as possible. I’m personally using it whenever I need to display a Hall of Fame or some simple statistic.

## Requirements
iOS 8.0, XCode 8.3.3

## Installation

### CocoaPods
To install VDTable using CocoaPods, put it in your Podfile:

```
pod 'VariableDataTable'
```

### Manually
Download the VDTable.swift file to your project

## Usage

Let’s start with a simple horizontal datatable that displays Name, Surname and Age of three users. We instantiate the table, add it to our view and give it a frame and center. Then we fill in the data. HeadCells contain the overhead values for each column. 

Note: The tables in pictures always have a little bit of shade to differentiate it from the rest of the parent view, by default the background for the VDTable is white and the view has no shadow applied.

```swift
let vDTable = VDTable()

self.view.addSubview(vDTable)

vDTable.frame = CGRect(x: 50, y: 50, width: self.view.frame.width / 1.25, height: 100)
vDTable.center = CGPoint(x: self.view.center.x, y: vDTable.center.y + 20)

let headCells: [HeadCell] =
[
  HeadCell(textValue: "Name"),
  HeadCell(textValue: "Surname"),
  HeadCell(textValue: "Age"),
]
let dataCells: [DataCell] =
[
  DataCell(textValues: ["Peter", "Johnson", "25"]),
  DataCell(textValues: ["Jack", "Armandi", "34"]),
  DataCell(textValues: ["Antonio", "Rossi", "41"])
]
vDTable.assembleHorizontalTable(headCells: headCells, dataCells: dataCells)

```

The result looks like this:

![alt text](https://imgur.com/WAzTKij.png)


The useful and interesting part is we can switch the statement:

```swift
vDTable.assembleHorizontalTable(headCells: headCells, dataCells: dataCells)
```

to:

```swift
vDTable.assembleVerticalTable(headCells: headCells, dataCells: dataCells, textAlignment: .center)
```

and now the VDTable is vertical, where the entries are distributed in columns instead of rows. The textAlignment property is not required and it’s set to .left by default, but the vertical table doesn’t look as good and leggible as when it’s set to .center. (textAlignment can of course be set for the horizontal table as well).

![alt text](https://imgur.com/RtX2eVt.png)

You have surely noticed by now, that the order of Strings in a DataCell is related to the order of HeadCells in the table. If any of the DataCells have more or less data, it does not affect the table or crash the app, the table just doesn’t display it:

```swift
let headCells: [HeadCell] =
[
  HeadCell(textValue: "Name"),
  HeadCell(textValue: "Surname"),
  HeadCell(textValue: "Age"),
]
let dataCells: [DataCell] =
[
  DataCell(textValues: ["Peter", "Johnson", "25", "Chocolate"]),
  DataCell(textValues: ["Jack", "Armandi"]),
  DataCell(textValues: ["Antonio", "Rossi", "41"])
]
vDTable.assembleHorizontalTable(headCells: headCells, dataCells: dataCells)
```

Result:

![alt text](https://imgur.com/oPz2wHI.png)

Now that we have the basics covered, let’s look at all the ways we can customize the appearance of our VDTables. HeadCells have following properties (each can be adjusted in parameter of the initialization of a HeadCell): 
```
textValue (required) 
dimension
fontStyle (for example “Helvetica”) 
fontColor
fontSize
bgColor
```

All the properties are pretty much self-explanatory, but the dimension property is specific in that it doesn’t only change the appearance of the particular HeadCell but also its DataCell.

### Dimension:

By default, whenever the dimensions for the HeadCells are not set (as in the previous examples), the table works with the width (or height if it’s a vertical table) of the table frame and gives each HeadCell and DataCell the exactly same fraction of the dimension, based on the number of HeadCells. This is not optimal, as, for example in a horizontal table, we don’t want the Age column to have the exact same width as the Surname column, because Age is a two/three character-long string at best, and Surname can be quite huge in certain cases. If the dimension value is lower or equal than 0 (or not set at all), its value is set by the table automatically. By setting Surname to 150 points and Age to 30 points, we make the column width appropriate for the type of data they carry:

```swift
let headCells: [HeadCell] =
[
  HeadCell(textValue: "Name"),
  HeadCell(textValue: "Surname", dimension: 150),
  HeadCell(textValue: "Age", dimension: 30)
]
let dataCells: [DataCell] =
[
  DataCell(textValues: ["Peter", "Johnson From London", "25"]),
  DataCell(textValues: ["Jack", "Armandillo Da Selva", "34"]),
  DataCell(textValues: ["Antonio", "Rossini Bevilacqua", "41"])
]
vDTable.assembleHorizontalTable(headCells: headCells, dataCells: dataCells, textAlignment: .center)
```

Result:

![alt text](https://imgur.com/WAzTKij.png)

To demonstrate a table that might resemble a more practical implementation, et’s make a little more customized horizontal VDTable from a data set about companies:

```swift
let vDTable = VDTable() self.view.addSubview(vDTable)
let width = self.view.frame.width
        
vDTable.frame = CGRect(x: 50, y: 50, width: width, height: 250)
vDTable.center = CGPoint(x: self.view.center.x, y: vDTable.center.y + 20)
        
let companies: [(String, Int, String, String)] =
[
  ("Chemical Inc.", 254, "Lex. Avenue 45", "Soaps"),
  ("Fishing company", 46, "357 Alfredsson St.", "Rods and baits"),
  ("Coders4Life", 142, "Jefferson Ind. Park", "Mobile software"),
  ("AgroComplex Inc.", 4325, "Public City Park 5", "Herbicides and poisons"),
  ("HorizonWindows", 95, "Main Street 68", "Windows and window frames")
]
        
let headColor = UIColor(red: 0.51, green: 0.73, blue: 0.51, alpha: 1.0)
let headCells: [HeadCell] =
[
  HeadCell(textValue: "Company", dimension: width / 4, fontSize: 12, bgColor: headColor),
  HeadCell(textValue: "Employees", dimension: width / 6, fontSize: 12, bgColor: headColor),
  HeadCell(textValue: "Address", dimension: width / 4, fontSize: 12, bgColor: headColor),
  HeadCell(textValue: "Key product", dimension: width / 3, fontSize: 12, bgColor: headColor)
]
        
var dataCells: [DataCell] = []
for i in 0..<companies.count
{
  dataCells.append(DataCell(
      textValues: [companies[i].0, String(companies[i].1), companies[i].2, companies[i].3],
      fontStyle: "Helvetica",
      fontColor: i % 2 == 0 ? UIColor.black : UIColor.white,
      fontSize: 12,
      bgColor: i % 2 == 0 ? UIColor.white : UIColor.lightGray
  ))
}
        
vDTable.assembleHorizontalTable(headCells: headCells, dataCells: dataCells, textAlignment: .center)
```

Result:

![alt text](https://imgur.com/BU2eeXk.png)
