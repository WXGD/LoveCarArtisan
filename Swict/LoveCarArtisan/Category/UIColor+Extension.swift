//
//  UIColor+Extension.swift
//  Text
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

/** 主题色(45,C0,18) */
public let ThemeColor:UIColor = UIColor.colorWith(69, green: 192, blue: 24, alpha: 1)
/** 白色(FF,FF,FF) */
public let WhiteColor:UIColor = UIColor.colorWith(255, green: 255, blue: 255, alpha: 1)
/** 红色(E5,39,35) */
public let RedColor:UIColor = UIColor.colorWith(229, green: 57, blue: 53, alpha: 1)
/** 蓝色(1E,88,E5) */
public let BlueColor:UIColor = UIColor.colorWith(30, green: 136, blue: 229, alpha: 1)
/** 黑色(33,33,33) */
public let BlackColor:UIColor = UIColor.colorWith(51, green: 51, blue: 51, alpha: 1)
/** 灰色1(66,66,66) */
public let GrayH1Color:UIColor = UIColor.colorWith(102, green: 102, blue: 102, alpha: 1)
/** 灰色2(99,99,99) */
public let GrayH2Color:UIColor = UIColor.colorWith(153, green: 153, blue: 153, alpha: 1)
/** 灰色3(C3,C3,C3) */
public let GrayH3Color:UIColor = UIColor.colorWith(195, green: 195, blue: 195, alpha: 1)
/** 灰色4(BB,BB,BB)(按钮不可点击色) */
public let GrayH4Color:UIColor = UIColor.colorWith(187, green: 187, blue: 187, alpha: 1)
/** 灰色5(E5,E5,E5)(分割线颜色) */
public let GrayH5Color:UIColor = UIColor.colorWith(229, green: 229, blue: 229, alpha: 1)
/** 灰色6(EF,EF,EF)(控制器背景颜色) */
public let GrayH6Color:UIColor = UIColor.colorWith(239, green: 239, blue: 239, alpha: 1)
/** 灰色7(F5,F5,F5)(控制器背景颜色) */
public let GrayH7Color:UIColor = UIColor.colorWith(245, green: 245, blue: 245, alpha: 1)
/** 灰色8(FA,FA,FA)(控制器背景颜色) */
public let GrayH8Color:UIColor = UIColor.colorWith(250, green: 250, blue: 250, alpha: 1)


extension UIColor {

    // rgb
    class func colorWith(_ red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor {
        let color = UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
        return color
    }
    /**
     * 从十六进制字符串获取颜色
     *
     * @parameter color:16进制字符串。支持@“#123456”、 @“0X123456”、 @“123456”三种格式
     * @parameter alpha:透明度
     * @return 颜色。color类型
     */
    class func colorWithHex(_ color:String, alpha:CGFloat) -> UIColor {
        //删除字符串中的空格
        var cString: String = color.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        // 判断字符长度大于6
        if (cString.characters.count < 6) {
            return UIColor.clear
        }
        //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
        if cString.hasPrefix("0X") {
            cString = (cString as NSString).substring(from: 2)
        }
        //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        // 判断字符长度不等于6
        if (cString.characters.count != 6) {
            return UIColor.clear
        }
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    /**
     * 从十六进制字符串获取颜色，透明度默认为1
     *
     * @parameter color:16进制字符串。支持@“#123456”、 @“0X123456”、 @“123456”三种格式
     * @return 颜色。color类型
     */
    class func colorWithHex(_ color:String) -> UIColor {
        return self.colorWithHex(color, alpha: 1)
    }
    /**
     * 从十六进制数字获取颜色
     *
     * @parameter color:16进制数字
     * @parameter alpha:透明度
     * @return 颜色。color类型
     */
    class func colorWithHex(hexValue:NSInteger, alpha:CGFloat) -> UIColor {
        return UIColor(red: ((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((hexValue & 0xFF00) >> 8))/255.0, blue: ((CGFloat)(hexValue & 0xFF))/255.0, alpha: alpha)
    }
    /**
     * 从十六进制数字获取颜色，透明度默认为1
     *
     * @parameter color:16进制数字
     * @return 颜色。color类型
     */
    class func colorWithHex(hexValue:NSInteger) -> UIColor {
        return colorWithHex(hexValue: hexValue, alpha: 1)
    }
    /**
     * 把color类型颜色转换成十六进制字符
     *
     * @parameter color:颜色
     * @return 十六进制字符
     */
//    class func hexFromUIColor(color:UIColor) -> String {
//        
//    }
}





