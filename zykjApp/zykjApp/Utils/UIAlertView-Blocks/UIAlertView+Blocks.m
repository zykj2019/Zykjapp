//
//  UIAlertView+Blocks.m
//  Shibui
//
//  Created by Jiva DeVoe on 12/28/10.
//  Copyright 2010 Random Ideas, LLC. All rights reserved.
//

#import "UIAlertView+Blocks.h"
#import <objc/runtime.h>


static NSString *RI_BUTTON_ASS_KEY = @"com.random-ideas.BUTTONS";


@implementation UIAlertView (Blocks)

- (id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(RIButtonItem *)inCancelButtonItem otherButtonItems:(RIButtonItem *)inOtherButtonItems, ...
{
    if ((self = [self initWithTitle:inTitle message:inMessage delegate:self cancelButtonTitle:inCancelButtonItem.label otherButtonTitles:nil]))
    {
        NSMutableArray *buttonsArray = [NSMutableArray array];

        RIButtonItem *eachItem;
        va_list argumentList;
        if (inOtherButtonItems)
        {
            [buttonsArray addObject:inOtherButtonItems];
            va_start(argumentList, inOtherButtonItems);
            while ((eachItem = va_arg(argumentList, RIButtonItem *)))
            {
                [buttonsArray addObject:eachItem];
            }
            va_end(argumentList);
        }

        for (RIButtonItem *item in buttonsArray)
        {
            [self addButtonWithTitle:item.label];
        }

        if (inCancelButtonItem)
        {
            [buttonsArray insertObject:inCancelButtonItem atIndex:0];
        }

        objc_setAssociatedObject(self, (__bridge const void *)(RI_BUTTON_ASS_KEY), buttonsArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

        [self setDelegate:self];
    }
    return self;
}

- (NSInteger)addButtonItem:(RIButtonItem *)item
{
    NSMutableArray *buttonsArray = objc_getAssociatedObject(self, (__bridge const void *)(RI_BUTTON_ASS_KEY));

    NSInteger buttonIndex = [self addButtonWithTitle:item.label];
    [buttonsArray addObject:item];

    return buttonIndex;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSArray      *buttonsArray = objc_getAssociatedObject(self, (__bridge const void *)(RI_BUTTON_ASS_KEY));
    RIButtonItem *item         = [buttonsArray objectAtIndex:buttonIndex];
    if (item.action)
    {
        item.action();
    }
    objc_setAssociatedObject(self, (__bridge const void *)(RI_BUTTON_ASS_KEY), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



static DismissBlock _dismissBlock;
static CancelBlock _cancelBlock;


+ (UIAlertView*) alertViewWithTitle:(NSString*) title                    
                            message:(NSString*) message 
                  cancelButtonTitle:(NSString*) cancelButtonTitle
                  otherButtonTitles:(NSArray*) otherButtons
                          onDismiss:(DismissBlock) dismissed                   
                           onCancel:(CancelBlock) cancelled {
    
    _cancelBlock  = [cancelled copy];
    
    _dismissBlock  = [dismissed copy];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:(id)[self class]
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil];
    
    for(NSString *buttonTitle in otherButtons)
        [alert addButtonWithTitle:buttonTitle];
    
    [alert show];
    return alert;
}

+ (UIAlertView*) alertViewWithTitle:(NSString*) title 
                            message:(NSString*) message {
    
    return [UIAlertView alertViewWithTitle:title 
                                   message:message 
                         cancelButtonTitle:NSLocalizedString(@"Dismiss", @"")];
}

+ (UIAlertView*) alertViewWithTitle:(NSString*) title 
                            message:(NSString*) message
                  cancelButtonTitle:(NSString*) cancelButtonTitle {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles: nil];
    [alert show];
    return alert;
}


+ (void)alertView:(UIAlertView*) alertView didDismissWithButtonIndex:(NSInteger) buttonIndex {
	if(buttonIndex == [alertView cancelButtonIndex]) {
        if (_cancelBlock) {
            _cancelBlock();
        }
	}  else {
        if (_dismissBlock) {
            _dismissBlock((int)buttonIndex - 1); // cancel button is button 0
             
        }
    }
    
    _cancelBlock = nil;
    _dismissBlock = nil;
}


@end
