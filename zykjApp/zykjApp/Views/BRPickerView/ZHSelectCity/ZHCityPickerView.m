//
//  ZHCityPickerView.m
//  CityPickerView
//
//  Created by Admin on 16/7/8.
//  Copyright © 2016年 王海军. All rights reserved.
//

#import "ZHCityPickerView.h"

#define kDuration 0.25
#define kToobarHeight 44
#define kPickerViewH 216
#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ZHCityToolBar : UIToolbar

@end

@implementation ZHCityToolBar

- (void)layoutSubviews {
    [super layoutSubviews];
    
}
@end

@interface ZHCityPickerView () <UIPickerViewDelegate, UIPickerViewDataSource> {
    NSInteger rSelectOneRow;
    NSInteger rSelectTwoRow;
    NSInteger rSelectThreeRow;
}

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, assign) NSInteger pickeviewHeight;

/** 第一级选中的下标 **/
@property (assign, nonatomic) NSInteger selectOneRow;
/** 第二级选中的下标 **/
@property (assign, nonatomic) NSInteger selectTwoRow;
/** 第三级选中的下标 **/
@property (assign, nonatomic) NSInteger selectThreeRow;
/** 放PickerView 和 toolbar 的容器View **/
@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation ZHCityPickerView

- (void)setProvinceList:(NSArray *)provinceList {
    _provinceList = provinceList;
    [self loadInitData];
}

- (void)loadInitData {
    if (_cityModel) {
        NSInteger row = [self.provinceList findIndexForKey:@"area_id" findId:_cityModel.provinceId];
        row = row == NSNotFound ? 0 : row;
        self.selectOneRow = row;
        [self getCitydate:row];
        
        row = [self.cityList findIndexForKey:@"area_id" findId:_cityModel.cityId];
        row = row == NSNotFound ? 0 : row;
        self.selectTwoRow = row;
        [self getAreaDate:row];
        
        row = [self.districtsList findIndexForKey:@"area_id" findId:_cityModel.districtId];
        row = row == NSNotFound ? 0 : row;
        self.selectThreeRow = row;
        
          [self.pickerView selectRow:self.selectOneRow inComponent:0 animated:NO];
         [self.pickerView selectRow:self.selectTwoRow inComponent:1 animated:NO];
         [self.pickerView selectRow:self.selectThreeRow inComponent:2 animated:NO];
    } else {
        [self getCitydate:0];
        [self getAreaDate:0];
    }
}
- (instancetype)initWithDelegate:(id <ZHCityPickerViewDelegate>)delegate isHaveNavControler:(BOOL)isHaveNavControler
{
    if (self = [super init]) {
        self.delegate = delegate;
        
        //        if (!self.provinceList) {
        //             [self getCityListJSON];//获取数据
        //        }
        [self initBackView];
        [self setUpPickerView];
        
        [self setFrameWith:isHaveNavControler];
       
       
    }
    return self;
}

- (void)initBackView{
    
    //初始化背景视图，添加手势
    self.frame = CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT);
    self.backgroundColor =  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [self addGestureRecognizer:tapGesture];
}

