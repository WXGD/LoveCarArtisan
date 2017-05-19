//
//  ServiceModuleModel.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/5/19.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class ServiceModuleModel: NSObject {
    /** 模块名称 */
    var name : String?
    /** 模块链接 */
    var nav_url : String?
    /** 模块图片链接 */
    var image_url : String?
    /** webview链接 */
    var web_url : String?
    /** nav_title */
    var nav_title : String?
    /** 判断是否需要拼接登陆者ID (0:不需要，1:需要)*/
    var web_url_id : String?
    
    class func requestServiceModuleSuccess(success: ((_ serviceModuleArray: NSMutableArray) -> Swift.Void)? = nil) {
        let path = Bundle.main.path(forResource: "ServiceModule", ofType: "json")
        let data = NSData.init(contentsOfFile: path!)
        let json:NSDictionary = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
        let serviceModuleArray: NSMutableArray = ServiceModuleModel.mj_objectArray(withKeyValuesArray: json["data"])
        
        
        
        var array1: NSMutableArray = NSMutableArray()
        let array2: NSMutableArray = NSMutableArray()
        for i in 0 ..< serviceModuleArray.count {
            if i % 3 == 0 {
                array1 = NSMutableArray()
                array1.add(serviceModuleArray.object(at: i))
                array2.add(array1)
            }else {
                array1.add(serviceModuleArray.object(at: i))
            }
        }
        
        var array3: NSMutableArray = NSMutableArray()
        let array4: NSMutableArray = NSMutableArray()
        for i in 0 ..< array2.count {
            if i % 2 == 0 {
                array3 = NSMutableArray()
                array3.add(array2.object(at: i))
                array4.add(array3)
            }else {
                array3.add(array2.object(at: i))
            }
        }
        
        if (success != nil) {
            success!(array4)
        }
    }
    
}
