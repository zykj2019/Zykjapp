//
//  BaseEmptyView.m
//  zykjApp
//
//  Created by DeerClass on 2020/1/22.
//  Copyright © 2020 zoulixiang. All rights reserved.
//

#import "BaseEmptyView.h"
#import "UITableView+custom.h"


@implementation BaseEmptyItem

- (instancetype)initWithTitle:(NSString *)title emptyImage:(UIImage *)emptyImage resetRequestBlock:(CommonVoidBlock)resetRequestBlock {
    if (self = [super init]) {
        self.title = title;
        self.emptyImage = emptyImage;
        self.resetRequestBlock = resetRequestBlock;
    }
    return self;
}

@end

@implementation BaseEmptyTableViewCell

- (void)addOwnViews {
    [super addOwnViews];
    
    [self createLblName:@"titleLbl" font:BaesFont(14.0) color:WCGRAYFONT text:nil];
    _titleLbl.numberOfLines = 0;
    _titleLbl.textAlignment = NSTextAlignmentCenter;
    
    [self createImgView:@"imgView" img:nil];
    
}

- (void)configOwnViews {
    [super configOwnViews];

    self.backgroundColor = kWhiteColor;
    
}
- (void)setBaseEmptyItem:(BaseEmptyItem *)baseEmptyItem {
    _baseEmptyItem = baseEmptyItem;
    _titleLbl.text = baseEmptyItem.title;
    _imgView.image = baseEmptyItem.emptyImage;
    
    [_imgView resetMyLayoutSetting];
    [_titleLbl resetMyLayoutSetting];
       
       if (_imgView.image) {
           _imgView.mySize = [_imgView.image maxWidth:self.width];
           _imgView.myTop = 5.0;
           _imgView.myCenterY = 0;
           
           _titleLbl.topPos.equalTo(self.imgView.bottomPos).offset(25.0);
           _titleLbl.myCenterY = 0;
           _titleLbl.myBottom = 5.0;
       } else {
           
           _titleLbl.leftPos.equalTo(@20);
            _titleLbl.rightPos.equalTo(@20);
           _titleLbl.myHeight = MyLayoutSize.wrap;
              _titleLbl.topPos.equalTo(@60);
            _titleLbl.bottomPos.equalTo(@20);
           
       }
    
}

//- (void)updateConstraints {
//    [super updateConstraints];
//
//
//
//    self.backgroundColor = kRedColor;
//
//}

- (void)layoutIfNeeded {
    [super layoutIfNeeded];
    
    NSLog(@"%@----%@",NSStringFromCGRect(self.titleLbl.superview.superview.frame),self.titleLbl.superview);
     self.backgroundColor = kRedColor;
}
@end




@implementation BaseEmptyView

+ (instancetype)initWithBaseEmptyItem:(BaseEmptyItem *)item {
    BaseEmptyView *baseEmptyView = [BaseEmptyView new];
    baseEmptyView.backgroundColor = kWhiteColor;
    baseEmptyView.estimatedRowHeight = 60;
    baseEmptyView.rowHeight = UITableViewAutomaticDimension;
    baseEmptyView.baseEmptyItem = item;
    baseEmptyView.delegate = baseEmptyView;
    baseEmptyView.dataSource = baseEmptyView;
    return baseEmptyView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseEmptyTableViewCell *cell = [BaseEmptyTableViewCell cellWithTableView:tableView];
    cell.baseEmptyItem = self.baseEmptyItem;
    NSLog(@"%.2f",tableView.width);
//    [cell layouts];
    CGSize size = [cell.rootLayout sizeThatFits:CGSizeMake(tableView.frame.size.width, 0)];
   
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
       return UITableViewAutomaticDimension;
}
@end
