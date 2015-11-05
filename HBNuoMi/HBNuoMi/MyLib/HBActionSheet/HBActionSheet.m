//
//  HBActionSheet.m
//  HBActionSheet
//
//  Created by wangfeng on 15/7/30.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//

#import "HBActionSheet.h"
@interface HBActionSheet()<UIGestureRecognizerDelegate>

    //标题
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) UILabel* titleLabel;

    //销毁按钮
@property (nonatomic, strong) NSString* destructiveTitle;
@property (nonatomic, strong) UIButton* destructiveBtn;
    //取消按钮
@property (nonatomic, strong) NSString* cancelTitle;
@property (nonatomic, strong) UIButton* cancelBtn;
    //一般按钮
@property (nonatomic, strong) NSArray* normalTitles;
@property (nonatomic, strong) UIButton* normalBtn;


    //布局View
@property (nonatomic, strong) UIView* contentView;
@property (nonatomic, strong) UIView* line;
@property (nonatomic, strong) UIView* topContentView;
    //按钮高度
@property (nonatomic, assign) CGFloat btnHeight;
    //按钮字体、颜色
@property (nonatomic, strong) UIColor* btnTitleColor;
    //点击背景色
@property (nonatomic, strong) UIColor* highlightColor;

@property (nonatomic, copy) ButtonClickBlock block;
@end

#define PADDING (10.0)
#define WIDTH  (self.frame.size.width - 2 * PADDING)


@implementation HBActionSheet
{
    CGFloat _topHeight;
    CGFloat _contentHeight;
    CGFloat _cancleTag;
}
-(instancetype)init
{
    return [super init];
}

-(void)dealloc
{
    NSLog(@"%s",__func__);
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
}
#pragma mark -public methord

-(instancetype)initWithTitle:(NSString*) title cancelButton:(NSString*)cancelButtonTitle  destructiveButton:(NSString*)destructiveButtonTitle otherButtonTitles:(NSArray*)otherButtonTitles
{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.userInteractionEnabled = YES;
        self.btnHeight = 44;
        
        self.title = title;
        self.cancelTitle = cancelButtonTitle;
            //默认存在
        if (!cancelButtonTitle) {
            self.cancelTitle = @"取消";
        }
        self.normalTitles = otherButtonTitles;
        self.destructiveTitle = destructiveButtonTitle;
        
        _contentHeight = [self cacluateContentHeight];
        if (_cancelTitle) {
            _topHeight = [self cacluateContentHeight] -PADDING - self.btnHeight;
        }
        else{
            _topHeight = [self cacluateContentHeight];
        }
        if (!self.btnTitleColor) {
            self.btnTitleColor = self.tintColor;
        }
        if (!self.highlightColor) {
            self.highlightColor = [UIColor colorWithWhite:0.9 alpha:0.6];
        }
        [self addSubview:self.contentView];
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEvent)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

-(instancetype)initWithTitle:(NSString*) title cancelButton:(NSString*)cancelButtonTitle  destructiveButton:(NSString*)destructiveButtonTitle otherButtonTitles:(NSArray*)otherButtonTitles buttonTitleColor:(UIColor*)color
{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.userInteractionEnabled = YES;
        self.btnHeight = 44;
        
        self.title = title;
        self.cancelTitle = cancelButtonTitle;
            //默认存在
        if (!cancelButtonTitle) {
            self.cancelTitle = @"取消";
        }
        self.normalTitles = otherButtonTitles;
        self.destructiveTitle = destructiveButtonTitle;
        self.btnTitleColor = color;
        
        _contentHeight = [self cacluateContentHeight];
        if (_cancelTitle) {
            _topHeight = [self cacluateContentHeight] -PADDING - self.btnHeight;
        }
        else{
            _topHeight = [self cacluateContentHeight];
        }
        if (!self.btnTitleColor) {
            self.btnTitleColor = self.tintColor;
        }
        if (!self.highlightColor) {
            self.highlightColor = [UIColor colorWithWhite:0.9 alpha:0.6];
        }
        [self addSubview:self.contentView];
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEvent)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
    }
    return self;
}


-(void)setButtonclickBlock:(ButtonClickBlock)block{
    self.block = block;
}
-(void)showInVies:(UIView*)view
{
    [view endEditing:YES];
    [view.window addSubview:self];
    [self showSheet];
    
}

#pragma mark -getters

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.userInteractionEnabled = NO;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _titleLabel;
}
-(UIButton *)createNormalBtn
{
    UIButton* normalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self.btnTitleColor)
    {
        [normalBtn setTitleColor:self.btnTitleColor forState:UIControlStateNormal];

    }
    [normalBtn setBackgroundImage:[self createImageWithColor:self.highlightColor] forState:UIControlStateHighlighted];
    
    normalBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [normalBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return normalBtn;
}

