//
//  ZLAlertView.m
//  ZLAlertView
//
//  Created by wangfeng on 15/9/9.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//

#import "ZLAlertView.h"
#define AlertPadding 10
#define MenuHeight 44
#define AlertHeight 130
#define AlertWidth 270

@interface ZLAlertView ()
{
    NSString* _title;
    NSString* _message;
    NSArray* _buttonTitles;
    ClickBlock _clickBlock;
    UIView* _coverView;
    UIView* _alertView;
    UILabel* _labelTitle;
    UILabel* _labelmessage;
    UIView * _contentView;
    UIView* _btnContainer;
}
@end
@implementation ZLAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray*)buttons clickBlock:(ClickBlock)clickBlock
{
    self = [super init];
    if (self) {
        _buttonTitles = buttons;
        _clickBlock = clickBlock;
        _title  = title;
        _message = message;
        
        [self creatViews];
    }
    return self;
}
- (void)creatViews
{
    self.frame = [self screenBounds];
    
    _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AlertWidth, AlertHeight)];
    _alertView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _alertView.layer.cornerRadius = 5;
    _alertView.layer.masksToBounds = YES;
    _alertView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_alertView];
    
        //title
    CGFloat labelHeigh = [self heightWithString:_title fontSize:17 width:AlertWidth-2*AlertPadding];
    _labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(AlertPadding, AlertPadding, AlertWidth-2*AlertPadding, labelHeigh)];
    _labelTitle.font = [UIFont boldSystemFontOfSize:17];
    _labelTitle.textColor = [UIColor blackColor];
    _labelTitle.textAlignment = NSTextAlignmentCenter;
    _labelTitle.numberOfLines = 0;
    _labelTitle.text = _title;
    _labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
    [_alertView addSubview:_labelTitle];
    
        //message
    CGFloat messageHeigh = [self heightWithString:_message fontSize:14 width:AlertWidth-2*AlertPadding];
    
    _labelmessage =  [[UILabel alloc]initWithFrame:CGRectMake(AlertPadding, _labelTitle.frame.origin.y+_labelTitle.frame.size.height, AlertWidth-2*AlertPadding, messageHeigh+2*AlertPadding)];
    _labelmessage.font = [UIFont systemFontOfSize:14];
    _labelmessage.textColor = [UIColor blackColor];
    _labelmessage.textAlignment = NSTextAlignmentCenter;
    _labelmessage.text = _message;
    _labelmessage.numberOfLines = 0;
    _labelmessage.lineBreakMode = NSLineBreakByCharWrapping;
    [_alertView addSubview:_labelmessage];
    
        //按钮
    if(_buttonTitles.count == 0)
        return;
    _btnContainer = [[UIView alloc]initWithFrame:CGRectMake(0, _alertView.frame.size.height- MenuHeight,AlertWidth, MenuHeight)];
    CGFloat  width;
    width = _alertView.frame.size.width / _buttonTitles.count;

    for (NSInteger i = 0;i < [_buttonTitles count]; i++) {
        NSString* title = _buttonTitles[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(i * width, 1, width, MenuHeight);
            //seperator
        button.backgroundColor = [UIColor whiteColor];
        button.layer.shadowColor = [[UIColor grayColor] CGColor];
        button.layer.shadowRadius = 0.5;
        button.layer.shadowOpacity = 1;
        button.layer.shadowOffset = CGSizeZero;
        button.layer.masksToBounds = NO;
            //[button setTitleColor:[UIColor colorWithHexString:@"#ff3b30"] forState:UIControlStateNormal];
        button.tag = i;
            // title
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:button.titleLabel.font.pointSize];
            //第二个按钮加粗，一般最多两个按钮
        if (1 == i) {
            button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        }
        else{
            button.titleLabel.font = [UIFont systemFontOfSize:17];
            
        }

            // action
        [button addTarget:self
                   action:@selector(buttonClick:)
         forControlEvents:UIControlEventTouchUpInside];
        
        [_btnContainer addSubview:button];
    }
    [_alertView addSubview:_btnContainer];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    

}

- (void)dealloc
{
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat plus;
    if (_contentView){
        plus = _contentView.frame.size.height-(_alertView.frame.size.height-MenuHeight);
    }else{
        plus = _labelmessage.frame.origin.y+_labelmessage.frame.size.height -(_alertView.frame.size.height-MenuHeight);
    }
    plus = MAX(0, plus);
    CGFloat height =  MIN([self screenBounds].size.height-MenuHeight,_alertView.frame.size.height+plus);
    
    _alertView.frame = CGRectMake(_alertView.frame.origin.x, _alertView.frame.origin.y, AlertWidth, height);
    _alertView.center = self.center;
    
    _btnContainer.frame =  CGRectMake(0, _alertView.frame.size.height- MenuHeight,AlertWidth, MenuHeight);
        //_coverView.frame = self.bounds;
    
}

- (CGFloat)heightWithString:(NSString*)string fontSize:(CGFloat)fontSize width:(CGFloat)width
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [string boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height;
}

- (void)buttonClick:(UIButton*)button{
    if (_clickBlock) {
        _clickBlock(button.tag);
    }
    [self dismiss];
}

#pragma mark - show and dismiss
-(UIView*)topView{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    return  window.subviews[0];
}
- (void)show
{
    [[self topView] addSubview:self];
[self exChangeOut:_alertView dur:0.1];
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    } completion:^(BOOL finished) {
        
    }];
        //[self showAnimation];
    
}

- (void)dismiss {
    [self hideAnimation];
}


- (void)showAnimation {
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [_alertView.layer addAnimation:popAnimation forKey:nil];
}

- (void)hideAnimation{
    [UIView animateWithDuration:0.4 animations:^{

     _alertView.alpha = 0.0;
         self.backgroundColor = [UIColor clearColor];
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];

    }];
    
    
}


-(void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    
        //animation.delegate = self;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    
        //[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    
        //[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.01, 1.01, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [changeOutView.layer addAnimation:animation forKey:nil];
    
}

#pragma mark - Handle device orientation changes
    // Handle device orientation changes
- (void)deviceOrientationDidChange: (NSNotification *)notification
{
    self.frame = [self screenBounds];
    _alertView.center = self.center;
    
    
}
- (CGRect)screenBounds
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
        // On iOS7, screen width and height doesn't automatically follow orientation
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
            CGFloat tmp = screenWidth;
            screenWidth = screenHeight;
            screenHeight = tmp;
        }
    }
    
    return CGRectMake(0, 0, screenWidth, screenHeight);
}

@end
