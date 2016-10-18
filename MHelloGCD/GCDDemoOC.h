//
//  GCDDemoOC.h
//  MHelloGCD
//
//  Created by chenms on 16/10/18.
//  Copyright © 2016年 chenms.m2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDDemoOC : NSObject
+ (instancetype)sharedInstance;
- (void)group;
- (void)groupEnter;
@end
