//
//  ServiceModuleView.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/5/18.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

// MARK: 定义代理
protocol ServiceModuleDelegate {
    //代理方法
    func moduleBtnDelegate(button: UIButton)
}

class ServiceModuleView: UIView {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        serviceModulelaoutView()
    }
    // MARK: 定义代理
    var delegate : ServiceModuleDelegate?
    
    // MARK: 定义控件
    /** 服务模块数据 */
    var moduleArray: NSMutableArray = NSMutableArray() {
        didSet {
            pageControl.numberOfPages = moduleArray.count
            collectionView?.reloadData()
        }
    }
    /** collection样式 */
    private var flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    /** collection */
    private var collectionView: UICollectionView?
    /** pageControl */
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = GrayH6Color
        pageControl.currentPageIndicatorTintColor = ThemeColor
        return pageControl
    }()
    // MARK: 布局控件
    func serviceModulelaoutView() {
        /** collection样式 */
        flowLayout = UICollectionViewFlowLayout()
        // 设置滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal;
        /** collection */
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        collectionView!.backgroundColor = UIColor.clear;
        collectionView!.delegate = self;
        collectionView!.dataSource = self;
        collectionView!.showsHorizontalScrollIndicator = false;
        collectionView!.isPagingEnabled = true;
        // 注册Item
        collectionView!.register(ModuleCell.self, forCellWithReuseIdentifier:"moduleCell")
        addSubview(collectionView!)
        /** pageControl */
        addSubview(pageControl)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        /** collection */
        collectionView!.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.mas_left);
            make.right.equalTo()(self.mas_right);
            make.top.equalTo()(self.mas_top);
            make.bottom.equalTo()(self.mas_bottom)?.setOffset(-20);
        }
        // 页面控制器
        pageControl.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.equalTo()(self.collectionView!.mas_centerX)
            make.top.equalTo()(self.collectionView!.mas_bottom)
            make.width.equalTo()(100)
            make.height.equalTo()(20)
        }
        /** self高度 */
        mas_makeConstraints { (make:MASConstraintMaker!) in
            make.height.mas_equalTo()(232);
        }
    }
}


extension ServiceModuleView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // 告诉系统一共多少组
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return moduleArray.count
    }
    // 告诉系统每组多少个
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let moduleItem: NSArray = moduleArray.object(at: section) as! NSArray
        return moduleItem.count
    }
    // 告诉系统每个Cell如何显示
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ModuleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "moduleCell", for: indexPath) as! ModuleCell
        let moduleItem: NSArray = moduleArray.object(at: indexPath.section) as! NSArray
        let itemArray: NSArray = moduleItem.object(at: indexPath.row) as! NSArray
        /** cell位置 */
        cell.indexPath = indexPath as NSIndexPath;
        /** 按钮数据 */
        cell.btnArray = itemArray;
        /** 按钮1 */
        cell.btnOne.serviceBtn.addTarget(self, action: #selector(moduleBtnAction(button:)), for: UIControlEvents.touchUpInside)
        /** 按钮2 */
        cell.btnTwo.serviceBtn.addTarget(self, action: #selector(moduleBtnAction(button:)), for: UIControlEvents.touchUpInside)
        /** 按钮3 */
        cell.btnThree.serviceBtn.addTarget(self, action: #selector(moduleBtnAction(button:)), for: UIControlEvents.touchUpInside)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: AppWidth - 32, height: 106)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 16, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 16, height: 0)
    }
    // MARK: 按钮点击方法
    func moduleBtnAction(button: UIButton) {
        self.delegate?.moduleBtnDelegate(button: button)
    }
}


extension ServiceModuleView : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / AppWidth)
    }
}




