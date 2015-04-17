//
//  MasterViewController.swift
//  SpotExample
//
//  Created by Amber Star on 4/17/15.
//  Copyright (c) 2015 Amber Star. All rights reserved.
//

import UIKit
import Spot

class MasterViewController: UITableViewController {

    var objects = [AnyObject]()
    var issues : Issues = Issues(closedIssues: [Issue](), openIssues: [Issue]())

    func loadData() {
        // try to load issues to documents directory
        if let loadedIssues: Issues = Decoder.decode(Plist.read(documentPathFor("issues.plist"))) {
            self.issues = loadedIssues
        }
    }
    
    func saveData() {
        Plist.write(Encoder.encode(issues), path: documentPathFor("issues.plist"))
    }
    
    
    func addIssue(index: Int) {
        let product = Product(name: "iSpot Pro")
        let developer = Developer(name: "Spiff Johnson")
        var newIssue = Issue(comment: "write more tests", title: "New Issue", assignee: developer, product: product, status: .open, type: .task)
        self.issues.openIssues.insert(newIssue, atIndex: index)
        self.saveData()

    }
    
    func closeIssue(index: Int) {
        self.issues.openIssues[index].status = IssueStatus.closed
        self.issues.closedIssues.append(self.issues.openIssues[index])
        self.issues.openIssues.removeAtIndex(index)
        self.saveData()

    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.loadData()
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        addIssue(0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let issue = self.issues.openIssues[indexPath.row]
            (segue.destinationViewController as! DetailViewController).detailItem = issue
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.issues.openIssues.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        let issue = issues.openIssues[indexPath.row]
        cell.textLabel!.text = issue.title
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            closeIssue(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

