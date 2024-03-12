//
//  ViewController.swift
//  AimForThat
//
//  Created by Andres David Cardenas Ramirez on 12/03/24.
//

import UIKit

class GameViewController: UIViewController {
    
    var currentValue: Int = 0
    var targetValue = 0
    
    //var difference = 0
    //var points = 0
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var labelScore: UILabel!
    @IBOutlet var labelPuntos: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startNewRound()
        updateLabels()
        //updatePoints()
        // Do any additional setup after loading the view.
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
        
        var difference: Int = abs(self.currentValue-self.targetValue)
        
        let points = (difference > 0) ? 100 - difference : 1000 // Operador ternario
        
        let message = """
            Has  marcado \(points) puntos
        """
        
        let alertController: UIAlertController = UIAlertController(title: "Pulsaste el boton", message: message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        startNewRound()
        updateLabels()
        //updatePoints()

    }
    
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        self.currentValue = lroundf(sender.value)
        print("El valor del slider es \(self.currentValue)")
        
    }
    
    func startNewRound() {
        self.targetValue = 1 + Int(arc4random_uniform(100))
        self.currentValue = 50
        self.slider.value = Float(self.currentValue)
    }
    
    func updateLabels() {
        self.labelScore.text = "\(self.targetValue)"
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

