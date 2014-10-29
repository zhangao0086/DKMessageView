//
//  DKMessageCollectionLayout.m
//  DKMessageView
//
//  Created by ZhangAo on 14-7-15.
//  Copyright (c) 2014年 ZA. All rights reserved.
//

#import "DKMessageCollectionLayout.h"

#define GeActiveIndexByOffset(offset)   (self.direction == UISwipeGestureRecognizerDirectionUp ? ceil(offset) : floor(offset))

@interface DKMessageCollectionLayout ()

@property (nonatomic, assign) NSInteger cellCount;
//@property (nonatomic, assign) CGFloat lastContentOffset;
@property (nonatomic, assign) CGFloat offset;
//@property (nonatomic, assign) int activeIndex;
//@property (nonatomic, assign) BOOL isUpwarding;

@end

@implementation DKMessageCollectionLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

-(void)prepareLayout{
    [super prepareLayout];
    
    self.cellCount = [self.collectionView numberOfItemsInSection:0];
    self.offset = self.collectionView.contentOffset.y / self.itemSize.height;
}

-(CGSize)collectionViewContentSize{
    const CGSize contentSize = {
        .width = self.itemSize.width,
        .height = self.itemSize.height * self.cellCount
    };
    
    return contentSize;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    
    int firstItem = fmax(0, self.currentIndex - 2);
    int lastItem = fmin(self.cellCount-1 , self.currentIndex + 2);
    
    for (int i = firstItem;i <= lastItem; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }

    return [layoutAttributes copy];
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat index = indexPath.row;
    
    if (index < self.currentIndex) {
        attributes.zIndex = indexPath.item;
      } else if (index == self.currentIndex) {
        attributes.zIndex = 999;
    } else {
        attributes.zIndex = - indexPath.item;
    }

    attributes.size = self.itemSize;
    CGFloat offsetY = (indexPath.item - self.currentIndex)*10;
    attributes.center = CGPointMake(self.collectionView.bounds.size.width / 2,
                                    self.collectionView.bounds.size.height / 2
                                    + self.collectionView.contentOffset.y
                                    + offsetY);
    
    //0.0644 = 0.0322 * 2：310px scale to 300px
    CGFloat scaleFactor = 1 - (0.0644 * ABS(index - self.offset));
    CGAffineTransform scale = CGAffineTransformMakeScale(scaleFactor, 1);
    
    CGFloat translationFactor = self.offset - self.currentIndex;
    CGAffineTransform translation = CGAffineTransformMakeTranslation(0, translationFactor * -10 / 2);
    
    attributes.transform = CGAffineTransformConcat(scale, translation);
    return attributes;
}

@end
