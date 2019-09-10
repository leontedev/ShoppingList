//
//  ViewController.swift
//  ShoppingList
//
//  Created by Mihai Leonte on 9/10/19.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var items = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Groceries"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddForm))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(emptyList))
    }
    
    
    @objc func showAddForm() {
        let ac = UIAlertController(title: "Add Item", message: "Enter name of item", preferredStyle: .alert)
        
        ac.addTextField { (textField) in
            textField.placeholder = "New Item"
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancel)
        
        let add = UIAlertAction(title: "Add", style: .default) { [unowned ac, weak self] _ in
            guard let new = ac.textFields?[0].text else { return }
            let indexPath = IndexPath(row: self!.items.count, section: 0)
            self!.items.append(new)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        ac.addAction(add)
        
        present(ac, animated: true)
    }
    
    @objc func emptyList() {
        self.items.removeAll()
        tableView.reloadData()
    }
    
    // MARK: - Datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item")!
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    


}

