//
//  MyTextView.m
//  coreText-Label
//
//  Created by zoulixiang on 16/7/23.
//  Copyright © 2016年 zoulixiang. All rights reserved.
//

#import "MyTextView.h"
#import <CoreText/CoreText.h>

#define FontHeight                  13.0
#define ImageLeftPadding            2.0
#define ImageTopPadding             3.0
#define FontSize                    FontHeight
#define LineSpacing                 5.0
#define EmotionImageWidth           FontSize

//#define UIColorFromRGB(rgbValue) UIColorFromRGBA(rgbValue, 1.0)

// 翻转坐标系
static inline
void Flip_Context(CGContextRef context, CGFloat offset) // offset为字体的高度
{
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -offset);
}

@interface MyTextView (){
    
    
    NSMutableArray *_selectionsViews;
    
    CTTypesetterRef typesetter;
    CTFontRef helvetica;
    
     NSString *_newString;
}

@end

@implementation MyTextView


#pragma mark - 绘制
- (void)drawRect:(CGRect)rect {
    
    // 没有内容时取消本次绘制
    if (!typesetter)   return;
    
    CGFloat w = CGRectGetWidth(self.frame);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIGraphicsPushContext(context);
    
    CGFloat y = 0;
    CFIndex start = 0;
    NSInteger length = [_attrEmotionString length];
    int tempK = 0;
    NSValue *sizeValue;
   
    // 翻转坐标系
    sizeValue = [self isHavePic:typesetter start:start];
    if (sizeValue) {
        CGSize size = [sizeValue CGSizeValue];
         Flip_Context(context, size.height);
    } else {
       Flip_Context(context, FontHeight);
    }
    
    while (start < length){
        //每行显示的字数
        CFIndex count = CTTypesetterSuggestClusterBreak(typesetter, start, w);
        
        CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(start, count));
        CGContextSetTextPosition(context, 0, y);
        
        // 画字
        CTLineDraw(line, context);
        
        start += count;
        tempK ++;
     
        if (tempK == limitline) {
            _limitCharIndex = start;
            
        }
        
        sizeValue = [self isHavePic:typesetter start:start];
        if (sizeValue) {
            CGSize size = [sizeValue CGSizeValue];
            y -= size.height + LineSpacing;
        } else {
            y -= FontSize + LineSpacing;
        }
       
       
        CFRelease(line);

    }
    
    UIGraphicsPopContext();
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _selectionsViews = [NSMutableArray arrayWithCapacity:0];
        _canClickAll = YES;//默认可点击全部
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMyself:)];
        [self addGestureRecognizer:tapGes];
        
        _replyIndex = -1;//默认为-1 代表点击的是说说的整块区域
        
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)dealloc{
    
    if (typesetter != NULL) {
        
        CFRelease(typesetter);
    }
    
}

#pragma mark -

- (void)setNewString:(NSString *)newString {
    
    _newString = newString;
    _linkArray = [self matchWebLink:_newString];
    
    [self cookEmotionString];
}
- (void)cookEmotionString{
    
    _attrEmotionString = [self createAttributedWithString:_newString];
    typesetter = CTTypesetterCreateWithAttributedString((CFAttributedStringRef)
                                                        (_attrEmotionString));
    if (_imgRanges.count > 0) {
        [self increasePic];
    }
   
    if (_isDraw == NO) {
        // CFRelease(typesetter);
        return;
    }
    
    [self setNeedsDisplay];

}

#pragma mark -
/**
 *  根据调整后的字符串，生成绘图时使用的 attribute string
 *
 *  @param ranges  占位符的位置数组
 *  @param aString 替换过含有如[em:02:]的字符串
 *
 *  @return 富文本String
 */
- (NSAttributedString *)createAttributedWithString:(NSString*)aString {

    //创建attributeString
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:aString];
    helvetica = CTFontCreateWithName(CFSTR("Helvetica"),FontSize, NULL);
    [attrString addAttribute:(id)kCTFontAttributeName value: (id)CFBridgingRelease(helvetica) range:NSMakeRange(0,[attrString.string length])];
    
    if (_defaultColor == nil) {
        _defaultColor = UIColorFromRGB(0x939393);
    }
    [attrString addAttribute:(id)kCTForegroundColorAttributeName value:(id)(_defaultColor.CGColor) range:NSMakeRange(0,[attrString length])];

    if (_textColor == nil) {
        _textColor = UIColorFromRGB(0x2a2a2a);
    }
    
    NSArray *array = _rangeDict[_strTag];
    
    //给关键str加颜色
    if (array && array.count > 0) {
        for (NSValue *value in array) {
            NSRange range = [value rangeValue];
            [attrString addAttribute:(id)kCTForegroundColorAttributeName value:(id)(_textColor.CGColor) range:range];
        }
    }
    
    //链接
    if (_linkArray && _linkArray.count > 0) {
        for (NSValue *value in _linkArray) {
            NSRange range = [value rangeValue];
            [attrString addAttribute:(id)kCTForegroundColorAttributeName value:(id)(kLinkColor.CGColor) range:range];
        }
    }
    if (_imgRanges.count > 0) {
        //图文
        for (int i = 0; i < _imgRanges.count; i++) {
            NSValue *value = _imgRanges[i];
            NSRange range = [value rangeValue];
            
            [attrString addAttribute:AttributedImageSizeKey value:_sizeArray[i] range:range];
            [attrString addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)newEmotionRunDelegate(_sizeArray[i]) range:range];
        }
    }
    
    return attrString;

}

