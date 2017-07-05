//
//  ViewController.swift
//  sliderDemo
//
//  Created by Ari on 2017/6/30.
//  Copyright © 2017年 com.Ari.swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let conf = ARSliderPickerConfiguration(0,100,5)
        let pickerView = ARSliderPicker(frame: CGRect(x: 20, y: 100, width: 300, height: 100), config: conf)
        pickerView.backgroundColor = .black
        view.addSubview(pickerView)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        label.textAlignment = .center
        label.textColor = .black
        label.center = view.center
        view.addSubview(label)
        
        pickerView.selectedNum = {(num: Int) in
            label.text = "\(num)"
        }
    }

   


}

