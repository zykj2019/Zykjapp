//
//  UIActionSheet+Blocks.m
//  Shibui
//
//  Created by Jiva DeVoe on 1/5/11.
//  Copyright 2011 Random Ideas, LLC. All rights reserved.
//

#import "UIActionSheet+Blocks.h"
#import <objc/runtime.h>


static NSString *RI_BUTTON_ASS_KEY = @"com.random-ideas.BUTTONS";


static DismissBlock _dismissBlock;
static CancelBlock _cancelBlock;
//static PhotoPickedBlock _photoPickedBlock;
static UIViewController *_presentVC;


@implementation UIActionSheet (Blocks)

- (id)initWithTitle:(NSString *)inTitle cancelButtonItem:(RIButtonItem *)inCancelButtonItem destructiveButtonItem:(RIButtonItem *)inDestructiveItem otherButtonItems:(RIButtonItem *)inOtherButtonItems, ...
{
    if ((self = [self initWithTitle:inTitle delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil]))
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

        if (inDestructiveItem)
        {
            [buttonsArray addObject:inDestructiveItem];
            NSInteger destIndex = [self addButtonWithTitle:inDestructiveItem.label];
            [self setDestructiveButtonIndex:destIndex];
        }
        if (inCancelButtonItem)
        {
            [buttonsArray addObject:inCancelButtonItem];
            NSInteger cancelIndex = [self addButtonWithTitle:inCancelButtonItem.label];
            [self setCancelButtonIndex:cancelIndex];
        }

        objc_setAssociatedObject(self, (__bridge const void *)(RI_BUTTON_ASS_KEY), buttonsArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

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

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != -1)
    {
        NSArray      *buttonsArray = objc_getAssociatedObject(self, (__bridge const void *)(RI_BUTTON_ASS_KEY));
        RIButtonItem *item         = [buttonsArray objectAtIndex:buttonIndex];
        if (item.action)
        {
            item.action();
        }
        objc_setAssociatedObject(self, (__bridge const void *)(RI_BUTTON_ASS_KEY), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

}


+(void) actionSheetWithTitle:(NSString*) title
                     message:(NSString*) message
                     buttons:(NSArray*) buttonTitles
                  showInView:(UIView*) view
                   onDismiss:(DismissBlock) dismissed                   
                    onCancel:(CancelBlock) cancelled
{    
    [UIActionSheet actionSheetWithTitle:title 
                                message:message 
                 destructiveButtonTitle:nil 
                                buttons:buttonTitles 
                             showInView:view 
                              onDismiss:dismissed 
                               onCancel:cancelled];
}

//+ (void) photoPickerWithTitle:(NSString*) title
//                   showInView:(UIView*) view
//                    presentVC:(UIViewController*) presentVC
//                onPhotoPicked:(PhotoPickedBlock) photoPicked                   
//                     onCancel:(CancelBlock) cancelled
//{
//    [_cancelBlock release];
//    _cancelBlock  = [cancelled copy];
//    
//    [_photoPickedBlock release];
//    _photoPickedBlock  = [photoPicked copy];
//    
//    [_presentVC release];
//    _presentVC = [presentVC retain];
//    
//    int cancelButtonIndex = -1;
//    
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title 
//                                                             delegate:(id)[self class] 
//													cancelButtonTitle:nil
//											   destructiveButtonTitle:nil
//													otherButtonTitles:nil];
//    
//	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//	{
//		[actionSheet addButtonWithTitle:NSLocalizedString(@"Camera", @"")];
//		cancelButtonIndex ++;
//	}
//	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
//	{
//		[actionSheet addButtonWithTitle:NSLocalizedString(@"Photo library", @"")];
//		cancelButtonIndex ++;
//	}
//    
//	[actionSheet addButtonWithTitle:NSLocalizedString(@"取消", @"")];
//	cancelButtonIndex ++;
//	
//    actionSheet.tag = kPhotoActionSheetTag;
//	actionSheet.cancelButtonIndex = cancelButtonIndex;		 
//    
//	if([view isKindOfClass:[UIView class]])
//        [actionSheet showInView:view];
//    
//    if([view isKindOfClass:[UITabBar class]])
//        [actionSheet showFromTabBar:(UITabBar*) view];
//    
//    if([view isKindOfClass:[UIBarButtonItem class]])
//        [actionSheet showFromBarButtonItem:(UIBarButtonItem*) view animated:YES];
//    
//    [actionSheet release];    
//}


//+ (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//	UIImage *editedImage = (UIImage*) [info valueForKey:UIImagePickerControllerEditedImage];
//    if(!editedImage)
//        editedImage = (UIImage*) [info valueForKey:UIImagePickerControllerOriginalImage];
//    
//    if (_photoPickedBlock) {
//        _photoPickedBlock(editedImage);
//    }
//    
//	[picker dismissViewControllerAnimated:YES completion:^{}];	
//	[picker autorelease];
//}
//
//
//+ (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    // Dismiss the image selection and close the program
//    [_presentVC dismissViewControllerAnimated:YES completion:^{}];    
//	[picker autorelease];
//    [_presentVC release];
//    
//    if (_cancelBlock) {
//        _cancelBlock();
//    }
//}


+ (void) actionSheetWithTitle:(NSString*) title                     
                      message:(NSString*) message          
       destructiveButtonTitle:(NSString*) destructiveButtonTitle
                      buttons:(NSArray*) buttonTitles
                   showInView:(UIView*) view
                    onDismiss:(DismissBlock) dismissed                   
                     onCancel:(CancelBlock) cancelled
{
    _cancelBlock  = [cancelled copy];
    
    _dismissBlock  = [dismissed copy];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title 
                                                             delegate:(id)[self class] 
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:destructiveButtonTitle 
                                                    otherButtonTitles:nil];
    
    for(NSString* thisButtonTitle in buttonTitles)
        [actionSheet addButtonWithTitle:thisButtonTitle];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"取消", @"")];
    actionSheet.cancelButtonIndex = [buttonTitles count];
    
    if(destructiveButtonTitle)
        actionSheet.cancelButtonIndex ++;
    
    if([view isKindOfClass:[UIView class]])
        [actionSheet showInView:view];
    
    if([view isKindOfClass:[UITabBar class]])
        [actionSheet showFromTabBar:(UITabBar*) view];
    
    if([view isKindOfClass:[UIBarButtonItem class]])
        [actionSheet showFromBarButtonItem:(UIBarButtonItem*) view animated:YES];
    
}

+(void)actionSheet:(UIActionSheet*) actionSheet didDismissWithButtonIndex:(NSInteger) buttonIndex
{
	if(buttonIndex == [actionSheet cancelButtonIndex]) {
        if (_cancelBlock) {
            _cancelBlock();
        }
	} else {
        if(actionSheet.tag == kPhotoActionSheetTag)
        {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                buttonIndex ++;
            }
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                buttonIndex ++;
            }
            
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = (id)[self class];
            picker.allowsEditing = YES;
            
            if(buttonIndex == 1)  {                
                picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
            else if(buttonIndex == 2) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;;
            }
            
            [_presentVC presentViewController:picker animated:YES completion:^{}];
        }
        else {
            if (_dismissBlock) {
                _dismissBlock((int)buttonIndex);
            }
        }
    }
    
    _cancelBlock = nil;
    _dismissBlock = nil;
}


@end
