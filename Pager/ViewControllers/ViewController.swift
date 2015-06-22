//
//  ViewController.swift
//  Pager
//
//  Created by Furuyama Takeshi on 2015/06/19.
//  Copyright © 2015年 Furuyama Takeshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, CollectionViewControllerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var viewControllers = PageManager.sharedManager.viewControllers
    var pages = ["hoge", "piyo", "fuga", "hogehoge"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configure()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configure() {
        
        let numberPages = self.pages.count
        for var i = 0; i < numberPages; i++ {
            self.viewControllers.append(nil)
        }
        // scrollView
        self.scrollView.pagingEnabled = true
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * CGFloat(numberPages), CGRectGetHeight(self.scrollView.frame));
        self.scrollView.showsHorizontalScrollIndicator = true
        self.scrollView.showsVerticalScrollIndicator = true
        self.scrollView.scrollsToTop = true
        self.scrollView.backgroundColor = UIColor.grayColor()
        
        // pageControll
        self.pageControl.numberOfPages = numberPages
        self.pageControl.currentPage = 0
        self.pageControl.hidden = false
        self.loadScrollViewWithPage(0)
    
    }

    private func loadScrollViewWithPage(page: Int) {
        
        if (page >= self.pages.count) {
            return
        }

        var controller = self.viewControllers[page]
        if (controller == nil) {
            if let collectionViewController = CollectionViewControllerFactory.create() {
                collectionViewController.identifier = self.pages[page]
                collectionViewController.pageNumber = page
                collectionViewController.delegate = self
                controller = NavigationController(rootViewController:collectionViewController)
                self.viewControllers[page] = controller
            }
        }
        
        // add the controller's view to the scroll view
        if controller!.view.superview == nil {
            var frame = self.scrollView.frame
            frame.origin.x = CGRectGetWidth(frame) * CGFloat(page)
            frame.origin.y = 0
            controller!.view.frame = frame
            
            self.addChildViewController(controller!)
            self.scrollView.addSubview(controller!.view)
            controller!.didMoveToParentViewController(self)
        }
        
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageWidth = CGRectGetWidth(self.scrollView.frame)
        let page = Int(floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth)) + 1
        self.pageControl.currentPage = page
        let min = (page-1<0) ? 0 : page-1
        self.loadScrollViewWithPage(min)
        self.loadScrollViewWithPage(page)
        self.loadScrollViewWithPage(page+1)
    }
    
    // MARK: CollectionViewControllerDelegate
    func collectionViewAddPage(collectionview: UICollectionView) {
        //
        addPage()
    }
    
    private func addPage() {
        var controller: NavigationController?
        let page = self.viewControllers.count
        
        if let collectionViewController = CollectionViewControllerFactory.create() {
            collectionViewController.identifier = "add+ \(page)"
            collectionViewController.pageNumber = page
            collectionViewController.delegate = self
            controller = NavigationController(rootViewController:collectionViewController)
            self.viewControllers.append(controller)
        }
    
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * CGFloat(page+1), CGRectGetHeight(self.scrollView.frame))
        
        if controller!.view.superview == nil {
            var frame = self.scrollView.frame
            frame.origin.x = CGRectGetWidth(frame) * CGFloat(page)
            frame.origin.y = 0
            controller!.view.frame = frame
            self.addChildViewController(controller!)
            self.scrollView.addSubview(controller!.view)
            controller!.didMoveToParentViewController(self)
        }
    }
}

