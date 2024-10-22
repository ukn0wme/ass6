//
//  ViewController.swift
//  ass6
//
//  Created by Daniyal Nurgazinov on 23.10.2024.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var timer: Timer?
    var totalTime: Int = 0
    var secondsPassed: Int = 0
    var audioPlayer: AVAudioPlayer?

    
    @IBOutlet weak var softButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    @IBOutlet weak var softEggImageView: UIImageView!
    @IBOutlet weak var mediumEggImageView: UIImageView!
    @IBOutlet weak var hardEggImageView: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var timeLabel: UILabel!  // Optional for showing time left

    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.0  // Initialize the progress bar
        softEggImageView.image = UIImage(named: "soft-egg")
        mediumEggImageView.image = UIImage(named: "medium-egg")
        hardEggImageView.image = UIImage(named: "hard-egg")
        softButton.setTitle("Soft", for: .normal)
        mediumButton.setTitle("Medium", for: .normal)
        hardButton.setTitle("Hard", for: .normal)
    }

    @IBAction func eggSelected(_ sender: UIButton) {
        print("Button title: \(sender.title(for: .normal) ?? "No title")")
        // Safely unwrap the button title
        guard let hardness = sender.currentTitle else {
            print("Error: Button has no title")
            return
        }
        
        // Stop any existing timer
        timer?.invalidate()

        // Reset progress and seconds passed
        secondsPassed = 0
        progressBar.progress = 0.0

        // Set the total time based on the egg type
        switch hardness {
        case "Soft":
            totalTime = 5 * 60  // 5 minutes
        case "Medium":
            totalTime = 7 * 60  // 7 minutes
        case "Hard":
            totalTime = 12 * 60  // 12 minutes
        default:
            totalTime = 0
        }

        // Start the timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)  // Update the progress bar

            // Optional: Update a label to show remaining time
            let timeRemaining = totalTime - secondsPassed
            timeLabel.text = "\(timeRemaining / 60) min \(timeRemaining % 60) sec"

        } else {
            timer?.invalidate()  // Stop the timer

            // Play alarm sound when the timer finishes
            playSound()

            // Optional: Update UI to show that the time is up
            timeLabel.text = "Done!"
        }
    }

    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "wav")
        audioPlayer = try? AVAudioPlayer(contentsOf: url!)
        audioPlayer?.play()
    }
}