- (void)setUpPickerView
{
    UIView *pickBackGroundView = [[UIView alloc] initWithFrame:
                                    CGRectMake(0, UISCREEN_HEIGHT - kToobarHeight - kPickerViewH, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    pickBackGroundView.backgroundColor = [UIColor whiteColor];
    self.backgroundView = pickBackGroundView;
    [self addSubview:pickBackGroundView];
    
//    ZHCityToolBar *toolbar = [[ZHCityToolBar alloc] init];
//    toolbar.frame = CGRectMake(0, 0, UISCREEN_WIDTH, kToobarHeight);
//    UIBarButtonItem *lefttem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(remove)];
//    UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
//    toolbar.items = @[lefttem,centerSpace,right];
//    [self.backgroundView addSubview:toolbar];
    
    UIView *toolbar =  [[UIView alloc] init];
    toolbar.frame = CGRectMake(0, 0, UISCREEN_WIDTH, kToobarHeight);
    toolbar.backgroundColor = kBRToolBarColor;
    [self.backgroundView addSubview:toolbar];
   
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 8, 60, 28);
    leftButton.backgroundColor = kBRToolBarColor;
    leftButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    //        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f * kScaleFit];
    leftButton.titleLabel.font = BaesFont(17.0);
    [leftButton setTitleColor:kDefaultThemeColor forState:UIControlStateNormal];
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    [toolbar addSubview:leftButton];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(toolbar.frame.size.width - 60, 8, 60, 28);
    rightBtn.backgroundColor = kBRToolBarColor;
    rightBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
    //        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f * kScaleFit];
    rightBtn.titleLabel.font =  BaesFont(17.0);
    [rightBtn setTitleColor:kDefaultThemeColor forState:UIControlStateNormal];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
    [toolbar addSubview:rightBtn];
    
    UIPickerView *pickView = [[UIPickerView alloc] init];
    pickView.backgroundColor = [UIColor whiteColor];
    _pickerView = pickView;
    CGFloat pickerViewH = pickView.frame.size.height;
    pickView.delegate = self;
    pickView.dataSource = self;
    pickView.frame = CGRectMake(0, kToobarHeight, UISCREEN_WIDTH, pickerViewH);
    _pickeviewHeight = pickView.frame.size.height;
    [self.backgroundView addSubview:pickView];
    
    [UIView animateWithDuration:kDuration animations:^{
        [self.backgroundView setFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    } completion:^(BOOL finished) {
    }];
}

-(void)setFrameWith:(BOOL)isHaveNavControler {
    CGFloat backgroundViewX = 0;
    CGFloat backgroundViewH = kPickerViewH + kToobarHeight;
    CGFloat backgroundViewY ;
    if (isHaveNavControler) {
        backgroundViewY = UISCREEN_HEIGHT - backgroundViewH - 64;
    }else {
        backgroundViewY= UISCREEN_HEIGHT - backgroundViewH;
    }
    CGFloat backgroundViewW = UISCREEN_WIDTH;
    self.backgroundView.frame = CGRectMake(backgroundViewX, backgroundViewY, backgroundViewW, backgroundViewH);
}

- (void)getCityListJSON
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sys_region" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSDictionary *regions = dict[@"Regions"];
    NSArray *provinceList = regions[@"provinces"];
    
    self.provinceList = provinceList;
}

- (void)getCitydate:(NSInteger)row {
    
    NSMutableArray *cityList = [[NSMutableArray alloc] init];
//    NSLog(@"%@",self.provinceList[row][@"city_data"]);
    for (NSArray *cityArr in self.provinceList[row][@"city_data"]) {
        [cityList addObject:cityArr];
    }
    self.cityList = cityList;
}

- (void)getAreaDate:(NSInteger)row{
    if (self.cityList.count == 0) {
        self.districtsList = nil;
        return;
    }
    NSMutableArray *districtsList = [[NSMutableArray alloc] init];
    for (NSArray *districtsArr in self.cityList[row][@"county_data"]) {
        [districtsList addObject:districtsArr];
    }
    self.districtsList = districtsList;
}

- (ZHCityPickerModel *)cityModel
{
    if (!_cityModel) {
        _cityModel = [[ZHCityPickerModel alloc] init];
    }
    return _cityModel;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        return self.provinceList.count;
    }else if (component == 1){
        return self.cityList.count;
    }else if (component == 2){
        return self.districtsList.count;
    }
    return 0;
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        
        self.selectOneRow = row;
        self.selectTwoRow = 0;
        self.selectThreeRow = 0;
        
        [self getCitydate:row];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        
        [self getAreaDate:0];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
    }
    if (component == 1){
        
        self.selectTwoRow = row;
        self.selectThreeRow = 0;
        
        [self getAreaDate:row];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
    }
    if (component == 2){
        
        self.selectThreeRow = row;
    }
    
    self.cityModel = nil;
    [self province];
    if (self.cityList.count > 0){
        
        [self city];
    }
    if (self.districtsList.count > 0 ){
        
        [self district];
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
        {
            [self province];
            return self.provinceList[row][@"area_name"];
        }
            break;
        case 1:
        {
            [self city];
            return self.cityList[row][@"area_name"];
        }
            break;
        case 2:
        {
            [self district];
            return self.districtsList[row][@"area_name"];
        }
            break;
        default:
            break;
    }
        return nil;
}

- (void)province
{
    self.cityModel.province = self.provinceList[self.selectOneRow][@"area_name"];
    self.cityModel.provinceId = self.provinceList[self.selectOneRow][@"area_id"];
}

- (void)city
{
    self.cityModel.city = self.cityList[self.selectTwoRow][@"area_name"];
    self.cityModel.cityId = self.cityList[self.selectTwoRow][@"area_id"];
}

- (void)district
{
    self.cityModel.district = self.districtsList[self.selectThreeRow][@"area_name"];
    self.cityModel.districtId = self.districtsList[self.selectThreeRow][@"area_id"];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark - actions

-(void)remove {
    
    [self tappedCancel];
}

- (void)doneClick
{
    if ([self.delegate respondsToSelector:@selector(pickerDidChange:)]) {
        [self.delegate pickerDidChange:self.cityModel];
    }
    [self tappedCancel];
}

#pragma mark - animation

- (void)showInView:(UIView *) view
{
    [view addSubview:self];
}

- (void)cancelPicker
{
    [self tappedCancel];
}

- (void)tappedCancel
{
    [UIView animateWithDuration:kDuration animations:^{
        [self.backgroundView setFrame:CGRectMake(0, UISCREEN_HEIGHT, UISCREEN_WIDTH, 0)];
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}


@end
