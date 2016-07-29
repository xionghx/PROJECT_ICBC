//
//  PolicyAdvicePopUpView.h
//  BOCMarketingSystem
//
//  Created by xionghuaxin on 7/29/16.
//  Copyright © 2016 tangchuanhui. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PolicyAdvicePopUpViewDelegate <NSObject>

-(void)didSelectedRow:(NSString *)string;

@end

@interface PolicyAdvicePopUpView : UIView
@property(nonatomic,assign)id<PolicyAdvicePopUpViewDelegate> delegate;
@end
