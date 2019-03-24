//
//  PlaceholderTextView.h
//  UIScorllView
//
//  Created by zoulixiang on 16/3/24.
//  Copyright © 2016年 zoulixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlaceholderTextView;

@protocol PlaceholderTextViewDelegate<NSObject>

@optional
-(void)didBeginEditing:(PlaceholderTextView *)textView;
-(void)didEndEditing:(PlaceholderTextView *)textView;
-(BOOL)extTextView:(PlaceholderTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
-(void)extTextViewDidChange:(PlaceholderTextView *)textView;
@end

@interface PlaceholderTextView : UITextView

@property (nonatomic, weak) id<PlaceholderTextViewDelegate> textDelegate;

@property(nonatomic,strong)NSString *placeholderStr;

+(PlaceholderTextView *)viewForGrayStr:(NSString *)str;

@end