CTRunDelegateRef newEmotionRunDelegate(id value){
    
    if (value ==nil) {
        value = @"emotionRunName";
    }
    
    CTRunDelegateCallbacks imageCallbacks;
    imageCallbacks.version = kCTRunDelegateVersion1;
    imageCallbacks.dealloc = WFRunDelegateDeallocCallback;
    imageCallbacks.getAscent = WFRunDelegateGetAscentCallback;
    imageCallbacks.getDescent = WFRunDelegateGetDescentCallback;
    imageCallbacks.getWidth = WFRunDelegateGetWidthCallback;
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&imageCallbacks,
                                                       (__bridge void *)(value));
    return runDelegate;
}

#pragma mark - Run delegate
void WFRunDelegateDeallocCallback( void* refCon ){
    // CFRelease(refCon);
}

CGFloat WFRunDelegateGetAscentCallback( void *refCon ){
    
    NSValue *value = (__bridge NSValue *)(refCon);
   
    if ([value isKindOfClass:[value class]]) {
        CGSize size = [value CGSizeValue];
        return (size.height/size.width) * (ScreenWidth - 2 * offSet_x);
    }
    return FontSize;
    
}

CGFloat WFRunDelegateGetDescentCallback(void *refCon){
    return 0.0;
}

CGFloat WFRunDelegateGetWidthCallback(void *refCon){
    
    return ScreenWidth - 2 * offSet_x;
}


#pragma mark -点击自己
- (void)tapMyself:(UITapGestureRecognizer *)gesture{
    
    [_selectionsViews removeAllObjects];
    [self manageGesture:gesture gestureType:TapGesType];
   
}

- (void)manageGesture:(UIGestureRecognizer *)gesture gestureType:(GestureType)gestureType{
    
    CGPoint point = [gesture locationInView:self];
    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat y = 0;
    CFIndex start = 0;
    NSInteger length = [_newString length];
    
    BOOL isSelected = NO;//判断是否点到selectedRange内 默认没点到
    
    while (start < length){
    
        CFIndex count = CTTypesetterSuggestClusterBreak(typesetter, start, w);
        CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(start, count));
        CGFloat ascent, descent;
        CGFloat lineWidth = CTLineGetTypographicBounds(line, &ascent, &descent, NULL);
        
        CGRect lineFrame = CGRectMake(0, -y, lineWidth, ascent + descent);
        
        if (CGRectContainsPoint(lineFrame, point)) { //没进此判断 说明没点到文字 ，点到了文字间距处
            
            //得到坐标点所在的相应的字的位置(index是第几个字)
            CFIndex index = CTLineGetStringIndexForPosition(line, point);
            if ([self judgeIndexInSelectedRange:index withWorkLine:line] == YES) {//点到selectedRange内
                
                isSelected = YES;
                
            }else{
                //点在了文字上 但是不在selectedRange内
                
            }
            

        }
        start += count;
        y -= FontSize + LineSpacing;
        CFRelease(line);
    }
    
    if (isSelected == YES) {
        DELAYEXECUTE(0.3, [_selectionsViews makeObjectsPerformSelector:@selector(removeFromSuperview)];);
        return;
    }else{
        if (gestureType == TapGesType) {
            if (_canClickAll == YES) {
                
                [self clickAllContext];
                
            }else{
                
            }
            
        }
        return;
        
    }
    
    DELAYEXECUTE(0.3, [_selectionsViews makeObjectsPerformSelector:@selector(removeFromSuperview)]);

}

