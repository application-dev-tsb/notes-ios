//
//  TableViewController.swift
//  TableAndSearch
//
//  Created by Lyndon Michael Bibera on 5/20/15.
//  Copyright (c) 2015 Hack of All Codes. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    private var myData = [String]()
    
    private let buyType = ["Higher", "Lower"]
    
    //lesson learned: if its local, its gone
    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.scopeButtonTitles = buyType
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        tableView.tableHeaderView = searchController.searchBar
        
        //bug: search controller goes off-screen without this
        definesPresentationContext = true
        
        //bug: size of search bar is zero if there is no scope buttons
        searchController.searchBar.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let number: Int = searchController.searchBar.text.toInt() {
            let lower: Bool = searchController.searchBar.selectedScopeButtonIndex == 1

            let range = lower ? number-10...number : number...number+10
            
            var newData = [String]()
            for n in range  {
                newData.append("Number \(n)")
            }
            
            myData = newData
            tableView.reloadData()
        }
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        updateSearchResultsForSearchController(searchController)
    }

    // MARK: - TableViewController

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = myData[indexPath.row]
        return cell
    }

}
