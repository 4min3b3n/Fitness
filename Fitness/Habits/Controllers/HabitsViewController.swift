//
//  HabitsViewController.swift
//  Fitness
//
//  Created by Amine BEN ZAGGAGH on 11/11/19.
//  Copyright © 2019 Amine BEN ZAGGAGH. All rights reserved.
//

import UIKit

public protocol HabitDelegate {
    func addHabit(habit newHabit: Habit)
}

public protocol HabitCellDelegate {
    func openHabitDetails()
}

class HabitsViewContoller: UITableViewController {
    
    private lazy var habits = [Habit]()
    
    let persistance: PersistanceService = PersistanceService.shared

    @IBOutlet weak var newHabitButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCells()
        
        let myGoal = Goal(period: .daily, frequency: 3)
        
        let myhabit = Habit(name: "Quit Smoking", type: .build, goal: myGoal, note: "No more cigarette I swear")
        
        habits.append(myhabit)
        
        self.tableView.reloadData()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "New Habit" {
            switch identifier {
            case "New Habit":
                if let destinationViewController = segue.destination as? HabitCreationViewController {
                    destinationViewController.modalPresentationStyle = .fullScreen
                    destinationViewController.habitdelegate = self
                }
            case "Habit Details":
                if let destinationViewController = segue.destination as? HabitDetailsViewController {
                    destinationViewController.modalPresentationStyle = .fullScreen
                    self.present(destinationViewController, animated: false, completion: nil)
                }
            default:
                break
            }
        }
    }
    
    @IBAction func newHabit(_ sender: UIBarButtonItem) {
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // ...
    }
    
    func registerTableViewCells() {
        let habitTableViewCell = UINib(nibName: "HabitTableViewCell", bundle: nil)
        self.tableView.register(habitTableViewCell, forCellReuseIdentifier: "HabitTableViewCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HabitTableViewCell") as? HabitTableViewCell {
            let habit = habits[indexPath.row]
            cell.habitNameLabel?.text = "\(String(describing: habit.name!))"
            cell.habitProgressView.progress = 1.0
            return cell
        } else {
            let cell = UITableViewCell()
            let habit = habits[indexPath.row]
            cell.textLabel?.text = "\(String(describing: habit.name!))"
            cell.detailTextLabel?.text = "Created At \(String(describing: habit.createdAt))"
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            habits.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
}

extension HabitsViewContoller: HabitDelegate {

    func addHabit(habit newHabit: Habit) {
        habits.append(newHabit)
        self.tableView.reloadData()
    }

}
