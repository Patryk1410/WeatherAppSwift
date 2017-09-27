//
//  TableViewManager.swift
//  WeatherApp
//
//  Created by patryk on 07.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import UIKit

public extension Array {
    func contains<T>(obj: T) -> Bool where T: Equatable {
        return self.filter({ $0 as? T == obj }).count > 0
    }
}

public extension UITableView {
    func sp_scrollToTop() {
        
        if self.numberOfSections > 0 && self.numberOfRows(inSection: 0) > 0 {
            let top = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: top, at: .top, animated: false)
        }
    }
}

public extension UIViewController {
    func scrollToTop(animated: Bool = true) {
        func scrollToTop(view: UIView?) {
            guard let view = view else { return }
            
            switch view {
            case let tableView as UITableView:
                if tableView.scrollsToTop == true && tableView.contentOffset.y > 0 {
                    tableView.sp_scrollToTop()
                    return
                }
                break
            case let scrollview as UIScrollView:
                if scrollview.scrollsToTop == true && scrollview.contentOffset.y > 0 {
                    let point = CGPoint(x: 0, y: -scrollview.contentInset.top)
                    scrollview.setContentOffset(point, animated: animated)
                    return
                }
            default:
                break
            }
            
            for subView in view.subviews {
                scrollToTop(view: subView)
            }
        }
        
        scrollToTop(view: self.view)
    }
}

public extension UIView {
    
    func parentTableView() -> UITableView? {
        
        var aView = self.superview
        while aView != nil {
            if aView is UITableView {
                return aView as? UITableView
            }
            
            if let aSuperview = aView?.superview {
                aView = aSuperview
            } else {
                aView = nil
            }
        }
        return nil
    }
    
    func parentCell() -> UITableViewCell? {
        var aView = self.superview
        while aView != nil {
            if aView is UITableViewCell {
                return aView as? UITableViewCell
            }
            
            if let aSuperview = aView?.superview {
                aView = aSuperview
            } else {
                aView = nil
            }
        }
        return nil
    }
}

public protocol UITableViewCellLoadableProtocol {
    
    func loadData(_ data: DataObjectProtocol, tableview: UITableView)
    
}

public protocol TableViewManagerDelegate: class {
    
    func didSelect(_ item: DataObjectProtocol)
    
    func pinDelegate(_ item: DataObjectProtocol)
    
}

public class TableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView?
    public weak var delegate: TableViewManagerDelegate?
    
    var data: [DataObjectProtocol]! {
        
        didSet {
            self.privateData = data
            self.tableView!.reloadData()
        }
        
    }
    
    var privateData = [DataObjectProtocol]()
    
    public func reloadItem(item: DataObjectProtocol) {
        let array = self.privateData as NSArray
        
        let index = array.index(of: item)
        let indexPath = IndexPath(row: index, section: 0)
        self.tableView?.reloadRows(at: [indexPath], with: .none)
        
    }
    
    public func removeAllData() {
        self.data = [DataObjectProtocol]()
    }
    
    public func addData(_ items: [DataObjectProtocol]?) {
        
        guard let items = items else {
            return
        }
        
        guard items.count > 0 else {
            return
        }
        
        let count = self.privateData.count
        var indexPaths = [IndexPath]()
        
        if count == 0 {
            self.privateData.append(contentsOf: items)
            
            for data in self.privateData {
                self.registerItem(item: data)
            }
            
            self.tableView?.reloadData()
            return
        }
        
        CATransaction.begin()
        
        self.tableView?.beginUpdates()
        self.privateData.append(contentsOf: items)
        
        for (index, item) in items.enumerated() {
            registerItem(item: item)
            let indexPath = IndexPath(row: count + index, section: 0)
            indexPaths.append(indexPath)
        }
        
        self.tableView?.insertRows(at: indexPaths, with: .automatic)
        self.tableView?.endUpdates()
        
        CATransaction.commit()
        
    }
    
    func registerItem(reuseID: String) {
        
        if let className = NSClassFromString(reuseID) {
            let bundle = Bundle(for: className)
            let nibName = reuseID.components(separatedBy: ".")[1]
            
            self.tableView?.register(UINib(nibName: nibName, bundle: bundle), forCellReuseIdentifier: reuseID)
        }
        
    }
    
    func registerItem(item: DataObjectProtocol) {
        let reuseID = item.reuseID()
        self.registerItem(reuseID: reuseID)
    }
    
    public init(tableView: UITableView) {
        super.init()
        self.tableView = tableView
        self.tableView!.dataSource = self
        self.tableView?.delegate = self
        self.tableView!.estimatedRowHeight = 100
//        self.tableView!.separatorColor = UIColor.clear
//        self.tableView?.backgroundColor = UIColor.clear
        self.privateData = [DataObjectProtocol]()
    }
    
    public convenience init(tableView: UITableView, reuseIDs: [String]) {
        self.init(tableView: tableView)
        
        for reuseID in reuseIDs {
            self.registerItem(reuseID: reuseID)
        }
    }
    @objc public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.privateData.count
    }
    
    @objc public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var dataItem: DataObjectProtocol
        dataItem = self.privateData[indexPath.row]
        
        let reuseID = dataItem.reuseID()
        let tableCell = tableView.dequeueReusableCell(withIdentifier: reuseID)
        
        if let loadableCell = tableCell as? UITableViewCellLoadableProtocol {
            loadableCell.loadData(dataItem, tableview: tableView)
        }
        
        self.delegate?.pinDelegate(dataItem)
        
        return tableCell!
        
    }
    
    @objc public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelect(self.privateData[indexPath.row])
    }
    
    @objc public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let dataItem = self.privateData[indexPath.row]
        return dataItem.height()
    }
    
}

