//
//  Tools.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/5/16.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit


// MARK:系统
// 获取系统版本
public let IOS_VERSION: Double = Double(UIDevice.current.systemVersion)!
public let IOS_VERSION_STR: String = UIDevice.current.systemVersion
// app信息字典
public let APP_INFO: Dictionary = Bundle.main.infoDictionary!
// 获取软件版本号 version
public let VERSION: String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
// 获取内部软件版本号 build
public let BUILD: String = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
// UDID
public let UDID: String = (UIDevice.current.identifierForVendor?.uuidString)!


// MARK:尺寸
/** nav高度 */
public let NavigationH: CGFloat = 64
/** 窗口宽度 */
public let AppWidth: CGFloat = UIScreen.main.bounds.size.width
/** 窗口高度 */
public let AppHeight: CGFloat = UIScreen.main.bounds.size.height
/** 窗口尺寸 */
public let MainBounds: CGRect = UIScreen.main.bounds
// 屏幕设计高度比例
public let HScale: Double = Double(UIScreen.main.bounds.size.height / 640)
// 屏幕设计宽度度比例
public let WScale: Double = Double(UIScreen.main.bounds.size.width / 360)



// MARK:字体大小
/** 10号字 */
public let TenFont: UIFont = UIFont.systemFont(ofSize: 10)
/** 11号字 */
public let ElevenFont: UIFont = UIFont.systemFont(ofSize: 11)
/** 12号字 */
public let TwelveFont: UIFont = UIFont.systemFont(ofSize: 12)
/** 13号字 */
public let ThirteenFont: UIFont = UIFont.systemFont(ofSize: 13)
/** 14号字 */
public let FourteenFont: UIFont = UIFont.systemFont(ofSize: 14)
/** 14号加粗字 */
public let FourteenFontBold: UIFont = UIFont.boldSystemFont(ofSize: 14)
/** 15号字 */
public let FifteenFont: UIFont = UIFont.systemFont(ofSize: 15)
/** 15号加粗字 */
public let FifteenFontBold: UIFont = UIFont.boldSystemFont(ofSize: 15)
/** 16号字 */
public let SixteenFont: UIFont = UIFont.systemFont(ofSize: 16)
/** 16号加粗字 */
public let SixteenFontBold: UIFont = UIFont.boldSystemFont(ofSize: 16)
/** 17号字 */
public let SeventeenFont: UIFont = UIFont.systemFont(ofSize: 17)
/** 18号字 */
public let EighteenFont: UIFont = UIFont.systemFont(ofSize: 18)
/** 18号加粗字 */
public let EighteenFontBold: UIFont = UIFont.boldSystemFont(ofSize: 18)
/** 19号字 */
public let NineteenFont: UIFont = UIFont.systemFont(ofSize: 19)
/** 20号字 */
public let TwentyFont: UIFont = UIFont.systemFont(ofSize: 20)
/** 21号字 */
public let TwentyOneFont: UIFont = UIFont.systemFont(ofSize: 21)
/** 22号字 */
public let TwentyTwoFont: UIFont = UIFont.systemFont(ofSize: 22)
/** 23号字 */
public let TwentyThreeFont: UIFont = UIFont.systemFont(ofSize: 23)
/** 24号字 */
public let TwentyFourFont: UIFont = UIFont.systemFont(ofSize: 24)
/** 24号字加粗字 */
public let TwentyFourFontBold: UIFont = UIFont.boldSystemFont(ofSize: 24)
/** 30号字 */
public let ThirtyFont: UIFont = UIFont.systemFont(ofSize: 30)
/** 36号字 */
public let ThirtySixFont: UIFont = UIFont.systemFont(ofSize: 36)
/** 40号字 */
public let FortyFont: UIFont = UIFont.systemFont(ofSize: 40)
/** 45号字 */
public let FortyFiveFont: UIFont = UIFont.systemFont(ofSize: 45)

class Tools: UIView {

}
