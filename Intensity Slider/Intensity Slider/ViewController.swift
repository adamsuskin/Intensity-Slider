//
//  ViewController.swift
//  Intensity Slider
//
//  Created by Adam Suskin on 10/11/15.
//  Copyright © 2015 Adam Suskin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var IntensityView: IntensitySliderView?
    @IBOutlet weak var Slider: UISlider?

    @IBAction func sliderChangedVals() {
        IntensityView!.counter = Slider!.value
        IntensityView!.setNeedsDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

