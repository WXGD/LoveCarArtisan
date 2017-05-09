//
//  ServiceViewController.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 apple. All rights reserved.
//

import VTMagic

class ServiceViewController: VTMagicController {

    var array:NSArray = ["aa", "bb", "cc", "dd", "ee", "ff", "gg", "hh"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 布局视图
        serviceLayoutView()
    }
    
    
    // MARK: 布局视图
    func serviceLayoutView() {
        
        
        magicView.navigationColor = UIColor.white;
        magicView.sliderColor = UIColor.red;
        magicView.layoutStyle = VTLayoutStyle.default;
        magicView.switchStyle = VTSwitchStyle.default;
        magicView.navigationHeight = 40;
        magicView.dataSource = self;
        magicView.delegate = self;
        magicView.reloadData();
    }
    // MARK: magicView代理方法
    override func menuTitles(for magicView: VTMagicView) -> [String] {
        return array as! [String]
    }
    
    override func magicView(_ magicView: VTMagicView, menuItemAt itemIndex: UInt) -> UIButton {

        let menuItem: UIButton = UIButton(type: UIButtonType.custom)
        menuItem.titleLabel?.textColor = UIColor.black
        menuItem.setTitle("aa", for: UIControlState.normal)
        
        return menuItem;
    }
    
    override func magicView(_ magicView: VTMagicView, viewControllerAtPage pageIndex: UInt) -> UIViewController {
        let goodsShowVC: GoodsShowViewController = GoodsShowViewController()
        return goodsShowVC;
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}





