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

- (void)barrier {
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        [self longtimeWork];
        NSLog(@"Before read 0");
    });
    
    dispatch_async(queue, ^{
        [self longtimeWork];
        NSLog(@"Before read 1");
    });
    
    dispatch_async(queue, ^{
        [self longtimeWork];
        NSLog(@"Before read 2");
    });
    
    dispatch_barrier_async(queue, ^{
        [self longtimeWork];
        NSLog(@"barrier write");
    });
    
    dispatch_async(queue, ^{
        [self longtimeWork];
        NSLog(@"After read 0");
    });
    
    dispatch_async(queue, ^{
        [self longtimeWork];
        NSLog(@"After read 1");
    });
}

- (void)apply {
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    NSArray *array = @[@0, @1, @2, @3, @4, @5, @6];
    dispatch_apply(array.count, queue, ^(size_t index) {
        [self longtimeWork];
        NSLog(@"%@", array[index]);
    });
}

- (void)semaphore {
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    NSMutableArray *array = [NSMutableArray array];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    for (NSInteger i = 0; i < 1000; i++) {
        dispatch_async(queue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            [array addObject:@(i)];
            dispatch_semaphore_signal(semaphore);
        });
    }
}

// long time work
- (void)longtimeWork {
    NSInteger sum = 0;
    for (NSInteger i = 0; i < 1000000; i++) {
        sum += 1;
    }
}

@end
