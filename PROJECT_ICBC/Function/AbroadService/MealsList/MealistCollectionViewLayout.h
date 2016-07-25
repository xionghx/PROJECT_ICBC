//
//  MealistCollectionViewLayout.h
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/25/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AttributesContenOffset <NSObject>

-(CGPoint )attributesContenOffset;

@end

@interface MealistCollectionViewLayout : UICollectionViewLayout
@property(nonatomic ,assign)id<AttributesContenOffset> delegate;
@end
