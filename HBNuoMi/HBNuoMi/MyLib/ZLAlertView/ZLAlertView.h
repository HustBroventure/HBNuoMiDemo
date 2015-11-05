//
//  ZLAlertView.h
//  ZLAlertView
//
//  Created by wangfeng on 15/9/9.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//

#import <UIKit/UIKit.h>

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
typedef void(^ClickBlock)(NSInteger index);
@interface ZLAlertView : UIView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray*)buttons clickBlock:(ClickBlock)clickBlock;


- (void)show;

- (void)dismiss;
@end
