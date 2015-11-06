//
//  HBCollectionItemView.h
//  HBNuoMi
//
//  Created by wangfeng on 15/11/6.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickImageBlock)(NSInteger index);

@interface HBCollectionItemView : UIView <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, copy) ClickImageBlock clickImageBlock;

@property (nonatomic, strong) UIPageControl* page;
@property (nonatomic, strong) UICollectionView* collectionVie;

@property (nonatomic, strong) NSArray* titleArray;
@property (nonatomic, strong) NSArray* imageArray;


@end

@interface HBCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView* topImageView;
@property (nonatomic, strong) UILabel* bottomLabel;
@end