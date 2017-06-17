//
//  TopAppsTableViewController.swift
//  MVVMBlog
//
//  Created by Erica Millado on 6/16/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit

class TopAppsTableViewController: UITableViewController {
    
    //1 - 
    @IBOutlet var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //2 - 
        viewModel.getApps { 
            
            //3 - 
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    //4 -
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsToDisplay(in: section)
    }

    //5 -
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //6 -
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //7 -
        cell.textLabel?.text = viewModel.appTitleToDisplay(for: indexPath)
        //8 -
        cell.detailTextLabel?.text = viewModel.appRatingToDisplay(for: indexPath)
        return cell
    }



}




















