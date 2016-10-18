//
//  ViewController.swift
//  MHelloGCD
//
//  Created by chenms on 16/10/17.
//  Copyright © 2016年 chenms.m2. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - User event
    
    // group: async
    @IBAction func tapGroup(_ sender: AnyObject) {
        GCDDemo.sharedInstance.group()
        print("tap handle finish.")
    }
    
    @IBAction func tapGroupOC(_ sender: AnyObject) {
        GCDDemoOC.sharedInstance().group()
        print("tap handle finish.")
    }
    
    // group: enter/leave
    @IBAction func tapGroupEnter(_ sender: AnyObject) {
        GCDDemo.sharedInstance.groupEnter()
        print("tap handle finish.")
    }
    @IBAction func tapGroupEnterOC(_ sender: AnyObject) {
        GCDDemoOC.sharedInstance().groupEnter()
        print("tap handle finish.")
    }
    
    
    // barrier
    @IBAction func tapBarrier(_ sender: AnyObject) {
        GCDDemo.sharedInstance.barrier()
        print("tap handle finish.")
    }
    
    @IBAction func tapBarrierOC(_ sender: AnyObject) {
        GCDDemoOC.sharedInstance().barrier()
        print("tap handle finish.")
    }
    
    // apply
    @IBAction func tapApply(_ sender: AnyObject) {
        GCDDemo.sharedInstance.apply()
        print("tap handle finish.")
    }
    
    @IBAction func tapApplyOC(_ sender: AnyObject) {
        GCDDemoOC.sharedInstance().apply()
        print("tap handle finish.")
    }
    
    // semaphore
    @IBAction func tapSemaphore(_ sender: AnyObject) {
        GCDDemo.sharedInstance.semaphore()
        print("tap handle finish.")
    }
    
    @IBAction func tapSemaphoreOC(_ sender: AnyObject) {
        GCDDemoOC.sharedInstance().semaphore()
        print("tap handle finish.")
    }
    
}

