//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Patientman on 16/10/23.
//  Copyright © 2016年 mingSquall. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    
    func addItemViewControllerDidCancel(controller: AddItemViewController)
    
    func addItemViewController(controller: AddItemViewController,
                               didFinishAddingItem item: ChecklistItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    weak var delegate: AddItemViewControllerDelegate?
    @IBAction func cancel() {
//        dismissViewControllerAnimated(true,completion:nil)
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
//        print("Contents of the text field: \(textField.text!)")
//        dismissViewControllerAnimated(true, completion: nil)
        
        //pass along a new ChecklistItem object that has the text String from the text field
        let item = ChecklistItem()
        item.text = textField.text!
        item.checked = false
        delegate?.addItemViewController(self, didFinishAddingItem: item)

    }
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil 
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        doneBarButton.enabled = newText.length>0
        return true
    }
}

