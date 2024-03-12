//
//  ViewController.swift
//  AimForThat
//
//  Created by Andres David Cardenas Ramirez on 12/03/24.
//

import UIKit

class GameViewController: UIViewController {
    
    var currentValue: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func ButtonPrueba(_ sender: Any) {
        
        let alertController: UIAlertController = UIAlertController(title: "Pulsaste el boton", message: "Que quieres", preferredStyle: .alert)
        
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        self.currentValue = lroundf(sender.value)
        print("El valor del slider es \(self.currentValue)")
    }
}

