//
//  ARSliderPicker.swift
//  sliderDemo
//
//  Created by Ari on 2017/6/30.
//  Copyright © 2017年 com.Ari.swift. All rights reserved.
//

import UIKit

struct ARSliderPickerConfiguration {
    var maxValue: Int = 100
    var minValue: Int = 0
    var unitValue: Int = 5
    
    init(_ minValue:Int,_ maxValue: Int,_ unitValue: Int){
        self.maxValue = maxValue
        self.minValue = minValue
        self.unitValue = unitValue
    }
    init(){}
}

class ARSliderPicker: UIView {
    
    var selectedNum: ((Int)->())? {
        didSet{
            scrollViewDidScroll(scrollView)
        }
    }
    
    
    fileprivate var config: ARSliderPickerConfiguration
    fileprivate var count: Int!
    fileprivate let image = UIImage(named: "rule")!
    
    fileprivate var indicator: UIImageView = UIImageView(image: UIImage(named: "smartFit_icon"))
    fileprivate var scrollView: UIScrollView = UIScrollView()
    init(frame: CGRect, config:ARSliderPickerConfiguration) {
        self.config = config
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        indicator.frame = CGRect(x: 0, y: 10, width: 20, height: 20)
        indicator.center = CGPoint(x: bounds.size.width / 2, y: 10)
        scrollView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
    }
    
}
extension ARSliderPicker {
    fileprivate func setupUI (){
        //计算单位标尺个数
        count = (config.maxValue - config.minValue) / config.unitValue
        
        setupScrollView()
        addSubview(scrollView)
        
        addSubview(indicator)
    }
    
    fileprivate func setupScrollView (){
        
        let contentSizeWidth = image.size.width * CGFloat(count) + frame.size.width
        scrollView.contentSize = CGSize(width: contentSizeWidth, height: ar_height)
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.bounces = false
        for i in 0..<count{
             //设置标尺图片
            setImage(i)
            //设置标尺下的文字
            setLabel(i)
        }
        //刻度数字比图片多一个
        setLabel(count)
        //设置刻度尺的线条
        let line = UIView(frame: CGRect(x: -ar_width, y: 10, width: (CGFloat(count) + 2)*ar_width , height: 1.5))
        line.backgroundColor = .gray
        scrollView.addSubview(line)
        
    }
    fileprivate func setImage (_ i: Int){
        
       
        let ruleImageView = UIImageView(image: image)
        ruleImageView.frame = CGRect(x: ar_width / 2 + CGFloat(i)*image.size.width, y: 10, width: image.size.width, height: 20)
        ruleImageView.tag = 100+i
        if i==count-1 {
            ruleImageView.image = UIImage(named: "ruleEnd")!
        }
        scrollView.addSubview(ruleImageView)
    }
    
    fileprivate func setLabel (_ i: Int){
        let image = UIImage(named: "rule")!
        let label = UILabel(frame: CGRect(x: ar_width/2+image.size.width * CGFloat(i) - image.size.width/2, y: 33, width: image.size.width, height: 10))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "\(config.minValue + i * config.unitValue)"
        scrollView.addSubview(label)
    }
    
    
}
extension ARSliderPicker: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var result = ((scrollView.contentOffset.x)/image.size.width) * CGFloat(config.unitValue) + CGFloat(config.minValue)
        
        //控制选址范围
        if  result < CGFloat(config.minValue)  {
            result = CGFloat(config.minValue)
        } else if result > CGFloat(config.maxValue) {
            result = CGFloat(config.maxValue)
        }
        
        selectedNum?(Int(result))
    }
    
    
}
