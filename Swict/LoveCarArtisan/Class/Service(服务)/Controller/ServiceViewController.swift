//
//  ServiceViewController.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 apple. All rights reserved.
//

import VTMagic

class ServiceViewController: VTMagicController {

    
    var serviceClassArray:NSMutableArray?

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let path = Bundle.main.path(forResource: "serviceClass", ofType: "json")
        let data = NSData.init(contentsOfFile: path!)
        let json:NSDictionary = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
        serviceClassArray = ServiceClassModel.mj_objectArray(withKeyValuesArray: json["data"])
        

        // 布局视图
        serviceLayoutView()
        // 布局视图
        serviceLayoutNAv()
    }
    
    // MARK: 按钮点击方法
    // seg
    func navSegmentedAction(segmented :UISegmentedControl) {
        switch segmented.selectedSegmentIndex {
        case 0:
            
            break
        case 1:
            
            break
        default:
            break
        }
    }
    
    // MARK: 布局NAV
    func serviceLayoutNAv() {
        let segmentedControl: UISegmentedControl = UISegmentedControl(items: ["在售", "下架"])
        segmentedControl.frame = CGRect(x: 0, y: 0, width: 150, height: 28)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = WhiteColor
        segmentedControl.addTarget(self, action: #selector(navSegmentedAction(segmented:)), for: UIControlEvents.valueChanged)
        navigationItem.titleView = segmentedControl
    }
    // MARK: 布局视图
    func serviceLayoutView() {
        magicView.navigationColor = UIColor.white;
        magicView.sliderColor = ThemeColor;
        magicView.layoutStyle = VTLayoutStyle.default;
        magicView.switchStyle = VTSwitchStyle.default;
        magicView.navigationHeight = 40;
        magicView.dataSource = self;
        magicView.delegate = self;
        magicView.reloadData();
    }
    // MARK: magicView代理方法
    override func menuTitles(for magicView: VTMagicView) -> [String] {
        let titleArray : NSMutableArray = NSMutableArray()
        for serviceClass in serviceClassArray! {
            titleArray.add((serviceClass as! ServiceClassModel).name!)
        }
        
        return titleArray as! [String]
    }
    
    override func magicView(_ magicView: VTMagicView, menuItemAt itemIndex: UInt) -> UIButton {
        let itemIdentifier = "itemIdentifier"
        var menuItem = magicView.dequeueReusableItem(withIdentifier: itemIdentifier)
        if menuItem == nil {
            menuItem = UIButton(type: UIButtonType.custom)
            menuItem?.setTitleColor(UIColor.black, for: UIControlState.normal)
            menuItem?.titleLabel?.font = FourteenFont
            menuItem?.setTitleColor(ThemeColor, for: UIControlState.selected)
        }
        return menuItem!;
    }
    
    override func magicView(_ magicView: VTMagicView, viewControllerAtPage pageIndex: UInt) -> UIViewController {
        let recomId = "serviceVC"
        var commodityShowStyleVC = magicView.dequeueReusablePage(withIdentifier: recomId)
        if commodityShowStyleVC == nil {
            commodityShowStyleVC = GoodsViewController()
        }
        return commodityShowStyleVC!;
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}





