//
//  CollectionViewController.swift
//  Pager
//
//  Created by Furuyama Takeshi on 2015/06/19.
//  Copyright © 2015年 Furuyama Takeshi. All rights reserved.
//

import UIKit

protocol CollectionViewControllerDelegate {
    
    func collectionViewAddPage(collectionview: UICollectionView)
}

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    var pageNumber:Int?
    var identifier: String?
    var delegate: CollectionViewControllerDelegate?
    
    var dataSource = ["a", "b", "c", "d", "f", "g", "h", "i", "j", "k", "l", "add"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.identifier

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.registerNib(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCell")
        self.collectionView!.registerNib(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyCell")
        self.collectionView!.registerNib(UINib(nibName: "AddCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddCell")
        
        // Do any additional setup after loading the view.
        self.configureBackgroundColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configureBackgroundColor() {
        let colorNumber = self.pageNumber! % 3
        
        let colors = [UIColor.lightGrayColor(), UIColor.lightTextColor(), UIColor.blackColor()]
        self.collectionView?.backgroundColor = colors[colorNumber]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.dataSource.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell: UICollectionViewCell?
        
        if indexPath.row == self.dataSource.count - 1 {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("AddCell", forIndexPath: indexPath) as? AddCollectionViewCell
            return cell!
        } else {
            if indexPath.row%2 == 0 {
                var customCell: CustomCollectionViewCell?
                customCell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomCell", forIndexPath: indexPath) as? CustomCollectionViewCell
                customCell?.titleLabel.text = "\(indexPath.row)"
                cell?.backgroundColor = UIColor.whiteColor()
                
                return customCell!
            } else {
                
                cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyCell", forIndexPath: indexPath) as? MyCollectionViewCell
                return cell!
            }
        }
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //
        if indexPath.row == self.dataSource.count - 1 {
            self.delegate?.collectionViewAddPage(collectionView)
        }
    }
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(108.0, 108.0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 12.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(20.0, 20.0, 5.0, 20.0)
    }
    
}
