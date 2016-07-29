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
    
    UICollectionViewLayoutAttributes *collectionViewLayoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGPoint point = self.collectionView.contentOffset;
    
    collectionViewLayoutAttributes.center = CGPointMake(self.collectionView.center.x + indexPath.row * 380 , 380);
    collectionViewLayoutAttributes.bounds = CGRectMake(0, 0, 275 , 400);
    CGFloat xScale = (point.x +self.collectionView.center.x - collectionViewLayoutAttributes.center.x)< 380? (380 - fabs(point.x +self.collectionView.center.x - collectionViewLayoutAttributes.center.x))/380 : 0 ;
    collectionViewLayoutAttributes.transform = CGAffineTransformMakeScale(1 + xScale * 60 /275,1 + xScale * 100/400);
    return collectionViewLayoutAttributes;
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.layoutAttributesArray.count * self.collectionView.frame.size.width/2.0f-self.collectionView.frame.size.width/4.0f  , 0);
}

//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//{
//    return YES;
//    
//}
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    NSInteger x =((NSInteger)ceil(proposedContentOffset.x * 1.0) ) % 380 > 190 ?(((NSInteger)ceil(proposedContentOffset.x * 1.0) )/380  +1 )* 380:((NSInteger)ceil(proposedContentOffset.x * 1.0) )/380 * 380 ;
    CGPoint newProposedContentOffset = CGPointMake(x, proposedContentOffset.y);
    return newProposedContentOffset;
}


@end