- (BOOL)judgeIndexInSelectedRange:(CFIndex) index withWorkLine:(CTLineRef)workctLine{
    
    NSArray *array = _rangeDict[_strTag];
    
    //给关键str加颜色
    if (array && array.count > 0) {
        for (NSValue *value in array) {
            NSRange keyRange = [value rangeValue];
            if (index>=keyRange.location && index<= keyRange.location + keyRange.length) {
                
                NSMutableArray *arr = [self getSelectedCGRectWithClickRange:keyRange];
                [self drawViewFromRects:arr withDictValue:nil];
               
                if (_delegate && [_delegate respondsToSelector:@selector(clickMyCoretext:object:)]) {
                    [_delegate clickMyCoretext:[array indexOfObject:value]  object:self.object];
                }
                return YES;
            }

        }
    }
    
    if (_linkArray && _linkArray.count > 0) {
      
        for (NSValue *value in _linkArray) {
            NSRange keyRange = [value rangeValue];
            if (index>=keyRange.location && index<= keyRange.location + keyRange.length) {
                
                NSMutableArray *arr = [self getSelectedCGRectWithClickRange:keyRange];
                [self drawViewFromRects:arr withDictValue:nil];
                
                if (_delegate && [_delegate respondsToSelector:@selector(clickMyCoretextLink:)]) {
//                    [_delegate clickMyCoretext:[array indexOfObject:value]  object:self.object];
                    NSString *oldLink = [_newString substringWithRange:keyRange];
                    NSString *link = ([oldLink rangeOfString:@"http://"].location == NSNotFound) ?
                    [NSString stringWithFormat:@"http://%@",oldLink] : oldLink;
                    [_delegate clickMyCoretextLink:link];
                }
                return YES;
            }
            
        }
 
    }
    return NO;

}

- (NSMutableArray *)getSelectedCGRectWithClickRange:(NSRange)tempRange{
    
    NSMutableArray *clickRects = [[NSMutableArray alloc] init];
    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat y = 0;
    CFIndex start = 0;
    NSInteger length = [_attrEmotionString length];
    
    while (start < length){
        
        CFIndex count = CTTypesetterSuggestClusterBreak(typesetter, start, w);
        CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(start, count));
        start += count;
        
        //得到每行的range
        CFRange lineRange = CTLineGetStringRange(line);
        
        NSRange range = NSMakeRange(lineRange.location==kCFNotFound ? NSNotFound : lineRange.location, lineRange.length);
        NSRange intersection = [self rangeIntersection:range withSecond:tempRange];
        
        if (intersection.length > 0){
            
            CGFloat xStart = CTLineGetOffsetForStringIndex(line, intersection.location, NULL);//获取整段文字中charIndex位置的字符相对line的原点的x值
            CGFloat xEnd = CTLineGetOffsetForStringIndex(line, intersection.location + intersection.length, NULL);
            
            CGFloat ascent, descent;
            //,leading;
            CTLineGetTypographicBounds(line, &ascent, &descent, NULL);
            CGRect selectionRect = CGRectMake(xStart, -y, xEnd -  xStart , ascent + descent + 2);//所画选择之后背景的 大小 和起始坐标 2为微调
            [clickRects addObject:NSStringFromCGRect(selectionRect)];
            
        }
        y -= FontSize + LineSpacing;
        CFRelease(line);

    }
     return clickRects;
}

//超出1行 处理
- (NSRange)rangeIntersection:(NSRange)first withSecond:(NSRange)second{
    
    NSRange result = NSMakeRange(NSNotFound, 0);
    if (first.location > second.location){
        
        NSRange tmp = first;
        first = second;
        second = tmp;
    }
    if (second.location < first.location + first.length){
        
        result.location = second.location;
        NSUInteger end = MIN(first.location + first.length, second.location + second.length);
        result.length = end - result.location;
    }
    return result;
}

- (void)drawViewFromRects:(NSArray *)array withDictValue:(NSString *)value{
    //用户名可能超过1行的内容 所以记录在数组里，有多少元素 就有多少view
    // selectedViewLinesF = array.count;
    
    for (int i = 0; i < [array count]; i++) {
        
        UIView *selectedView = [[UIView alloc] init];
        selectedView.frame = CGRectFromString([array objectAtIndex:i]);
        selectedView.backgroundColor = kUserName_SelectedColor;
        selectedView.layer.cornerRadius = 4;
        [self addSubview:selectedView];
        [_selectionsViews addObject:selectedView];
        
    }
    
}

- (void)clickAllContext{
    
    UIView *myselfSelected = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    myselfSelected.tag = 10102;
    [self insertSubview:myselfSelected belowSubview:self];
    myselfSelected.backgroundColor = kSelf_SelectedColor;
    if (_delegate && [_delegate respondsToSelector:@selector(clickMycoretextAll:)]) {
        [_delegate clickMycoretextAll:self.object];
    }
    DELAYEXECUTE(0.3, {
        if ([self viewWithTag:10102]) {
            [[self viewWithTag:10102] removeFromSuperview];
        }
    });
    
}

