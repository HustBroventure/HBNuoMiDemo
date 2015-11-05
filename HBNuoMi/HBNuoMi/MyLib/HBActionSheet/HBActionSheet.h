//
//  HBActionSheet.h
//  HBActionSheet
//
//  Created by wangfeng on 15/7/30.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonClickBlock)(NSInteger);
@interface HBActionSheet : UIView


    //创建
-(instancetype)initWithTitle:(NSString*) title cancelButton:(NSString*)cancelButtonTitle  destructiveButton:(NSString*)destructiveButtonTitle otherButtonTitles:(NSArray*)otherButtonTitles;
-(instancetype)initWithTitle:(NSString*) title cancelButton:(NSString*)cancelButtonTitle  destructiveButton:(NSString*)destructiveButtonTitle otherButtonTitles:(NSArray*)otherButtonTitles buttonTitleColor:(UIColor*)color;

    //展示
-(void)showInVies:(UIView*)view;
    //设置block回调
-(void)setButtonclickBlock:(ButtonClickBlock)block;
@end
