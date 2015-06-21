//
//  CollectionViewControllerFactory.swift
//  Pager
//
//  Created by Furuyama Takeshi on 2015/06/21.
//  Copyright © 2015年 Furuyama Takeshi. All rights reserved.
//

import UIKit

class CollectionViewControllerFactory {
    
    static func create() -> CollectionViewController? {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake(20.0, 20.0)
        flowLayout.minimumLineSpacing = 5.0
        flowLayout.minimumInteritemSpacing = 5.0
        flowLayout.scrollDirection = .Horizontal
        return CollectionViewController(collectionViewLayout: flowLayout)
    }
    
}