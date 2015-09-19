//
//  StartViewController.swift
//  DragSwitchViewDemo
//
//  Created by Nirvana on 9/18/15.
//  Copyright © 2015 NSNirvana. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var times = 0
        
        //生成并添加背景ScrollView
        let scrollView = UIScrollView(frame: self.view.frame)
        self.view.addSubview(scrollView)
        
        //得到内容View并添加到背景ScrollView上
        let webViewController = storyboard?.instantiateViewControllerWithIdentifier("webViewController") as! ViewController
        let fromView = webViewController.view
        
        assert(fromView != nil)
        
        fromView.frame = self.view.frame
        scrollView.addSubview(fromView)

        //设置背景ScrollView的下拉加载Header
        scrollView.header = MJRefreshNormalHeader(refreshingBlock: { [unowned self]() -> Void in
            
            //生成动画初始位置
            let offScreenUp = CGAffineTransformMakeTranslation(0, -self.view.frame.height-54)
            let offScreenDown = CGAffineTransformMakeTranslation(0, self.view.frame.height)
            
            //生成新View并传入新数据（以颜色为例）
            let toWebViewController = self.storyboard?.instantiateViewControllerWithIdentifier("webViewController") as! ViewController
            let toView = toWebViewController.view
            toView.frame = self.view.frame
            
            //彩蛋 - 五颜六色的toView
            times += 1
            self.dyeToView(toView, times: times)
      
            //将新View放置到屏幕之外并添加到ScrollView上
            toView.transform = offScreenUp
            scrollView.addSubview(toView)
           
            //隐藏Header
            scrollView.header.endRefreshing()

            //动画开始
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                
                //当前View下滑出屏幕，新View滑入屏幕
                fromView.transform = offScreenDown
                fromView.alpha = 0.5
                toView.transform = CGAffineTransformIdentity
                
                }, completion: { (success) -> Void in
                    print("动画执行完成")
            })
          
        })
        
        // Do any additional setup after loading the view.
    }
    
    func dyeToView(toView: UIView, times: Int) {
        
        switch times%5 {
        case 0: toView.backgroundColor = UIColor.orangeColor()
        case 1: toView.backgroundColor = UIColor.yellowColor()
        case 2: toView.backgroundColor = UIColor.greenColor()
        case 3: toView.backgroundColor = UIColor.blueColor()
        case 4: toView.backgroundColor = UIColor.purpleColor()
        default:
            print("% GG")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
