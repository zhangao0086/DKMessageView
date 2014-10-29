//
//  DKMessageView.h
//  DKMessageView
//
//  Created by ZhangAo on 14-7-17.
//  Copyright (c) 2014年 ZA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKMessageView : UIView

@property (nonatomic, assign) id <UICollectionViewDelegate> delegate;
@property (nonatomic, assign) id <UICollectionViewDataSource> dataSource;

@property (nonatomic, assign) BOOL scrollEnabled;       //defaults to YES
@property (nonatomic, assign) BOOL scrollToUpEnabled;   //defaults to YES
@property (nonatomic, assign) BOOL scrollToDownEnabled; //defaults to YES

@property (nonatomic, readonly) NSInteger currentPage;

-(void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
-(void)scrollToIndex:(NSInteger)index;

-(void)reloadData;

@end
