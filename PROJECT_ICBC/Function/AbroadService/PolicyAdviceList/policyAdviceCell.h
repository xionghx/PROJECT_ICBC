//
//  PolicyAdviceCell.h
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/22/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PolicyAdviceCell : UITableViewCell
@property(nonatomic,strong)UILabel *serialNumberLabel;
@property(nonatomic,strong)UILabel *contentLabel;

-(void)setupValueWithData:(NSDictionary *)data;

@end