-(UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.layer.cornerRadius = 3.0;
        _cancelBtn.layer.masksToBounds = YES;
        _cancelBtn.frame = CGRectMake(0, [self cacluateContentHeight] - self.btnHeight, WIDTH, self.btnHeight);
        [_cancelBtn setTitle:self.cancelTitle forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        [_cancelBtn setTitleColor: self.btnTitleColor  forState:UIControlStateNormal];
         [_cancelBtn setBackgroundImage:[self createImageWithColor:self.highlightColor] forState:UIControlStateHighlighted];
        _cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    }
    return _cancelBtn;
}
-(UIButton *)destructiveBtn{
    if (!_destructiveBtn) {
        _destructiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_destructiveBtn setTitle:self.destructiveTitle forState:UIControlStateNormal];
        [_destructiveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_destructiveBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
         [_destructiveBtn setBackgroundImage:[self createImageWithColor:self.highlightColor] forState:UIControlStateHighlighted];
        _destructiveBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    }
    return _destructiveBtn;
}
-(UIView *)creatLine
{
    UIView* line = [UIView new];
    line.backgroundColor = [UIColor lightGrayColor];
    return line;
}

-(UIView *)topContentView
{
    if (!_topContentView) {
        _topContentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, _topHeight)];
        _topContentView.backgroundColor = [UIColor whiteColor];
        _topContentView.layer.cornerRadius = 4.0;
        _topContentView.layer.masksToBounds = YES;
        CGFloat nowY  = 0.0;
        NSInteger tagNUm = 0;
        if (_title) {
                //高减去0.5 给线留着
            self.titleLabel.frame =CGRectMake(0, nowY, WIDTH, self.btnHeight + 5 -0.5);
            self.titleLabel.text = self.title;
            nowY += self.btnHeight + 5;
            
            [_topContentView addSubview:_titleLabel];
            UIView* line = [self creatLine];
            line.frame = CGRectMake(0, nowY -0.5, WIDTH, 0.5);
            [_topContentView addSubview:line];
            
        }
        
        if (self.normalTitles && self.normalTitles.count > 0) {
            
            for (NSUInteger i = 0;i < self.normalTitles.count;i++) {
                NSString* title = self.normalTitles[i];
                if (!title) {
                    continue;
                }
                UIButton* btn = [self createNormalBtn];
                [btn setTitle:title forState:UIControlStateNormal];
                
                btn.frame =  CGRectMake(0, nowY, WIDTH, self.btnHeight -0.5);
                nowY += self.btnHeight;
                [_topContentView addSubview:btn];
                btn.tag = tagNUm;
                tagNUm++;
                
                [_topContentView addSubview:_titleLabel];
                UIView* line = [self creatLine];
                line.frame = CGRectMake(0, nowY -0.5, WIDTH, 0.5);
                [_topContentView addSubview:line];
                
            }
        }
        
        if (_destructiveTitle) {
                //高减去0.5 给线留着
            self.destructiveBtn.frame =CGRectMake(0, nowY, WIDTH, self.btnHeight);
            nowY += self.btnHeight;
            [_topContentView addSubview:_destructiveBtn];
            _destructiveBtn.tag = tagNUm;
            tagNUm++;
        }

        _cancleTag = tagNUm;
    }
    return _topContentView;
}

-(UIView *)contentView
{
    if (!_contentView) {
        CGFloat height = [self cacluateContentHeight];
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(PADDING, self.frame.size.height , WIDTH, height)];
        _contentView.backgroundColor = [UIColor clearColor];
        [_contentView addSubview:self.topContentView];
        self.cancelBtn.tag = _cancleTag;
        [_contentView addSubview:self.cancelBtn];
    }
    return _contentView;
    
}

#pragma mark -private methord
-(CGFloat)cacluateContentHeight
{
    CGFloat contentHeight = 0.0;
    if (self.normalTitles && self.normalTitles.count > 0) {
        contentHeight += _btnHeight * self.normalTitles.count;
    }
    if (_cancelTitle) {
        contentHeight += _btnHeight + PADDING;
    }
    if (_destructiveTitle){
        contentHeight += _btnHeight ;
    }
    if (_title) {
        contentHeight += _btnHeight + 5.0;
    }
   
    return contentHeight;
}

-(void)remove
{
    [self removeFromSuperview];
}

-(void)showSheet
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.contentView.frame;
        frame.origin.y = self.frame.size.height - _contentHeight - PADDING;
        self.contentView.frame = frame;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
    }];
}

-(void)hideSheet
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.contentView.frame ;
        frame.origin.y = self.frame.size.height;
        self.contentView.frame = frame;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        
        
        
    } completion:^(BOOL finished) {
        [self remove];
        
    }];
    
}

#pragma mark -event
-(void)btnClick:(UIButton*)btn
{
    NSInteger tagNum = btn.tag;
    if (self.block) {
        self.block(tagNum);
    }
    [self hideSheet];
   
    
}
-(void)tapEvent
{
        //NSLog(@"%s",__func__);
    [self hideSheet];
}



#pragma mark -delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
        CGPoint point = [touch locationInView:gestureRecognizer.view];
        if (point.y < (self.frame.size.height - PADDING - _contentHeight) ) {
            return YES;
        } else {
            return NO;
        }

    
    return YES;
}
#pragma mark  tools methord
- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
@end
