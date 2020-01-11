//
//  LineView.m
//  zykjApp
//
//  Created by zoulixiang on 2018/4/9.
//  Copyright © 2018年 zoulixiang. All rights reserved.
//

#import "LineView.h"

@implementation LineView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
     self =  [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = WCLINECOLOR;
    }
     return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = WCLINECOLOR;
    }
    return self;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
         self.backgroundColor = WCLINECOLOR;
    }
    return self;
}
@end

@implementation LineActivateView

- (void)awakeFromNib {
    [super awakeFromNib];
//
    for (NSLayoutConstraint *constraint in self.constraints) {
        if ([constraint.identifier isEqualToString:@"lav"] || constraint.constant == 1.0) {
            _heightConstraint = constraint;
        }
    }
    _heightConstraint.constant = bottomLineHeight;
    
    //
}


- (void)setBackgroundColor:(UIColor *)backgroundColor {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    
    //设置运动时间
    animation.duration = 0.15;
    
    [self.layer addAnimation:animation forKey:@"animation"];
    [super setBackgroundColor:backgroundColor];
}
@end


@implementation ActivateView {
    NSMutableArray *textViews;
    LineActivateView *activateView;
    UIColor *orginLineColor;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self =  [super initWithCoder:aDecoder];
    if (self) {
        [self configOwnViews];
    }
    return self;
}

- (void)configOwnViews {
    [super configOwnViews];
    textViews = @[].mutableCopy;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            [textViews addObject:view];
        }
        if ([view isKindOfClass:LineActivateView.class]) {
            activateView = (LineActivateView *)view;
            orginLineColor = activateView.backgroundColor;
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textBegin:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textEnd:) name:UITextFieldTextDidEndEditingNotification object:nil];
    
   
    
    
}

#pragma mark - 通知
-(void)textBegin:(NSNotification *)noti {
    UIView *textView = noti.object;
    if ([textViews indexOfObject:textView] != NSNotFound) {
        
        activateView.backgroundColor = kMainTextColor;
        activateView.heightConstraint.constant = 1.0;
    } else {
        
        activateView.backgroundColor = orginLineColor;
         activateView.heightConstraint.constant = bottomLineHeight;
        
    }
    
}

-(void)textEnd:(NSNotification *)noti {
    activateView.backgroundColor = orginLineColor;
    activateView.heightConstraint.constant = bottomLineHeight;
}

- (void)layoutIfNeeded {
    [super layoutIfNeeded];
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
}
@end

