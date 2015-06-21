//
//  PageManager.swift
//  Pager
//
//  Created by Furuyama Takeshi on 2015/06/21.
//  Copyright © 2015年 Furuyama Takeshi. All rights reserved.
//

import Foundation

class PageManager {
    
    var pages = [String?]()
    var viewControllers = [NavigationController?]()
    
    static let sharedManager = PageManager()
    
    func addPage(controller: NavigationController) {
        self.viewControllers.append(controller)
        self.pages.append(controller.navigationItem.title)
    }
}