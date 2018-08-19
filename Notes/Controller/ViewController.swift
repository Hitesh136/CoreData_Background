//
//  ViewController.swift
//  Notes
//
//  Created by Hitesh  Agarwal on 8/19/18.
//  Copyright © 2018 Hitesh  Agarwal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var arrayPerson = [Person]() {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func fetchData() {
        arrayPerson = PersonModal.getAllPersonInfo()
    }

    @IBAction func actionAdd(_ sender: UIButton) {
        
        
        if let addDetailViewController = storyboard?.instantiateViewController(withIdentifier: "Add") as? AddDetailViewController {
            
            addDetailViewController.delegate = self
            
            self.navigationController?.pushViewController(addDetailViewController, animated: true)
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPerson.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell") as? PersonTableViewCell {
            cell.configureCell(person: arrayPerson[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
}

extension ViewController: AddDetailViewControllerDelegate {
    func refreshTableView() {
        fetchData()
    }
}