- (CGFloat )getTextHeight {
    
    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat y = 0;
    CFIndex start = 0;
    NSInteger length = [_attrEmotionString length];
     int tempK = 0;
    NSValue *sizeValue;
    
    while (start < length){
        
        CFIndex count = CTTypesetterSuggestClusterBreak(typesetter, start, w);
        CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(start, count));
       
        sizeValue =  [self isHavePic:typesetter start:start];
        if (sizeValue) {
            CGSize size = [sizeValue CGSizeValue];
            y -= size.height + LineSpacing;
        } else {
            y -= FontSize + LineSpacing;
        }

//        y -= FontSize + LineSpacing;
        start += count;
        tempK++;
        if (tempK == limitline  && _isFold == YES) {
            
            break;
        }

        CFRelease(line);
    }
    
    return -y;
    
}

#pragma mark - 获得行数
- (int)getTextLines{
    
    int textlines = 0;
    CGFloat w = CGRectGetWidth(self.frame);
   // CGFloat y = 0;
    CFIndex start = 0;
    NSInteger length = [_attrEmotionString length];
    
    while (start < length){
        
        CFIndex count = CTTypesetterSuggestClusterBreak(typesetter, start, w);
        CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(start, count));
        start += count;
        //y -= FontSize + LineSpacing;
        CFRelease(line);
        
        textlines ++;
    }
    return textlines;
    
}


#pragma mark -添加方法
//判断改行有无图片
- (NSValue *)isHavePic:(CTTypesetterRef)tempTypesetter start:(CFIndex)start {
    
    if (!tempTypesetter) {
        return nil;
    }
    CGFloat w = CGRectGetWidth(self.frame);
    CFIndex count = CTTypesetterSuggestClusterBreak(tempTypesetter, start, w);
    CTLineRef line = CTTypesetterCreateLine(tempTypesetter, CFRangeMake(start, count));
    
    CFArrayRef runs = CTLineGetGlyphRuns(line);
    
    // 统计有多少个run
    NSUInteger runCount = CFArrayGetCount(runs);
    
    for(NSInteger i = 0; i < runCount; i++){
        CTRunRef aRun = CFArrayGetValueAtIndex(runs, i);
        CFDictionaryRef attributes = CTRunGetAttributes(aRun);
        NSValue *emojiName = (NSValue *)CFDictionaryGetValue(attributes, AttributedImageSizeKey);
        if (emojiName) {
           // CGSize size = CGSizeMake(ScreenWidth - 2 * offSet_x,(emojiName.height/emojiName.width) * (ScreenWidth - 2 * offSet_x) )
            CGSize size = [emojiName CGSizeValue];
            CGSize finalSize = CGSizeMake(ScreenWidth - 2 * offSet_x,(size.height/size.width) * (ScreenWidth - 2 * offSet_x));
            return [NSValue valueWithCGSize:finalSize];
        }
    }
    
    return nil;
    
}

- (void)increasePic {
    
    
    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat y = 0;
    CFIndex start = 0;
    NSInteger length = [_newString length];
    NSValue *sizeValue;
    _picViewArray = @[].mutableCopy;

    while (start < length){
        
        CFIndex count = CTTypesetterSuggestClusterBreak(typesetter, start, w);
        CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(start, count));
        
        sizeValue =  [self isHavePic:typesetter start:start];
        if (sizeValue) {
            CGSize size = [sizeValue CGSizeValue];
            UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -y, size.width, size.height)];
            picView.clipsToBounds = YES;
            picView.contentMode = UIViewContentModeScaleAspectFill;
            [self addSubview:picView];
            [self.picViewArray addObject:picView];
            y -= size.height + LineSpacing;
            
        } else {
            y -= FontSize + LineSpacing;
        }
        
        //        y -= FontSize + LineSpacing;
        start += count;
        
        CFRelease(line);
    }

    
}

- (NSMutableArray *)matchWebLink:(NSString *)pattern{
    
    // NSLog(@"go here? go here? go here ?");
    
    NSMutableArray *linkArr = [NSMutableArray arrayWithCapacity:0];
    
    NSRegularExpression*regular=[[NSRegularExpression alloc]initWithPattern:@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)" options:NSRegularExpressionDotMatchesLineSeparators|NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray* array=[regular matchesInString:pattern options:0 range:NSMakeRange(0, [pattern length])];
    
    for( NSTextCheckingResult * result in array){
        
        [linkArr addObject:[NSValue valueWithRange:result.range]];
    }
    // NSLog(@"linkArr == %@",linkArr);
    return linkArr;
    
}

@end
