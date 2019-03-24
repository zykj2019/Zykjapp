//
//  PlaceholderTextView.m
//  UIScorllView
//
//  Created by zoulixiang on 16/3/24.
//  Copyright © 2016年 zoulixiang. All rights reserved.
//

#import "PlaceholderTextView.h"

#define DefineColor [UIColor colorWithRed:(207)/255.0 green:(207)/255.0 blue:(212)/255.0 alpha:1]
#define RGB(r,g,b)             [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@interface PlaceholderTextView () <UITextViewDelegate>

@end

@implementation PlaceholderTextView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.placeholderStr = self.text;
        [self setTextColor:DefineColor];
        [self setFont:[UIFont systemFontOfSize:14]];
        self.delegate =self;
        [self setTextAlignment:NSTextAlignmentLeft];
       
       // [self setBorder];
    }
    return self;
}

+(PlaceholderTextView *)viewForGrayStr:(NSString *)str{
    
    PlaceholderTextView *textView = [[PlaceholderTextView alloc] init];
    textView.delegate = textView;
    textView.placeholderStr = str;
    textView.text = str;
    [textView setTextColor:DefineColor];
    [textView setFont:[UIFont systemFontOfSize:14]];
    [textView setContentInset:UIEdgeInsetsZero];
    [textView setTextAlignment:NSTextAlignmentLeft];
    //[textView setBorder];
    return textView;
}

#pragma mark - textViewDelegate

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:self.placeholderStr])
    {
        NSRange range;
        range.location = 0;
        range.length = 0;
        textView.selectedRange = range;
        return;
    }
    if (self.textDelegate && [self.textDelegate respondsToSelector:@selector(didBeginEditing:)]) {
        [self.textDelegate didBeginEditing:self];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    if (textView.text.length == 0) {
        textView.text = self.placeholderStr;
        [textView setTextColor:DefineColor];
        return;
    }
    if ([textView.text isEqualToString:self.placeholderStr]){
        return;
    }
    
    if (self.textDelegate && [self.textDelegate respondsToSelector:@selector(didEndEditing:)]) {
        [self.textDelegate didEndEditing:self];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{


    if ([textView.text isEqualToString:self.placeholderStr])
    {   
        textView.text = @"";
        [textView setTextColor:[UIColor blackColor]];
        return YES;
    }
    
    if (self.textDelegate && [self.textDelegate respondsToSelector:@selector(extTextView:shouldChangeTextInRange:replacementText:)]) {
        return [self.textDelegate extTextView:self shouldChangeTextInRange:range replacementText:text];
    } else {
        return YES;
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    
    if ([textView.text isEqualToString:self.placeholderStr]){
        NSRange range;
        range.location = 0;
        range.length = 0;
        textView.selectedRange = range;
    }
}

-(void)textViewDidChange:(UITextView *)textView{
    
    if ([textView.text isEqualToString:self.placeholderStr]){
        return;
    }

    if (self.textDelegate && [self.textDelegate respondsToSelector:@selector(extTextViewDidChange:)]) {
        [self.textDelegate extTextViewDidChange:self];
    }
}

-(void)setBorder{
    
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = RGB(240, 240, 240).CGColor;
}


@end
