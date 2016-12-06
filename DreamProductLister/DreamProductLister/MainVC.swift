//
//  MainVC.swift
//  DreamProductLister
//
//  Created by Venkateswara on 24/11/16.
//  Copyright © 2016 Sindhu. All rights reserved.
//

import UIKit
import  CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var fRController: NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        //generateTestData()
        performFetch()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
         return fRController.sections!.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fRController.sections else {
            fatalError("No sections in FRC")
        }
        
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        configureCell(cell: cell as! ProductsTableViewCell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: ProductsTableViewCell, indexPath: NSIndexPath)  {
        let item = fRController.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objs = fRController.fetchedObjects {
            if objs.count > 0 {
                let itemSelected = objs[indexPath.row]
                performSegue(withIdentifier: "detailVC", sender: itemSelected)
            }
        }
    }
    
    
    func performFetch() {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let datesort = NSSortDescriptor(key: "created", ascending: false)
        let pricesort = NSSortDescriptor(key: "price", ascending: true)
        let titlesort = NSSortDescriptor(key: "title", ascending: true)
        
        if segment.selectedSegmentIndex == 0 {
            request.sortDescriptors = [datesort]
        } else if segment.selectedSegmentIndex == 1 {
            request.sortDescriptors = [pricesort]
        } else if segment.selectedSegmentIndex == 2 {
            request.sortDescriptors = [titlesort]
        }
        
        
        //context code is written in AppDelegate.swift last 2 lines
        fRController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        fRController.delegate = self
        do {
            try fRController.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    @IBAction func senmentChanged(_ sender: UISegmentedControl) {
        performFetch()
        table.reloadData()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        table.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        table.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                table.insertRows(at: [indexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                table.deleteRows(at: [indexPath], with: .fade)
            }
        case .move:
            if let indexPath = indexPath {
                table.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                table.insertRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                if let cell = table.cellForRow(at: indexPath) as? ProductsTableViewCell {
                    configureCell(cell: cell, indexPath: indexPath as NSIndexPath )
                }
                
            }
        }
    }
    
    func generateTestData()  {
        let item = Item(context: context)
        item.title = "Hair dryer"
        item.price = 23.3
        item.details = "Need it to dry hair"
        
        let item1 = Item(context: context)
        item1.title = "Mascara"
        item1.price = 8
        item1.details = "Need it for makeup"
        
        let item2 = Item(context: context)
        item2.title = "Earphones"
        item2.price = 20
        item2.details = "Need it to listen music"
        
        ad.saveContext()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        if segue.identifier == "detailVC" {
            if let destination = segue.destination as? DetailVC{
                if let item = sender as? Item {
                    destination.itemToEdit = item
                }
            }
        }
    }

 
}

