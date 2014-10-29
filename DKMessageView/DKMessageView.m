//
//  DKMessageView.m
//  DKMessageView
//
//  Created by ZhangAo on 14-7-17.
//  Copyright (c) 2014年 ZA. All rights reserved.
//

#import "DKMessageView.h"
#import "DKMessageCollectionLayout.h"

@interface DKMessageView ()
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) DKMessageCollectionLayout *layout;
@end

@implementation DKMessageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        DKMessageCollectionLayout *layout = [[DKMessageCollectionLayout alloc] init];
        layout.itemSize = frame.size;
        layout.minimumLineSpacing = 10;
        
        UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,
                                                                                          CGRectGetWidth(self.bounds),
                                                                                          ceilf(CGRectGetHeight(self.bounds)))
                                                          collectionViewLayout:layout];
        self.layout = layout;
        
        collection.bounces = NO;
        collection.scrollEnabled = NO;
//        collection.pagingEnabled = YES;
        collection.clipsToBounds = NO;
//        collection.showsVerticalScrollIndicator = YES;
        collection.backgroundColor = [UIColor clearColor];
        [self addSubview:collection];
        
        self.collectionView = collection;
        
        self.scrollEnabled = YES;
        self.scrollToUpEnabled = YES;
        self.scrollToDownEnabled = YES;
        
        UISwipeGestureRecognizer *upGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        upGesture.direction = UISwipeGestureRecognizerDirectionUp;
        [self addGestureRecognizer:upGesture];
        
        UISwipeGestureRecognizer *downGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        downGesture.direction = UISwipeGestureRecognizerDirectionDown;
        [self addGestureRecognizer:downGesture];
    }
    return self;
}

-(void)swipe:(UISwipeGestureRecognizer *)gesture{
    if (self.scrollEnabled) {
        self.layout.direction = gesture.direction;
        switch (gesture.direction) {
            case UISwipeGestureRecognizerDirectionUp:
                if (self.scrollToUpEnabled) {
//                    self.layout.currentIndex = self.currentPage + 1;
                    [self scrollToIndex:self.currentPage + 1];
                }
                break;
            case UISwipeGestureRecognizerDirectionDown:
                if (self.scrollToDownEnabled) {
                    [self scrollToIndex:self.currentPage - 1];
//                    self.layout.currentIndex = self.currentPage - 1;                    
                }
                break;
            default:
                NSAssert(0, @"");
        }        
    }
}

- (void)dealloc
{
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        [self removeGestureRecognizer:gesture];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)reloadData{
    [self.collectionView reloadData];
}

-(void)setDataSource:(id<UICollectionViewDataSource>)dataSource{
    _dataSource = dataSource;
    self.collectionView.dataSource = dataSource;
}

-(void)setDelegate:(id<UICollectionViewDelegate>)delegate{
    _delegate = delegate;
    self.collectionView.delegate = delegate;
}

-(void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier{
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}

-(NSInteger)currentPage{
    return ceil(self.collectionView.contentOffset.y / CGRectGetHeight(self.collectionView.bounds));
}

-(void)scrollToIndex:(NSInteger)index{
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    if (index < 0 && index >= count) return;
//    [self.collectionView scrollRectToVisible:(CGRect){{0,self.collectionView.contentOffset.y},self.collectionView.size} animated:YES];
    self.layout.currentIndex = index;
    if (CGSizeEqualToSize(self.collectionView.contentSize, CGSizeZero) ) {
        self.collectionView.contentOffset = CGPointMake(0, index * CGRectGetHeight(self.collectionView.bounds));
        self.layout.currentIndex = index;
    } else {
        [self.collectionView scrollRectToVisible:CGRectMake(0, index * CGRectGetHeight(self.collectionView.bounds),
                                                            CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight(self.collectionView.bounds))
                                        animated:YES];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
