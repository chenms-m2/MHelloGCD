//
//  GCDDemo.swift
//  MHelloGCD
//
//  Created by chenms on 16/10/18.
//  Copyright © 2016年 chenms.m2. All rights reserved.
//

import UIKit

class GCDDemo: NSObject {
    static let sharedInstance = GCDDemo()
    
    // group: async
    // 多用于不继续派发的异步任务（典型地是无完成时回调），这样async块可以包含整个任务。（可以和后文的group: enter/leave示例对比）
    func group() {
        let queue = DispatchQueue(label: "queue", attributes: DispatchQueue.Attributes.concurrent)
        let group = DispatchGroup()
        queue.async(group: group, execute: {
            self.longtimeWork()
            print("0")
        })
        queue.async(group: group, execute: {
            self.longtimeWork()
            print("1")
        })
        queue.async(group: group, execute: {
            self.longtimeWork()
            print("2")
        })
        
        group.notify(queue: DispatchQueue.main) {
            print("group finish.")
        }
    }
    
    // group: enter/leave
    // 多用于异步任务体重还要继续派发。例如任务是第三方的，我方只是传入回调，第三方任务执行完毕，可能还要换个队列异步执行回调，那么，group.enter()在第三方任务启动前调用，group.leave()在回调完成后调用，才能包含整个任务。
    // 注意：并非async只和notify搭配，同理，并非enter/leave只和wait搭配，此处这么搭配只是把这些语句都展示出来，开发时根据场景搭配。
    func groupEnter() {
        let queue = DispatchQueue(label: "queue", attributes: DispatchQueue.Attributes.concurrent)
        let group = DispatchGroup()
        
        group.enter()
        queue.async(group: group, execute: {
            self.longtimeWork()
            print("0")
            group.leave()
        })
        
        group.enter()
        queue.async(group: group, execute: {
            self.longtimeWork()
            print("1")
            group.leave()
        })
        
        group.enter()
        queue.async(group: group, execute: {
            self.longtimeWork()
            print("2")
            group.leave()
        })
        
        group.wait()
        print("group finish.")
    }
    
    // MARK: - long time work
    private func longtimeWork() {
        var sum = 0
        for _ in 0 ..< 1000000 {
            sum += 1
        }
    }
}
