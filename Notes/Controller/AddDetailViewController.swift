//
//  AddDetailViewController.swift
//  Notes
//
//  Created by Hitesh  Agarwal on 8/19/18.
//  Copyright © 2018 Hitesh  Agarwal. All rights reserved.
//

import UIKit
import CoreData

protocol AddDetailViewControllerDelegate: class {
    func refreshTableView()
}

class AddDetailViewController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var txtFieldLastName: UITextField!
    @IBOutlet weak var txtFieldLocation: UITextField!
    @IBOutlet weak var txtFieldName: UITextField!
    
    weak var delegate: AddDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFieldName.text = "Tony"
        txtFieldLastName.text = "Stark"
        txtFieldLocation.text = "America"
    }
    
    @IBAction func actionAdd(_ sender: UIButton) {
        let personModal = PersonModal(firstName: txtFieldName.text!,
                                      lastName: txtFieldLastName.text!,
                                      location: txtFieldLocation.text!)
        
        let childManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        childManagedObjectContext.parent = CoreDataManager.shared.managesObjectContext
        
        childManagedObjectContext.performAndWait {
            
            DispatchQueue.global(qos: .background).async {
                for i in 0..<100000 {
                    print("value \(i)")
                }
                
                let _ = personModal.saveInDB(context: childManagedObjectContext)
                
                
                CoreDataManager.shared.managesObjectContext.performAndWait {
                    
                    do {
                        try CoreDataManager.shared.managesObjectContext.save()
                        self.delegate?.refreshTableView()
                    }
                    catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
            
            self.navigationController?.popViewController(animated: true)
            
        }
    }

}
