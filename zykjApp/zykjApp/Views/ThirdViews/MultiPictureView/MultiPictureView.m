//
//  MultiPictureView.m
//  Hdys
//
//  Created by air on 15/7/16.
//  Copyright (c) 2015年 air. All rights reserved.
//

#import "MultiPictureView.h"
#import "PictureView.h"
#import "UIView+Extension.h"
#import "ZLPickerBrowserViewController.h"
#import "ZLPickerCommon.h"
#import "ZLAnimationBaseView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ZLCameraViewController.h"
#import "ZLPickerViewController.h"
#import "TipView.h"

@interface MultiPictureView ()<PictureDelegate, ZLPickerBrowserViewControllerDataSource,ZLPickerBrowserViewControllerDelegate, ZLPickerViewControllerDelegate>
{
    NSMutableArray *imgViewArray;
    int imgIndex;
}

@property (nonatomic, assign) id<MultiPicDelegate> delegate;
@property (nonatomic, strong) UIViewController *currentVC;
@property (nonatomic, strong) PictureView *addView;
@property (nonatomic, strong) ZLPickerBrowserViewController *pickerBrowser;

@property (nonatomic, strong) ZLCameraViewController *cameraVc;

@end



@implementation MultiPictureView


- (void)createMultiPicView:(UIViewController *)viewCtrl delegate:(id<MultiPicDelegate>)delegate
{
    self.currentVC = viewCtrl;
    self.delegate = delegate;
    imgViewArray = [NSMutableArray array];
    _imageArray = [NSMutableArray array];
    imgIndex = 1;
    [self createAddImage];
}


- (void)createAddImage
{
    _addView = [[PictureView alloc] initWithFrame:CGRectMake(ROW_MARGIN, ROW_MARGIN, ITEM_WIDTH, ITEM_HEIGHT)];
    
    [_addView setImage:[UIImage imageNamed:@"add"] type:1];
    _addView.delegate = self;
    [self addSubview:_addView];
    [imgViewArray insertObject:_addView atIndex:0];
}


#pragma mark - PictureDelegate

// 添加图片
- (void)addPicture
{
    if (self.imageArray.count >= 9)
    {
        [TipView showTipView:@"最多只能添加9张图片"];
        return ;
    }
    
    ZLCameraViewController *cameraVc = [[ZLCameraViewController alloc] init];
    [cameraVc startCameraOrPhotoFileWithViewController:self.currentVC complate:^(id object) {
        [object enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSArray *array = [obj allValues];
                for (NSInteger i = 0; i < array.count; i++)
                {
                    ALAsset *asset = array[i];
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC));
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        // 添加图片
                        if ([asset isKindOfClass:[ALAsset class]]) {
                            [self addNewPic:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]];
                        }else if([asset isKindOfClass:[UIImage class]]){
                            [self addNewPic:(UIImage *)asset];
                        }
                    });
                }
                
            }else{
                ALAsset *asset = (ALAsset *)obj;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    // 添加图片
                    if ([asset isKindOfClass:[ALAsset class]]) {
                        [self addNewPic:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]];
                    }else if([asset isKindOfClass:[UIImage class]]){
                        [self addNewPic:(UIImage *)asset];
                    }
                });
            }
        }];
    }];
    
    self.cameraVc = cameraVc;
}

- (void)addNewPic:(UIImage *)img
{
    if (!img)
    {
        return ;
    }
    
    if (_imageArray.count >= 9) {
        [TipView showTipView:@"最多只能添加9张图片"];
        return;
    }

    
    //[_imageArray insertObject:img atIndex:0];   // 从前端添加
    [_imageArray addObject:img];                  // 从后端添加
    
    PictureView *pictureView = [[PictureView alloc] initWithFrame:self.addView.frame];
    [pictureView setImage:img type:0];
    pictureView.delegate = self;
    [self addSubview:pictureView];
    
    //[imgViewArray insertObject:pictureView atIndex:0];                     // 从前端添加
    [imgViewArray insertObject:pictureView atIndex:imgViewArray.count - 1];  // 从后端添加
    
    if (imgViewArray.count % ROW_NUM == 1)
    {
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(didAddPicEnd)])
        {
            [_delegate didAddPicEnd];
        }
    }
    
    for (NSInteger i = imgViewArray.count - 1; i >= 0; i--)
    {
        PictureView *subView = imgViewArray[i];
        CGRect frame = subView.frame;
        if (i % ROW_NUM == 0)   // 行末
        {
            frame.origin.x = ROW_MARGIN;
            frame.origin.y = (i + 1) / ROW_NUM * (ITEM_WIDTH + ROW_MARGIN) + ROW_MARGIN;
        }
        else
        {
            frame.origin.x = (i % ROW_NUM) * (ITEM_WIDTH + ROW_MARGIN) + ROW_MARGIN;
        }
        
        
        [UIView animateWithDuration:0.3 animations:^{
            [subView setFrame:frame];
        }];
    }
    
    pictureView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        pictureView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}


