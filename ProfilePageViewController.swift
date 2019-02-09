//
//  ProfilePageViewController.swift
//  fundemocracy
//
//  Created by Cassandra Stone on 2/9/19.
//  Copyright © 2019 Cassandra Stone. All rights reserved.
//

import Foundation
import UIKit

class ProfilePageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVc(viewController: "SignupViewOne"),
                self.newVc(viewController: "SignupViewTwo"),
                self.newVc(viewController: "SignupViewThree")]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        // This sets up the first view that will show up on our page control
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
    }
    
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }

// MARK: Data source functions.
func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
        return nil
    }
    
    let previousIndex = viewControllerIndex - 1
    
    // User is on the first view controller and swiped left to loop to
    // the last view controller.
    guard previousIndex >= 0 else {
        return orderedViewControllers.last
        // Uncommment the line below, remove the line above if you don't want the page control to loop.
        // return nil
    }
    
    guard orderedViewControllers.count > previousIndex else {
        return nil
    }
    
    return orderedViewControllers[previousIndex]
}

func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
        return nil
    }
    
    let nextIndex = viewControllerIndex + 1
    let orderedViewControllersCount = orderedViewControllers.count
    
    // User is on the last view controller and swiped right to loop to
    // the first view controller.
    guard orderedViewControllersCount != nextIndex else {
        return orderedViewControllers.first
        // Uncommment the line below, remove the line above if you don't want the page control to loop.
        // return nil
    }
    
    guard orderedViewControllersCount > nextIndex else {
        return nil
    }
    
    return orderedViewControllers[nextIndex]
}
}
