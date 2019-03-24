/*********************************************************************
 *            Copyright (C) 2011, 网龙天晴数码应用产品二部
 * @文件描述:其他一些宏定义(如视图宽高等)
 **********************************************************************
 *   Date        Name        Description
 *   2011/09/29  luzj        New
 *   2011/10/14  luzj        增加对于系统中界面元素大小的定义
 *********************************************************************/

// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

#define STATUSBAR_HEIGHT 20
#define NAVIGATION_HEIGHT 44

/**
 Create a UIColor with r,g,b values between 0.0 and 1.0.
 */
#define NDRGBCOLOR(r,g,b) \
[UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f]

/**
 Create a UIColor with r,g,b,a values between 0.0 and 1.0.
 */
#define NDRGBACOLOR(r,g,b,a) \
[UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]



//用于释放指针所指向的空间
#define ND_FREE_MEM(pData) \
if (pData != NULL) \
{\
free(pData);\
pData = NULL;\
}

//用于快速的实现弹出警告窗口
#define ND_ALERT_MSG(title, msg, btnmsg)\
UIAlertView *alertDialog;\
alertDialog = [[UIAlertView alloc] initWithTitle: title message:msg delegate: nil cancelButtonTitle: btnmsg otherButtonTitles: nil];\
[alertDialog show];\


//同步锁
#define SYNC_BLOCK_BEGIN(x)		@synchronized((x)) {
#define SYNC_BLOCK_END			}
#define SYNC_BLOCK_BEGIN_SELF	SYNC_BLOCK_BEGIN(self)


#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height

#define UIIMAGE_RESIZE(image)  [image stretchableImageWithLeftCapWidth:floorf(image.size.width / 2) topCapHeight:floorf(image.size.height / 2)]

