//  Created by Alexander Skorulis on 24/04/2016.
//  Copyright © 2016 Alex Skorulis. All rights reserved.

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import <Underscore.m/Underscore.h>
#import "PTService.h"
#import "ThemeService.h"

@interface ViewController ()

@end

@implementation ViewController {
    UIStackView *_topStack;
    UIStackView *_bottomStack;
    
    NSArray<UIButton*> *_topButtons;
    NSArray<UIButton*> *_bottomButtons;
    
    UIImageView *_stateImageView;
    UILabel *_winLossLabel;
    
    PTService *_service;
    ThemeService *_theme;
}

- (instancetype)init {
    self = [super init];
    _service = [PTService sharedInstance];
    _theme = [ThemeService sharedInstance];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"gambling" image:nil tag:0];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray *amounts = @[@5,@10,@20,@50,@100];
    _topButtons = Underscore.array(amounts).map(^UIButton *(NSNumber *amount) {
        UIButton *b = [self makeButton:amount];
        [b setBackgroundImage:_theme.upButtonBackground forState:UIControlStateNormal];
        [b addTarget:self action:@selector(winPressed:) forControlEvents:UIControlEventTouchUpInside];
        return b;
    }).unwrap;
    
    _bottomButtons = Underscore.array(amounts).map(^UIButton *(NSNumber *amount) {
        UIButton *b = [self makeButton:amount];
        [b setBackgroundImage:_theme.downButtonBackground forState:UIControlStateNormal];
        [b addTarget:self action:@selector(losePressed:) forControlEvents:UIControlEventTouchUpInside];
        return b;
    }).unwrap;
    
    
    _topStack = [[UIStackView alloc] initWithArrangedSubviews:_topButtons];
    _topStack.alignment = UIStackViewAlignmentFill;
    _topStack.axis = UILayoutConstraintAxisHorizontal;
    _topStack.distribution = UIStackViewDistributionFillEqually;
    _topStack.spacing = 10;
    [self.view addSubview:_topStack];
    
    _bottomStack = [[UIStackView alloc] initWithArrangedSubviews:_bottomButtons];
    _bottomStack.alignment = UIStackViewAlignmentFill;
    _bottomStack.axis = UILayoutConstraintAxisHorizontal;
    _bottomStack.distribution = UIStackViewDistributionFillEqually;
    _bottomStack.spacing = 10;
    [self.view addSubview:_bottomStack];
    
    _stateImageView = [[UIImageView alloc] init];
    _stateImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_stateImageView];
    
    _winLossLabel = [[UILabel alloc] init];
    _winLossLabel.font = [UIFont boldSystemFontOfSize:24];
    [self.view addSubview:_winLossLabel];
    [self updateState];
    [self buildLayout];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:kChangeNotification object:nil];
}

- (UIButton *)makeButton:(NSNumber *)amount {
    UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    b.tag = amount.intValue;
    NSString *title = [NSString stringWithFormat:@"$%i",amount.intValue];
    [b setTitle:title forState:UIControlStateNormal];
    return b;
}

- (void)buildLayout {
    [_topStack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(20);
        make.height.equalTo(@40);
    }];
    
    [_bottomStack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop).with.offset(-10);
        make.height.equalTo(@40);
    }];
    
    [_stateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topStack.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(_winLossLabel.mas_top);
    }];
    
    [_winLossLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(_bottomStack.mas_top).with.offset(-40);
        make.height.equalTo(@40);
    }];
}

- (void)updateState {
    NSInteger win = [_service totalWin];
    _stateImageView.image = [_service imageForAmount:win];
    _winLossLabel.text = [NSString stringWithFormat:@"$%d",(int)ABS(win)];
    _winLossLabel.textColor = [_theme colorForAmount:win];
}

- (void)winPressed:(UIButton *)sender {
    [_service addWin:sender.tag];
}

- (void)losePressed:(UIButton *)sender {
    [_service addWin:-sender.tag];
}

- (void)change:(id)sender {
    [self updateState];
}

@end
