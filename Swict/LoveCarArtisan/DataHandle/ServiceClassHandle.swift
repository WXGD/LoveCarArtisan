//
//  ServiceClassHandle.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/5/15.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

//全局的常量
var sharedInstance : ServiceClassHandle?

class ServiceClassHandle: NSObject {
    
    var serviceClassArray : NSMutableArray?
    
    class var sharedInstance : ServiceClassHandle {
        

               
        
        return self.sharedInstance
    }
    
    
    
}






