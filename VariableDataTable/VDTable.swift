//
//  VDTable.swift
//  VariableDataTable
//
//  Created by Vojtech Florko on 01/08/2017.
//  Copyright © 2017 Vojtech Florko. All rights reserved.
//

import UIKit

public class VDTable: UIView
{
    
    override public func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    public func assembleHorizontalTable(headCells: [HeadCell], dataCells: [DataCell], textAlignment: NSTextAlignment = .left)
    {
        for view in self.subviews
        {
            view.removeFromSuperview()
        }
        
        let widthOfOneItem = self.frame.width / (CGFloat(headCells.count))
        var totalWidth: CGFloat = 0.0
        var widths: [CGFloat] = []
        
        let heightOfOneRow = ((self.frame.height) / CGFloat(dataCells.count + 1))
        
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: heightOfOneRow))
        headView.backgroundColor = UIColor.white
        
        for i in 0..<headCells.count
        {
            var newItemWidth = widthOfOneItem
            if headCells[i].dimension > 0
            {
                newItemWidth = headCells[i].dimension
            }
            
            newItemWidth = CGFloat(ceil(Double(newItemWidth)))
            
            let headName = UILabel(frame: CGRect(x: totalWidth , y: 0, width: newItemWidth, height: heightOfOneRow))
            headName.numberOfLines = 4
            
            totalWidth += newItemWidth
            widths.append(newItemWidth)
            
            headName.font = UIFont(name: headCells[i].fontStyle, size: headCells[i].fontSize)
            headName.textColor = headCells[i].fontColor
            headName.text = headCells[i].textValue
            headName.textAlignment = textAlignment
            headName.backgroundColor = headCells[i].bgColor
            
            headView.addSubview(headName)
        }
        
        let headSectionLine = UIView(frame: CGRect(x: 0, y: headView.frame.height - 1, width: headView.frame.width, height: 1))
        headSectionLine.backgroundColor = UIColor.darkGray
        headView.addSubview(headSectionLine)
        
        self.addSubview(headView)
        
        for i in 0..<dataCells.count
        {
            let dataView = UIView(frame: CGRect(x: 0, y: heightOfOneRow * CGFloat(i) + headView.frame.height, width: self.frame.width, height: heightOfOneRow))
            dataView.backgroundColor = dataCells[i].bgColor
            
            var xPosition: CGFloat = 0.0
            
            for j in 0..<widths.count
            {
                widths[j] = CGFloat(ceil(Double(widths[j])))
                let dataElement = UILabel(frame: CGRect(x: xPosition , y: 0, width: widths[j], height: heightOfOneRow))
                xPosition += widths[j]
                
                dataElement.numberOfLines = 2
                dataElement.font = UIFont(name: dataCells[i].fontStyle, size: dataCells[i].fontSize)
                dataElement.textColor = dataCells[i].fontColor
                dataElement.textAlignment = textAlignment
                if j < dataCells[i].textValues.count
                {
                    dataElement.text = dataCells[i].textValues[j]
                }
                
                dataView.addSubview(dataElement)
            }
            self.addSubview(dataView)
        }
    }
    
    public func assembleVerticalTable(headCells: [HeadCell], dataCells: [DataCell], textAlignment: NSTextAlignment = .left)
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
        headView.backgroundColor = UIColor.white
        
        for i in 0..<headCells.count
        {
            var newItemHeight = heightOfOneItem
            if headCells[i].dimension >= 0
            {
                newItemHeight = headCells[i].dimension
            }
            
            newItemHeight = CGFloat(ceil(Double(newItemHeight)))
            
            let headName = UILabel(frame: CGRect(x: 0, y: totalHeight, width: headView.frame.width, height: newItemHeight))
            headName.numberOfLines = headCells[i].textValue.count / 2
            
            yPositions.append(totalHeight)
            
            totalHeight += newItemHeight
            heights.append(headName.frame.height)
            
            headName.font = UIFont(name: headCells[i].fontStyle, size: headCells[i].fontSize)
            headName.textColor = headCells[i].fontColor
            headName.text = headCells[i].textValue
            headName.textAlignment = textAlignment
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
                heights[j] = CGFloat(ceil(Double(heights[j])))
                let dataElement = UILabel(frame: CGRect(x: 0, y: yPositions[j], width: widthOfOneRow, height: heights[j]))
                yPosition += heights[j]
                
                dataElement.numberOfLines = 4
                dataElement.font = UIFont(name: dataCells[i].fontStyle, size: dataCells[i].fontSize)
                dataElement.textColor = dataCells[i].fontColor
                
                if j < dataCells[i].textValues.count
                {
                    dataElement.text = dataCells[i].textValues[j]
                    dataElement.textAlignment = textAlignment
                    dataElement.numberOfLines = dataElement.text!.count / 2
                }
                dataElement.backgroundColor = dataCells[i].bgColor
                dataView.addSubview(dataElement)
            }
            self.addSubview(dataView)
        }
    }
}

public class HeadCell
{
    var textValue: String
    var dimension: CGFloat
    var fontStyle: String
    var fontColor: UIColor
    var fontSize: CGFloat
    var bgColor: UIColor
    
    public init(textValue: String, dimension: CGFloat = -1, fontStyle: String = "Helvetica", fontColor: UIColor = UIColor.black, fontSize: CGFloat = 12, bgColor: UIColor = UIColor.white)
    {
        self.textValue = textValue
        self.dimension = dimension
        self.fontStyle = fontStyle
        self.fontColor = fontColor
        self.fontSize = fontSize
        self.bgColor = bgColor
    }
}

public class DataCell
{
    var textValues: [String]
    var fontStyle: String
    var fontColor: UIColor
    var fontSize: CGFloat
    var bgColor: UIColor
    
    public init(textValues: [String], fontStyle: String = "Helvetica", fontColor: UIColor = UIColor.black, fontSize: CGFloat = 12, bgColor: UIColor = UIColor.white)
    {
        self.textValues = textValues
        self.fontStyle = fontStyle
        self.fontColor = fontColor
        self.fontSize = fontSize
        self.bgColor = bgColor
    }
}


