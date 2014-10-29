//
//  DKMessageCollectionLayout.h
//  DKMessageView
//
//  Created by ZhangAo on 14-7-15.
//  Copyright (c) 2014年 ZA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKMessageCollectionLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) UISwipeGestureRecognizerDirection direction;
@property (nonatomic, assign) NSInteger currentIndex;

@end
