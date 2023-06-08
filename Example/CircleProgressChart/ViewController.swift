//
//  ViewController.swift
//  CircleProgressChart
//
//  Created by 8058951 on 06/01/2023.
//  Copyright (c) 2023 8058951. All rights reserved.
//

import UIKit
import CircleProgressChart

class ViewController: UIViewController {

    @IBOutlet weak var chartView: CircularProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chartView.circleColor = .lightGray
        chartView.progressColor = .orange
        chartView.createCircularPath(percentage: 0.75, radius: 80)
        chartView.hideCenterPercentage = false
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        chartView.percentage = CGFloat(sender.value)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

