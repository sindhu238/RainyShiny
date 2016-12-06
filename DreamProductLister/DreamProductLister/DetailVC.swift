//
//  DetailVC.swift
//  DreamProductLister
//
//  Created by Venkateswara on 29/11/16.
//  Copyright © 2016 Sindhu. All rights reserved.
//

import UIKit
import CoreData

class DetailVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleLabel: CustomTextField!
    @IBOutlet weak var price: CustomTextField!
    @IBOutlet weak var details: CustomTextField!
    
    @IBOutlet weak var image: UIImageView!
    let imagePicker = UIImagePickerController()
    
    var storename = [Store]()
    
    var itemToEdit: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.orange
        storePicker.delegate = self
        storePicker.dataSource = self
        
//        let store = Store(context: context)
//        store.name = "Amazon"
//        
//        let store1 = Store(context: context)
//        store1.name = "Ebay"
//        
//        let store2 = Store(context: context)
//        store2.name = "Myntra"
//        
//        let store3 = Store(context: context)
//        store3.name = "Jabong"
//        
//        ad.saveContext()
        fetchData()
        if itemToEdit != nil  {
            loadDataForEdit()
        }
        
        imagePicker.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return storename.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return storename[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func fetchData()
    {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            self.storename = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        }catch {
            print("Error in fetching store data to picker : ", error)
        }
        
    }
    
    
    @IBAction func onAddPressed(_ sender: UIButton) {
        
        var item: Item!
        
        let picture = Image(context: context)
        picture.image = image.image
        
    
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        item.toImage = picture

        if let titleLabel = titleLabel.text {
            item.title = titleLabel
        }
        if let price = price.text {
            item.price = (price as NSString).doubleValue
        }
        if let details = details.text {
            item.details = details
        }
        item.toStore = storename[storePicker.selectedRow(inComponent: 0)]
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    func loadDataForEdit(){
        if let item = itemToEdit
        {
            titleLabel.text = item.title
            price.text = "\(item.price)"
            details.text = item.details
            image.image = item.toImage?.image as? UIImage
        }
        for i in 0...storename.count-1 {
            if let item = itemToEdit?.toStore {
                if item.name == storename[i].name
                {
                    storePicker.selectRow(i, inComponent: 0, animated: true)
                }
            }
        }
        
    }
    
    @IBAction func onDeletePressed(_ sender: Any) {
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let choosenImage = info[UIImagePickerControllerOriginalImage]
        image.contentMode = .scaleAspectFit
        image.image = choosenImage as? UIImage
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onImageClicked(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    

}
