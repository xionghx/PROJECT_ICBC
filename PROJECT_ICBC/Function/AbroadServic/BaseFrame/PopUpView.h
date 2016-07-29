//
//  PopUpView.h
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/23/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopUpView : UIView
@property(nonatomic,strong)UIView *contentView;

@property(nonatomic,strong)NSString *title;

-(void)popupSelf;
-(void)popupBuyingWindow;
-(void)addLabelInView:(PopUpView *)aView
          withContent:(NSString *)string;
-(void)addSaveButtonWithTarget:(id)target
                        Action:(SEL)action
                        inView:(PopUpView *)aView;
-(void)addDealButtonWithTarget:(id)target
                        Action:(SEL)action
                        inView:(PopUpView *)aView;


@end
