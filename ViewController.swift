//
//  ViewController.swift
//  aTableView
//
//  Created by Hoang Tuan Anh Van on 9/3/18.
//  Copyright © 2018 Hoang Tuan Anh Van. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 50
    var targetValue: Int = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetPoint: UILabel!
    @IBOutlet weak var totalScore: UILabel!
    @IBOutlet weak var roundNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = Int(slider.value.rounded())
        startNewGame()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let inset =  UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: inset)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: inset)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
    }

    
    @IBAction func showAlert() {
        
        let difference: Int = abs(currentValue - targetValue)
        let points = 100 - difference
        var check = 0, bonus = 0 ;
        let title: String
        
        var message = "You scored \(points)"
        
        switch difference {
        case 0:
            title = "Perfect!"
            bonus = 100
            check = 1;
        case 1:
            title = "You almost had it!"
            bonus = 50
            check = 1 ;
        case 2...5:
            title = "You almost had it!"
        case 6...10:
            title = "Pretty good!"
        default:
            title = "Not even close..."
        }
        
        if check == 1 {
            message += "\nBonus points \(bonus) !!!"
        }
        
        score += (points + bonus)
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Close", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = Int(slider.value.rounded())
    }
    
    func startNewRound() {
        round += 1
        targetValue = Int(arc4random_uniform(100)) + 1
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabel()
    }
    
    func updateLabel() {
        targetPoint.text = String(targetValue)
        totalScore.text = String(score)
        roundNumber.text = String(round)
    }

    @IBAction func startNewGame() {
        round = 0
        score = 0
        startNewRound()
    }
}