// 删除图片
- (void)delPicture:(PictureView *)pictureView
{
    NSInteger index = [imgViewArray indexOfObject:pictureView];
    [_imageArray removeObjectAtIndex:index];
    [UIView animateWithDuration:0.3 animations:^{
        pictureView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        pictureView.delegate = nil;
        [pictureView removeFromSuperview];
        [imgViewArray removeObject:pictureView];
    }];
    
    for (NSInteger i = index + 1; i < imgViewArray.count; i++)
    {
        PictureView *subView = imgViewArray[i];
        CGRect frame = subView.frame;
        if (i % ROW_NUM == 0)   // 行首
        {
            frame.origin.x = (ROW_NUM - 1) * (ITEM_WIDTH + ROW_MARGIN) + ROW_MARGIN;
            frame.origin.y = (i / ROW_NUM - 1) * (ITEM_WIDTH + ROW_MARGIN) + ROW_MARGIN;
        }
        else
        {
            frame.origin.x = ((i - 1) % ROW_NUM) * (ITEM_WIDTH + ROW_MARGIN) + ROW_MARGIN;
        }
        
        
        [UIView animateWithDuration:0.3 animations:^{
            [subView setFrame:frame];
        }];
    }
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.33 * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if (imgViewArray.count % ROW_NUM == 0)
        {
            if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(didDelPic)])
            {
                [_delegate didDelPic];
            }
        }
    });
}


- (void)showPicture:(PictureView *)pictureView
{
    NSInteger index = [imgViewArray indexOfObject:pictureView];
    // 图片游览器
    ZLPickerBrowserViewController *pickerBrowser = [[ZLPickerBrowserViewController alloc] init];
    pickerBrowser.toView = pictureView;
    // 数据源/delegate
    pickerBrowser.delegate = self;
    pickerBrowser.dataSource = self;
    // 是否可以删除照片
    pickerBrowser.editing = YES;
    // 当前选中的值
    pickerBrowser.currentPage = index;
    // 展示控制器
    [pickerBrowser show:_currentVC];
    self.pickerBrowser = pickerBrowser;
}


#pragma mark <ZLPickerBrowserViewControllerDataSource>
- (NSInteger) numberOfPhotosInPickerBrowser:(ZLPickerBrowserViewController *)pickerBrowser
{
    return self.imageArray.count;
}

- (ZLPickerBrowserPhoto *) photoBrowser:(ZLPickerBrowserViewController *)pickerBrowser photoAtIndex:(NSUInteger)index
{
    UIImage *image = self.imageArray[index];
    ZLPickerBrowserPhoto *photo = [ZLPickerBrowserPhoto photoAnyImageObjWith:image];
    photo.thumbImage = image;
    
    return photo;
}

#pragma mark <ZLPickerBrowserViewControllerDelegate>
- (void)photoBrowser:(ZLPickerBrowserViewController *)photoBrowser removePhotoAtIndex:(NSUInteger)index{
    /*if (index > self.imageArray.count) return;
    [self.imageArray removeObjectAtIndex:index];
    [self.tableView reloadData];*/
}


// 代理回调方法
- (void)pickerViewControllerDoneAsstes:(NSArray *)array{
    for (NSInteger i = 0; i < array.count; i++)
    {
        ALAsset *asset = array[i];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // 添加图片
            if ([asset isKindOfClass:[ALAsset class]]) {
                [self addNewPic:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]];
            }else if([asset isKindOfClass:[UIImage class]]){
                [self addNewPic:(UIImage *)asset];
            }
        });
    }
}

@end
