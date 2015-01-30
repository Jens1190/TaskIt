//
//  ViewController.swift
//  TaskIt
//
//  Created by Jens Sproede (OEV) on 23.12.14.
//  Copyright (c) 2014 OEV. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var taskArray:[TaskModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date1 = Date.from(year: 2014, month: 05, day: 20)
        let date2 = Date.from(year: 2014, month: 06, day: 21)
        
        let task1 = TaskModel(task: "Study French", subtask: "Verbs", date: date1)
        let task2 = TaskModel(task: "Eat Dinner", subtask: "Burgers", date: date2)
        let task3 = TaskModel(task: "Gym", subtask: "Leg day", date: date1)
        
//        let task1 : Dictionary<String,String> = ["task": "Study French", "subtask": "Verbs", "date": "01.01.2015"]
//        let task2 : Dictionary<String,String> = ["task": "Eat Dinner", "subtask": "Burgers", "date": "01.01.2015"]
//        let task3 : Dictionary<String,String> = ["task": "Gym", "subtask": "Leg day", "date": "02.01.2015"]
        
        taskArray += [task1, task2, task3]
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        
        let thisTask = taskArray[indexPath.row]
        
        cell.taskLabel.text = thisTask.task
        cell.subtaskLabel.text = thisTask.subtask
        cell.dateLabel.text = Date.toString(date: thisTask.date)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTaskDetail" {
            let detailVC:TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisTask = taskArray[indexPath!.row]
            detailVC.detailTaskModel = thisTask
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println(indexPath.row)
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }
}