//
//  ViewController.m
//  DKMessageView
//
//  Created by 张奥 on 14-10-29.
//  Copyright (c) 2014年 DKHS. All rights reserved.
//

#import "ViewController.h"
#import "DKMessageView.h"

@interface DKCollectionViewCell : UICollectionViewCell

@property (nonatomic, readonly) UILabel *textLabel;

@end

@implementation DKCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _textLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        _textLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_textLabel];
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = [UIColor grayColor].CGColor;
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowOffset = CGSizeMake(3, 3);
    }
    return self;
}

@end

////////////////////////////////////////////////////////////////////////

#define CellIdentifier      (@"CellIdentifier")

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    DKMessageView *messageView = [[DKMessageView alloc] initWithFrame:CGRectMake(10, 50, CGRectGetWidth(self.view.bounds) - 20, 300)];
    [messageView registerClass:[DKCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    messageView.delegate = self;
    messageView.dataSource = self;
    [self.view addSubview:messageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  UICollectionViewDataSource,UICollectionViewDelegate methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DKCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",indexPath);
}

@end
