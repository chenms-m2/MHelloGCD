//
//  GCDDemoOC.m
//  MHelloGCD
//
//  Created by chenms on 16/10/18.
//  Copyright © 2016年 chenms.m2. All rights reserved.
//

#import "GCDDemoOC.h"

@implementation GCDDemoOC

+ (instancetype)sharedInstance {
    static GCDDemoOC *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    
    return sharedInstance;
}

- (void)group {
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        [self longtimeWork];
        NSLog(@"0");
    });
    
    dispatch_group_async(group, queue, ^{
        [self longtimeWork];
        NSLog(@"1");
    });
    
    dispatch_group_async(group, queue, ^{
        [self longtimeWork];
        NSLog(@"2");
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"group finish.");
    });
}

- (void)groupEnter {
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [self longtimeWork];
        NSLog(@"0");
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [self longtimeWork];
        NSLog(@"1");
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [self longtimeWork];
        NSLog(@"2");
        dispatch_group_leave(group);
    });
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"group finish.");
}

// long time work
- (void)longtimeWork {
    NSInteger sum = 0;
    for (NSInteger i = 0; i < 1000000; i++) {
        sum += 1;
    }
}

@end
