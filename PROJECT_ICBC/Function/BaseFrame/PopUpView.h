//
//  PopUpView.h
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/23/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopUpView : UIView
@property(nonatomic,strong)UIView *backgroudShadowView;
@property(nonatomic,strong)UIButton *cancelButton;
@property(nonatomic,strong)UIView *backgroundView;
@property(nonatomic,strong)NSString *title;

-(void)popup;
//+(void)disapper;
@end
