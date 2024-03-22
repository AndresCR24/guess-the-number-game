//
//  ViewController.swift
//  AimForThat
//
//  Created by Andres David Cardenas Ramirez on 12/03/24.
//

import UIKit
import QuartzCore

class GameViewController: UIViewController {
    
    var currentValue: Int = 0
    var targetValue = 0
    var score: Int = 0
    var round: Int = 0
    var time: Int = 0
    var timer: Timer?
    //var difference = 0
    //var points = 0
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var labelScore: UILabel!
    @IBOutlet var labelPuntos: UILabel!
    @IBOutlet var labelRound: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSlider()
        //startNewRound()
        resetGameStats()
        updateLabels()
        
        //updatePoints()
        // Do any additional setup after loading the view.
    }
    
    func setupSlider() {
        // Imagenes normales
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackRightImage = UIImage(named: "SliderTrackRight")
        // No se que hace xd
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        // Configuracion para hacer redimencionable las imagenes del slider
        let trackLeftResizable = trackLeftImage?.resizableImage(withCapInsets: insets)
        let trackRightREsizable = trackRightImage?.resizableImage(withCapInsets: insets)

        // Configurando las imagenes importadas en el slider
        self.slider.setThumbImage(thumbImageNormal, for: .normal)
        self.slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        self.slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        self.slider.setMaximumTrackImage(trackRightREsizable, for: .normal)
        
    }
        
    @IBAction func ButtonPrueba(_ sender: Any) {
        /*
        var difference: Int = 0
        if self.currentValue > self.targetValue {
            difference = self.currentValue - self.targetValue
        } else {
            difference = self.targetValue - self.currentValue
        }
        */
        /*
        var difference: Int = self.currentValue - self.targetValue
        
        if difference < 0 {
            difference *= -1
        }
         */
        
        let difference: Int = abs(self.currentValue-self.targetValue)
        
        let points = (difference > 0) ? 100 - difference : 1000 // Operador ternario
        
        self.score += points
        
        let message = """
            Has  marcado \(points) puntos
        """
        let title: String
        
        switch difference {
        case 0:
            title = "Puntuacion perfeta"
        case 1...5:
            title = "Casi perfecto!"
        case 6...12:
            title = "Te ha faltado poco..."
        default:
            title = "Has ido lejos"
        }
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            self.startNewRound() // aqui para llamar el metodo es obligatorio utilizar el self
            self.updateLabels()
        })
        
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        //startNewRound()
        //updateLabels()
        //updatePoints()

    }
    
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        self.currentValue = lroundf(sender.value)
        print("El valor del slider es \(self.currentValue)")
        
    }
    @IBAction func resetGame(_ sender: UIButton) {
        resetGameStats()
        updateLabels()
        
        let transition = CATransition()
        /*
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromTop
         */
        transition.type = CATransitionType.push
        transition.duration = 2
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        
        self.view.layer.add(transition, forKey: nil)
    }
    
    func resetGameStats() {
        self.score = 0
        self.round = 0
        self.time = 60
        
        let currentMaxScore = UserDefaults.standard.integer(forKey: "maxscore")
        
        
        if timer != nil {
            timer?.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        startNewRound()
        
    }
    func startNewRound() {
        self.targetValue = 1 + Int(arc4random_uniform(100))
        self.currentValue = 50
        self.slider.value = Float(self.currentValue)
        self.round += 1
        
        
    }
    
    func updateLabels() {
        self.labelScore.text = "\(self.targetValue)"
        self.labelPuntos.text = "\(self.score)"
        self.labelRound.text = "\(self.round)"
        self.timeLabel.text = "\(self.time)"
    }
    
    @objc func tick() {
        self.time -= 1
        self.timeLabel.text = "\(self.time)"
        if self.time <= 0 {
            let maxscore = UserDefaults.standard.integer(forKey: "maxscore")
            
            if maxscore < self.score {
                UserDefaults.standard.setValue(self.score, forKey: "maxscore")
            }
            self.resetGameStats()
        }
    }
    /*
    func updatePoints() {
        /*
        difference = abs(self.currentValue - self.targetValue)
        
        points = (difference > 0) ? 100 - difference : 1000 // Operador ternario
         */
        //difference = abs(self.currentValue - self.targetValue)
        if self.currentValue > self.targetValue && self.currentValue < self.targetValue{
            difference = abs(self.currentValue - self.targetValue)
        } else {
            difference = 1000
        }
        points = difference
    }
     */

}

