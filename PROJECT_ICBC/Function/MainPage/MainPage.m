//
//  MainPage.m
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/21/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import "MainPage.h"

@implementation MainPage
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        self.titleLabel.text = @"mainPage";
    }
    return self;
}

@end
