//
//  RootViewController.h
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/21/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol loginoutdelegate <NSObject>
-(void)logout;
@end

@interface RootViewController : UIViewController
@property(nonatomic,assign)id<loginoutdelegate> logoutDelegate;

@end
