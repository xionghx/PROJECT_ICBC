//
//  PickedList.m
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/21/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import "PickedList.h"

@implementation PickedList

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleLabel.text = @"PickedList";
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
