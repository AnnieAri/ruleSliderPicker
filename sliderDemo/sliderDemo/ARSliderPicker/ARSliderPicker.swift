//
//  ARSliderPicker.swift
//  sliderDemo
//
//  Created by Ari on 2017/6/30.
//  Copyright © 2017年 com.Ari.swift. All rights reserved.
//

import UIKit

struct ARSliderPickerConfiguration {
    var maxValue: Int
    var minValue: Int
    var unitValue: Int
    
    init(_ minValue:Int,_ maxValue: Int,_ unitValue: Int){
        self.maxValue = maxValue
        self.minValue = minValue
        self.unitValue = unitValue
    }
}

class ARSliderPicker: UIView {
    
    var selectedNum: ((Int)->())? {
        didSet{
            scrollViewDidScroll(scrollView)
        }
    }
    
    
    fileprivate var config: ARSliderPickerConfiguration
    fileprivate var count: Int!
    fileprivate var imageWidth: CGFloat{
        return 100
    }
    fileprivate var indicator: UIImageView = UIImageView(image: UIImage(named: "btn_shikejiantou"))
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
        indicator.frame = CGRect(x: 0, y: 10, width: 10, height: 10)
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
        
        let contentSizeWidth = imageWidth * CGFloat(count) + frame.size.width
        scrollView.contentSize = CGSize(width: contentSizeWidth, height: ar_height)
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        //        scrollView.bounces = false
        for i in 0..<count+1{
            //设置标尺图片
            setImage(i)
            //设置标尺下的文字
            setLabel(i)
        }
        //设置刻度尺的线条
        let line = UIImageView(frame: CGRect(x: -ar_width, y: 15, width: (CGFloat(count) + 2)*ar_width , height: 1.5))
        line.image = #imageLiteral(resourceName: "img_shike_hengxian")
        scrollView.addSubview(line)
        
    }
    fileprivate func setImage (_ i: Int){
        let start = ar_width / 2 + CGFloat(i)*imageWidth - 2 * (imageWidth/5)
        for j in 0..<5{
            let w: CGFloat = 1
            let h: CGFloat = j != 2 ? 7.5 : 15
            let v = UIImageView(frame: CGRect(x: start + CGFloat(j)*(imageWidth/5) - 0.5, y: 15, width: w, height: h))
            if j == 2 {
                v.image = #imageLiteral(resourceName: "img_shike_suxian_1")
            }else{
                v.image = #imageLiteral(resourceName: "img_shike_suxian_2")
            }
            scrollView.addSubview(v)
            
        }
    }
    
    fileprivate func setLabel (_ i: Int){
        let label = UILabel(frame: CGRect(x: ar_width/2+imageWidth * CGFloat(i) - imageWidth/2, y: 38, width: imageWidth, height: 10))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "\(config.minValue + i * config.unitValue)"
        scrollView.addSubview(label)
    }
    
    
}
extension ARSliderPicker: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var result = ((scrollView.contentOffset.x + imageWidth/10)/imageWidth) * CGFloat(config.unitValue) + CGFloat(config.minValue)
        
        //控制选址范围
        if  result < CGFloat(config.minValue)  {
            result = CGFloat(config.minValue)
        } else if result > CGFloat(config.maxValue) {
            result = CGFloat(config.maxValue)
        }
        
        selectedNum?(Int(result))
    }
    
    
}
