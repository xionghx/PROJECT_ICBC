//
//  ServiceProgress.m
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/21/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import "ServiceProgress.h"

@implementation ServiceProgress
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleLabel.text = @"ServiceProgress";
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

@end
