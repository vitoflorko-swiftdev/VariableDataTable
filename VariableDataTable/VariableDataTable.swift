//
//  VariableDataTable.swift
//  VariableDataTableDemo
//
//  Created by Vojtech Florko on 01/08/2017.
//  Copyright © 2017 Vojtech Florko. All rights reserved.
//

import UIKit

class VariableDataTable: UIView
{
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    //THIS CREATES A UNIVERSAL TABLE WITH n COLUMNS AND n ROWS. NUMBER OF COLUMNS IS COUNT OF COLELEMENTS ARRAY AND NUMBER OF ROWS IS DESCRIBED IN ROWS ARRAY. TYPE COLELEMENTS DESCRIBES A TOP BAR OF COLUMN NAMES AND CONSISTS OF WIDTH AND TEXTVALUE. IF WIDTH IS LESS THAN ZERO, THE WIDTH OF COLUMN NAME WILL BE UNIFORM TO WIDTH OF THE VIEW BY NUMBER OF ELEMENTS, IF NOT, THE WIDTH INPUTTED WILL BE USED.
    
    //TBLROW ELEMENTS WILL HAVE AUTOMATIC WIDTHS BASED ON WIDTHS OF COLELEMENTS. TBLROWS CONSIST OF TEXTVALUES ARRAY AND BGCOLOR. IF LESS VALUES THAN COLELEMENTS WILL BE ADDED, THERE WILL BE BLANKS. IF THERE ARE MORE TEXT VALUES, THE ADDITIONAL ONES WILL NOT APPEAR. BGCOLOR DETERMINES THE COLOR OF ROWS.
    func assembleHorizontalTable(dataCells: [DataCell], headCells: [HeadCell])
    {
        for view in self.subviews
        {
            view.removeFromSuperview()
        }
        
        let widthOfOneItem = UIScreen.main.bounds.width / (CGFloat(headCells.count))
        var totalWidth: CGFloat = 0.0
        var widths: [CGFloat] = []
        
        let heightOfOneRow = ((self.frame.height) / CGFloat(dataCells.count + 1))
        
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: heightOfOneRow))
        
        for i in 0..<headCells.count
        {
            var newItemWidth = widthOfOneItem
            if headCells[i].dimension >= 0
            {
                newItemWidth = headCells[i].dimension
            }
            
            let headName = UILabel(frame: CGRect(x: totalWidth + CGFloat(20.0), y: 0, width: newItemWidth, height: 25.0))
            
            totalWidth += newItemWidth
            widths.append(newItemWidth)
            
            headName.font = UIFont(name: headCells[i].fontStyle, size: headCells[i].fontSize)
            headName.textColor = headCells[i].fontColor
            headName.text = headCells[i].textValue
            headName.backgroundColor = headCells[i].bgColor
            
            headView.addSubview(headName)
        }
        
        let headSectionLine = UIView(frame: CGRect(x: 0, y: headView.frame.height - 1, width: headView.frame.width, height: 1))
        headSectionLine.backgroundColor = UIColor.darkGray
        headView.addSubview(headSectionLine)
        
        self.addSubview(headView)
        
        for i in 0..<dataCells.count
        {
            let dataView = UIView(frame: CGRect(x: 0, y: heightOfOneRow * CGFloat(i) + headView.frame.height, width: UIScreen.main.bounds.width, height: heightOfOneRow))
            dataView.backgroundColor = dataCells[i].bgColor
            
            var xPosition: CGFloat = 0.0
            
            for j in 0..<widths.count
            {
                let dataElement = UILabel(frame: CGRect(x: xPosition + CGFloat(20.0), y: 0, width: widths[j], height: heightOfOneRow))
                xPosition += widths[j]
                
                dataElement.font = UIFont(name: dataCells[i].fontStyle, size: dataCells[i].fontSize)
                dataElement.textColor = dataCells[i].fontColor
                dataElement.text = dataCells[i].textValues[j]
                
                dataView.addSubview(dataElement)
            }
            self.addSubview(dataView)
        }
        
        //        let coverView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        //        coverView.backgroundColor = UIColor.yellow
        //        coverView.alpha = 0.35
        //        coverView.center = self.center
        //        self.addSubview(coverView)
    }
    
    func assembleVerticalTable(dataCells: [DataCell], headCells: [HeadCell])
    {
        for view in self.subviews
        {
            view.removeFromSuperview()
        }
        
        let heightOfOneItem = self.frame.height / (CGFloat(headCells.count))
        var totalHeight: CGFloat = 0.0
        var heights: [CGFloat] = []
        var yPositions: [CGFloat] = []
        
        let widthOfOneRow = ((self.frame.width) / CGFloat(dataCells.count + 1))
        
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: widthOfOneRow, height: self.frame.height))
        
        for i in 0..<headCells.count
        {
            var newItemHeight = heightOfOneItem
            if headCells[i].dimension >= 0
            {
                newItemHeight = headCells[i].dimension
            }
            
            let headName = UILabel(frame: CGRect(x: 0, y: totalHeight + CGFloat(20.0), width: headView.frame.width, height: 25.0))
            headName.numberOfLines = headCells[i].textValue.characters.count / 2
            
            yPositions.append(totalHeight + CGFloat(20.0))
            
            totalHeight += newItemHeight
            heights.append(headName.frame.height)
            
            headName.font = UIFont(name: headCells[i].fontStyle, size: headCells[i].fontSize)
            headName.textColor = headCells[i].fontColor
            headName.text = headCells[i].textValue
            headName.textAlignment = .center
            headName.backgroundColor = headCells[i].bgColor
            
            headView.addSubview(headName)
        }
        
        self.addSubview(headView)
        
        let headSectionLine = UIView(frame: CGRect(x: headView.frame.width - 1, y: 0, width: 1, height: self.frame.height))
        headSectionLine.backgroundColor = UIColor.darkGray
        headView.addSubview(headSectionLine)
        
        for i in 0..<dataCells.count
        {
            let dataView = UIView(frame: CGRect(x: widthOfOneRow * CGFloat(i) + widthOfOneRow, y: 0, width: widthOfOneRow, height: self.frame.height))
            dataView.backgroundColor = dataCells[i].bgColor
            
            var yPosition: CGFloat = 0.0
            
            for j in 0..<heights.count
            {
                let dataElement = UILabel(frame: CGRect(x: 0, y: yPositions[j], width: widthOfOneRow, height: heights[j]))
                yPosition += heights[j]
                
                dataElement.font = UIFont(name: dataCells[i].fontStyle, size: dataCells[i].fontSize)
                dataElement.textColor = dataCells[i].fontColor
                dataElement.text = dataCells[i].textValues[j]
                dataElement.textAlignment = .center
                dataElement.numberOfLines = dataElement.text!.characters.count / 2
                dataElement.backgroundColor = dataCells[i].bgColor
                
                dataView.addSubview(dataElement)
            }
            self.addSubview(dataView)
        }
        
        //        let coverView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        //        coverView.center = self.center
        //        coverView.backgroundColor = UIColor.yellow
        //        coverView.alpha = 0.5
        //        self.addSubview(coverView)
    }
    
}

class HeadCell
{
    var textValue: String
    var dimension: CGFloat
    var fontStyle: String
    var fontColor: UIColor
    var fontSize: CGFloat
    var bgColor: UIColor
    
    init(textValue: String, dimension: CGFloat = -1, fontStyle: String = "Helvetica", fontColor: UIColor = UIColor.black, fontSize: CGFloat = 15, bgColor: UIColor = UIColor.white)
    {
        self.textValue = textValue
        self.dimension = dimension
        self.fontStyle = fontStyle
        self.fontColor = fontColor
        self.fontSize = fontSize
        self.bgColor = bgColor
    }
}

class DataCell
{
    var textValues: [String]
    var fontStyle: String
    var fontColor: UIColor
    var fontSize: CGFloat
    var bgColor: UIColor
    
    init(textValues: [String], fontStyle: String = "Helvetica", fontColor: UIColor = UIColor.black, fontSize: CGFloat = 15, bgColor: UIColor = UIColor.white)
    {
        self.textValues = textValues
        self.fontStyle = fontStyle
        self.fontColor = fontColor
        self.fontSize = fontSize
        self.bgColor = bgColor
    }
}


