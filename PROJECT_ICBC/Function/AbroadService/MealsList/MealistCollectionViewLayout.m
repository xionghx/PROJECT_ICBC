//
//  MealistCollectionViewLayout.m
//  PROJECT_ICBC
//
//  Created by xionghuaxin on 7/25/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

#import "MealistCollectionViewLayout.h"


@interface MealistCollectionViewLayout ()
@property(nonatomic,strong)NSMutableArray *layoutAttributesArray;

@end

@implementation MealistCollectionViewLayout



-(void)prepareLayout
{
    [super prepareLayout];
    self.layoutAttributesArray = [NSMutableArray array];
    NSInteger numberOfItem = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger index = 0; index < numberOfItem ; index ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.layoutAttributesArray addObject:attributes];
    }

    
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.layoutAttributesArray;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建布局属性
    
    UICollectionViewLayoutAttributes *collectionViewLayoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGPoint point = [self.delegate attributesContenOffset];
//    NSLog(@"%ld",(NSInteger)ceil(point.x)%(NSInteger)ceil(point.y));
    //    CGSize size =  CGSizeMake(334, 500);

//    collectionViewLayoutAttributes.bounds = CGRectMake(0, 0, size.width , size.height);
    
    collectionViewLayoutAttributes.center = CGPointMake(self.collectionView.center.x + indexPath.row * 380 , 380);
    
    CGFloat x = abs((ceil(point.x +self.collectionView.center.x - collectionViewLayoutAttributes.center.x))< 380)? 60 - fabs((ceil(point.x +self.collectionView.center.x - collectionViewLayoutAttributes.center.x))/380 * 60) : 0 ;
    CGFloat y = abs((ceil(point.x +self.collectionView.center.x - collectionViewLayoutAttributes.center.x))< 380)? 100 - fabs((ceil(point.x +self.collectionView.center.x - collectionViewLayoutAttributes.center.x))/380 * 100) : 0 ;
    
    NSLog(@"%lf",x);
        CGSize size =  CGSizeMake(334- 60 + x, 500-100 + y);
        collectionViewLayoutAttributes.bounds = CGRectMake(0, 0, size.width , size.height);



    // collectionView的宽度
//    CGFloat collectionViewW = self.collectionView.frame.size.width;
//    
//    // 设置布局属性的frame
//    CGFloat w = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
//    CGFloat h = [self.delegate waterflowLayout:self heightForItemAtIndex:indexPath.item itemWidth:w];
//    
//    // 找出高度最短的那一列
//    NSInteger destColumn = 0;
//    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
//    for (NSInteger i = 1; i < self.columnCount; i++) {
//        // 取得第i列的高度
//        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
//        
//        if (minColumnHeight > columnHeight) {
//            minColumnHeight = columnHeight;
//            destColumn = i;
//        }
//    }
//    
//    CGFloat x = self.edgeInsets.left + destColumn * (w + self.columnMargin);
//    CGFloat y = minColumnHeight;
//    if (y != self.edgeInsets.top) {
//        y += self.rowMargin;
//    }
//    attrs.frame = CGRectMake(x, y, w, h);
//    
//    // 更新最短那列的高度
//    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
//    
//    // 记录内容的高度
//    CGFloat columnHeight = [self.columnHeights[destColumn] doubleValue];
//    if (self.contentHeight < columnHeight) {
//        self.contentHeight = columnHeight;
//    }
    return collectionViewLayoutAttributes;
}

- (CGSize)collectionViewContentSize
{
    //    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
    //    for (NSInteger i = 1; i < self.columnCount; i++) {
    //        // 取得第i列的高度
    //        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
    //
    //        if (maxColumnHeight < columnHeight) {
    //            maxColumnHeight = columnHeight;
    //        }
    //    }
    return CGSizeMake(self.layoutAttributesArray.count * self.collectionView.frame.size.width/2.0f-self.collectionView.frame.size.width/4.0f  , 0);
}

@end
