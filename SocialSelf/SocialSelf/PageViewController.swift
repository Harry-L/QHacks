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

        dataSource = self
        
    }
    
    func initializeViewControllers() {
        for (account, id) in accounts {
            var view: WebViewController
            switch account {
            case "facebook":
                view = facebook(id)
            case "instagram":
                view = instagram(id)
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
    
    func facebook(id: String) -> WebViewController {
        let viewController = WebViewController()
        
        
        viewController.url = NSURL(string: "https://www.facebook.com/addfriend.php?id=" + id)!
        viewController.webView.loadRequest(NSURLRequest(URL: viewController.url))
        viewController.webView.allowsBackForwardNavigationGestures = false
        
        return viewController
    }
    
    func instagram(id: String) -> WebViewController {
        let viewController = WebViewController()
        
        viewController.url = NSURL(string: "https://wwww.instagram.com/user?username=" + id)!
        viewController.webView.loadRequest(NSURLRequest(URL: viewController.url))
        viewController.webView.allowsBackForwardNavigationGestures = false
            
        return viewController
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
