//
//  ViewController.swift
//  KennyGameProject
//
//  Created by Serhat Demir on 28.03.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var highscoreLabel: UILabel!
    @IBOutlet private weak var kenny1: UIImageView!
    @IBOutlet private weak var kenny2: UIImageView!
    @IBOutlet private weak var kenny3: UIImageView!
    @IBOutlet private weak var kenny4: UIImageView!
    @IBOutlet private weak var kenny5: UIImageView!
    @IBOutlet private weak var kenny6: UIImageView!
    @IBOutlet private weak var kenny7: UIImageView!
    @IBOutlet private weak var kenny8: UIImageView!
    @IBOutlet private weak var kenny9: UIImageView!
    
    // MARK: - Properties
    private var score = 0
    private var highScore = 0
    private var timer = Timer()
    private var hideKennyTimer = Timer()
    private var kennyImagesArray = [UIImageView]()
    private var counter = 0
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        click()
        timers()
        getData()
    }
}
 // MARK: - Helpers
private extension HomeViewController {
    
    func click() {
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(kennyClicked))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(kennyClicked))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(kennyClicked))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(kennyClicked))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(kennyClicked))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(kennyClicked))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(kennyClicked))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(kennyClicked))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(kennyClicked))
        
        kenny1.addGestureRecognizer(gestureRecognizer1)
        kenny2.addGestureRecognizer(gestureRecognizer2)
        kenny3.addGestureRecognizer(gestureRecognizer3)
        kenny4.addGestureRecognizer(gestureRecognizer4)
        kenny5.addGestureRecognizer(gestureRecognizer5)
        kenny6.addGestureRecognizer(gestureRecognizer6)
        kenny7.addGestureRecognizer(gestureRecognizer7)
        kenny8.addGestureRecognizer(gestureRecognizer8)
        kenny9.addGestureRecognizer(gestureRecognizer9)
        kennyImagesArray = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
    }
    
    @objc func kennyClicked() {
        score += 1
        scoreLabel.text = "Score:\(score)"
    }
    
    func timers() {
        counter = 20
        timeLabel.text = "Time:\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideKennyTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
    }
    
    @objc func hideKenny() {
        for kenny in kennyImagesArray {
            kenny.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(kennyImagesArray.count - 1)))
        kennyImagesArray[random].isHidden = false
    }
    
    @objc func countDown() {
        counter -= 1
        timeLabel.text = "Time:\(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hideKennyTimer.invalidate()
            for kenny in kennyImagesArray {
                kenny.isHidden = true
            }
            if score > highScore {
                highScore = score
                self.highscoreLabel.text = "Highscore: \(highScore)"
                UserDefaults.standard.set(highScore, forKey: "highScore")
            }
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            let replay = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score:\(self.score)"
                self.counter = 20
                self.timeLabel.text = "Time:\(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideKennyTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
            }
            alert.addAction(okButton)
            alert.addAction(replay)
            self.present(alert, animated: true)
        }
    }
    
    func getData() {
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        if storedHighScore == nil {
            self.highScore = 0
            self.highscoreLabel.text = "Highscore: \(highScore)"
        } else {
            if let newScore = storedHighScore as? Int {
                highScore = newScore
                self.highscoreLabel.text = "Highscore: \(highScore)"
            }
        }
    }
}
