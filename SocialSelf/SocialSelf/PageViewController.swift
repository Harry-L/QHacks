//
//  PageViewController.swift
//  SocialSelf
//
//  Created by Harry Liu on 2016-03-05.
//  Copyright © 2016 SocialSelf. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var accounts = [(String, String)]()
    var orderedViewControllers = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        pageStyle()
        
        initColors()

        dataSource = self
        initializeViewControllers()
        setFirstViewController()
        initColors()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController!.navigationBar.barTintColor = UIColor.init(red: 63.0/255.0, green: 63.0/255.0, blue: 63.0/255.0, alpha: 1)
    }
    
    func setFirstViewController() {
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .Forward, animated: true, completion: nil)
        }
    }
    
    func initializeViewControllers() {
        for (account, id) in accounts {
            var view: WebViewController
            switch account {
            case "facebook":
                view = facebook(id)
            case "instagram":
                view = instagram(id)
            case "twitter":
                view = twitter(id)
            case "linkedin":
                view = linkedin(id)
            default:
                view = WebViewController()
            }
            orderedViewControllers.append(view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if orderedViewControllers.indexOf(viewController) == 0 {
            return nil
        }
        else {
            let index = orderedViewControllers.indexOf(viewController)! - 1
            return orderedViewControllers[index]
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if orderedViewControllers.indexOf(viewController) == orderedViewControllers.count - 1 {
            return nil
        }
        else {
            let index = orderedViewControllers.indexOf(viewController)! + 1
            return orderedViewControllers[index]
        }
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            firstViewControllerIndex = orderedViewControllers.indexOf(firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
    
    func initColors() {
        self.view.backgroundColor = UIColor.init(red: 63.0/255.0, green: 63.0/255.0, blue: 63.0/255.0, alpha: 1)
    }
    
    func facebook(id: String) -> WebViewController {
        let viewController = WebViewController()
        
        if let url = NSURL(string: "https://www.facebook.com/addfriend.php?id=" + id) {
            viewController.url = url
        }
        viewController.webView?.loadRequest(NSURLRequest(URL: viewController.url))
        viewController.webView?.allowsBackForwardNavigationGestures = false
        
        return viewController
    }
    
    func instagram(id: String) -> WebViewController {
        let viewController = WebViewController()
        
        if let url = NSURL(string: "https://www.instagram.com/" + id) {
            viewController.url = url
        }
        viewController.webView?.loadRequest(NSURLRequest(URL: viewController.url))
        viewController.webView?.allowsBackForwardNavigationGestures = false
            
        return viewController
    }
    
    func twitter(id: String) -> WebViewController {
        let viewController = WebViewController()
        
        if let url = NSURL(string: "https://www.twitter.com/" + id) {
            viewController.url = url
        }
        viewController.webView?.loadRequest(NSURLRequest(URL: viewController.url))
        viewController.webView?.allowsBackForwardNavigationGestures = false
        
        return viewController
    }
    
    func linkedin(id: String) -> WebViewController {
        let viewController = WebViewController()
        
        if let url = NSURL(string: "https://www.linkedin.com/in/" + id) {
            viewController.url = url
        }
        viewController.webView?.loadRequest(NSURLRequest(URL: viewController.url))
        viewController.webView?.allowsBackForwardNavigationGestures = false
        
        return viewController
    }
    
    func pageStyle() {
        let pageControl = UIPageControl.appearanceWhenContainedInInstancesOfClasses([self.dynamicType])
        
        //pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        //pageControl.pageIndicatorTintColor = UIColor.blackColor()
        pageControl.backgroundColor = UIColor.init(red: 63.0/255.0, green: 63.0/255.0, blue: 63.0/255.0, alpha: 1)
        self.navigationController!.interactivePopGestureRecognizer!.enabled = false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
