//
//  ViewController.swift
//  ticktactoe
//
//  Created by Erik Clineschmidt on 11/3/16.
//  Copyright © 2016 Erik Clineschmidt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var squares: [UIButton]!
    @IBOutlet weak var results_msg: UILabel!
    
    let top_across  = Set([1,2,3])
    let mid_across  = Set([4,5,6])
    let btm_across  = Set([7,8,9])
    let diag_right  = Set([1,5,9])
    let diag_left   = Set([3,5,7])
    let left_down   = Set([1,4,7])
    let mid_down    = Set([2,5,8])
    let right_down  = Set([3,6,9])
    
    var p_1_choices = Set<Int>()
    var p_2_choices = Set<Int>()
    
    var whose_turn = 1
    
    var p1_wins = 0
    var p2_wins = 0
    
    func check_winner(checkset: Set<Int>) -> Bool {
        if(top_across.isSubset(of: checkset)
            || mid_across.isSubset(of: checkset)
            || btm_across.isSubset(of: checkset)
            || diag_right.isSubset(of: checkset)
            || diag_left.isSubset(of: checkset)
            || left_down.isSubset(of: checkset)
            || mid_down.isSubset(of: checkset)
            || right_down.isSubset(of: checkset)
            ){
            return(true)
            }else{
                return(false)
            }
    }
    
    func reset(){
        for idx in 0...8 {
            self.squares[idx].backgroundColor = UIColor.white
        }
        results_msg.text = ""
        p_1_choices = Set<Int>()
        p_2_choices = Set<Int>()
    }
    
    func update_turn() { whose_turn == 1 ? (whose_turn = 2) : (whose_turn = 1) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func reset(_ sender: Any) {
        reset()
    }

    @IBAction func select_square(_ sender: UIButton) {
        var winner = false
        if(whose_turn == 1){
            (sender as UIButton).backgroundColor = UIColor.red
            p_1_choices.insert(sender.tag)
            print("player 1 ",p_1_choices)
            winner = check_winner(checkset: p_1_choices)
        }else{
            (sender as UIButton).backgroundColor = UIColor.blue
            p_2_choices.insert(sender.tag)
            print("player 2 ",p_2_choices)
            winner = check_winner(checkset: p_2_choices)
        }
        if(winner == true){
             self.results_msg.text = " Player \(whose_turn) WINS!!"
            
            // update the winner counts
            whose_turn == 1 ? (p1_wins += 1) : (p2_wins += 1)
            // display player wins
            // --> TODO
            
            update_turn()

        }else if (p_1_choices.count + p_2_choices.count == 9){
            reset()
            }else{
                update_turn()
            }
    }

}

