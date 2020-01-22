//
//  MyAudioViewController.m
//  ZykjAppClient
//
//  Created by zoulixiang on 2019/3/6.
//  Copyright © 2019年 zoulixiang. All rights reserved.
//

#import "MyAudioViewController.h"
#import "SpectrumView.h"

@interface MyAudioViewController () {
}

@property (strong, nonatomic) MyAudioBtn *audioBtn;

@property (strong, nonatomic) MyAudioAuditionBtn *audioPlayBtn;

@property (strong, nonatomic) SpectrumView *spectrumView;


@property (strong, nonatomic)NSDictionary *currentFinishAudioInfos;               //当前完成录音的url

@end

@implementation MyAudioViewController

- (void)dealloc {
    [self.KVOController unobserveAll];
    [self.spectrumView stop];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

- (void)configContainer {
    [super configContainer];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (MyAudioHelp *)myAudioHelp {
    if (_myAudioHelp == nil) {
        WS(ws);
        _myAudioHelp = [[MyAudioHelp alloc] init];
        _myAudioHelp.maxTimeVideoBlock = ^{
            [ws endVideoAction];
        };
    }
    return _myAudioHelp;
}

- (void)setCurrentFinishAudioInfos:(NSDictionary *)currentFinishAudioInfos {
    _currentFinishAudioInfos = currentFinishAudioInfos;
      self.audioPlayBtn.fileUrl = (NSURL *)currentFinishAudioInfos[@"fileUrl"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    // 添加检测app进入后台的观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground:) name: UIApplicationDidEnterBackgroundNotification object:nil];
    
    // app从后台进入前台都会调用这个方法
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = YES;
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    self.navigationController.navigationBar.translucent = NO;
    
     [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

- (void)addOwnViews {
    [super addOwnViews];
   
    CGFloat spectrumWidth = 200.0;
    CGFloat spectrumHeight = 50.0;
    self.spectrumView = [[SpectrumView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.myContentView.bounds) - spectrumWidth / 2.0,(ScreenHeight - spectrumHeight) / 2.0 - 50.0,spectrumWidth, spectrumHeight)];
    self.spectrumView.text = nil;
     [self.myContentView addSubview:self.spectrumView];
    
    WS(ws);
    MyAudioBtn *audioBtn = [MyAudioBtn buttonWithType:UIButtonTypeCustom];
     [self.myContentView addSubview:audioBtn];
    _audioBtn = audioBtn;
    _audioBtn.audioHelp = self.myAudioHelp;
    
    MyAudioAuditionBtn *audioPlayBtn = [MyAudioAuditionBtn buttonWithType:UIButtonTypeCustom];
    [self.myContentView addSubview:audioPlayBtn];
    _audioPlayBtn = audioPlayBtn;
    
    [_audioBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70.0, 70.0));
        make.centerX.mas_equalTo(ws.myContentView.mas_centerX);
        make.bottom.mas_equalTo(ws.myContentView).mas_offset(-(30.0 + HT_TabbarSafeBottomMargin));
    }];
    
    [_audioPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70.0, 70.0));
        make.centerX.mas_equalTo(ws.myContentView.mas_centerX);
        make.bottom.mas_equalTo(ws.myContentView).mas_offset(-(30.0 + HT_TabbarSafeBottomMargin));
    }];
    
    [self adjustAudioBtnShow];
    
    
}
- (void)configOwnViews {
    [super configOwnViews];
    
    @weakify(self);
    self.view.backgroundColor = kBlackColor;
    
     self.KVOController = [FBKVOController controllerWithObserver:self];
    [self.KVOController observe:self.audioBtn keyPath:@"audioStatus" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
         @strongify(self);
        [self changeAudioStatus];
    }];
}

#pragma mark - 监听
- (void)changeAudioStatus {
    MyAudioBtnStatus audioStatus = self.audioBtn.audioStatus;
    if (audioStatus == MyAudioBtnStatusNoStart) {
         [self clearBarView];
    } else if (audioStatus == MyAudioBtnStatusStarting) {
        [self clearBarView];
    } else if (audioStatus == MyAudioBtnStatusPause) {
        [self configRightBarView];
    }
    
}

- (void)applicationEnterBackground:(NSNotification *)nf {
    if (!self.currentFinishAudioInfos && self.audioBtn.audioStatus == MyAudioBtnStatusStarting) {
        [self.audioBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

- (void)applicationBecomeActive:(NSNotification *)nf {
    if (!self.currentFinishAudioInfos) {
        [self.audioBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.myAudioHelp cancelAudio];
    [[MyAudioPlayHelp sharedInstance] stop];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
- (void)configRightBarView {
    WS(ws);
    if (!ws.currentFinishAudioInfos) {
        [self showRightBarButtonItemWithTitle:@"完成" withBlock:^(id sender) {
            //录音点完成
            [ws endVideoAction];
            
        }];
    } else {
        [self showRightBarButtonItemWithTitle:@"使用录音" withBlock:^(id sender) {
              [[MyAudioPlayHelp sharedInstance] stop];
            if (ws.finishBlock) {
                ws.finishBlock(ws.currentFinishAudioInfos);
            }
             [ws.navigationController dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    
    [self adjustAudioBtnShow];
}

- (void)configLeftBarView {
    WS(ws);
    [self showLeftBarButtonItemWithTitle:@"重新录音" withBlock:^(id sender) {
        [ws.myAudioHelp resetAudio];
        
    }];
    
    [self adjustAudioBtnShow];
}

- (void)clearBarView {
    //停止播放
    [[MyAudioPlayHelp sharedInstance] stop];
    self.currentFinishAudioInfos = nil;
    
    [self.navigationItem setLeftBarButtonItems:@[] animated:YES];
    [self.navigationItem setRightBarButtonItems:@[] animated:YES];
    
    [self adjustAudioBtnShow];
}

//点击完成结束录音
- (void)endVideoAction {
    self.currentFinishAudioInfos = [self.myAudioHelp finishAudio];
    [self configRightBarView];
    [self configLeftBarView];
}

//根据currentFinishAudioUrl调整按钮展示
- (void)adjustAudioBtnShow {
    WS(ws);
    if (self.currentFinishAudioInfos) {
        self.audioBtn.hidden = YES;
        self.audioPlayBtn.hidden = NO;
        self.spectrumView.itemLevelCallback = ^{
            AVAudioPlayer *soundPlayer = [MyAudioPlayHelp sharedInstance].soundPlayer;
            if (!soundPlayer) {
                //默认-160
                ws.spectrumView.level = -160.0;
                return;
            }
            [soundPlayer updateMeters];
            //取得第一个通道的音频，音频强度范围是-160到0
            float power= [soundPlayer averagePowerForChannel:0];
            ws.spectrumView.level = power;
        };
    } else {
        self.audioBtn.hidden = NO;
        self.audioPlayBtn.hidden = YES;
        self.spectrumView.itemLevelCallback = ^{
            AVAudioRecorder *audioRecorder = ws.myAudioHelp.audioRecorder;
            [audioRecorder updateMeters];
            //取得第一个通道的音频，音频强度范围是-160到0
            float power= [audioRecorder averagePowerForChannel:0];
            ws.spectrumView.level = power;
        };
    }
}


@end
