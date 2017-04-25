//
//  CustomEntryViewController.m
//  WatchPTLose
//
//  Created by Alexander Skorulis on 25/4/17.
//  Copyright © 2017 Alex Skorulis. All rights reserved.
//

#import "CustomEntryViewController.h"
#import "ThemeService.h"
#import "PTService.h"
@import Masonry;
@import FontAwesomeKit;

@interface CustomEntryViewController ()

@end

@implementation CustomEntryViewController {
    UITextField *_textField;
    UIButton *_winButton;
    UIButton *_lossButton;
    UIButton *_cancelButton;
}

- (instancetype)init {
    self = [super init];
    
    FAKIcon *icon = [FAKFontAwesome dollarIconWithSize:24];
    UIImage *image = [icon imageWithSize:CGSizeMake(34, 34)];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"custom bet" image:image tag:0];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _textField = [[UITextField alloc] init];
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.layer.borderColor = [UIColor blackColor].CGColor;
    _textField.layer.borderWidth = 2;
    _textField.placeholder = @"Bet amount";
    [self.view addSubview:_textField];
    
    _winButton = [[UIButton alloc] init];
    [_winButton setTitle:@"Win" forState:UIControlStateNormal];
    [_winButton setBackgroundImage:[ThemeService sharedInstance].upButtonBackground forState:UIControlStateNormal];
    [_winButton addTarget:self action:@selector(winPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_winButton];
    
    _lossButton = [[UIButton alloc] init];
    [_lossButton setTitle:@"Loss" forState:UIControlStateNormal];
    [_lossButton setBackgroundImage:[ThemeService sharedInstance].downButtonBackground forState:UIControlStateNormal];
    [_lossButton addTarget:self action:@selector(lossPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_lossButton];
    
    _cancelButton = [[UIButton alloc] init];
    [_cancelButton setTitle:@"Close" forState:UIControlStateNormal];
    [_cancelButton setBackgroundImage:[ThemeService sharedInstance].greyButtonBackground forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelButton];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(30);
        make.height.equalTo(@44);
    }];
    
    [_winButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_centerX);
        make.top.equalTo(_textField.mas_bottom).offset(20);
        make.height.equalTo(@44);
    }];
    
    [_lossButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view.mas_centerX);
        make.top.equalTo(_textField.mas_bottom).offset(20);
        make.height.equalTo(@44);
    }];
    
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_lossButton.mas_bottom).offset(20);
        make.height.equalTo(@44);
    }];
}


- (void)winPressed:(id)sender {
    NSInteger amount = _textField.text.integerValue;
    if (amount == 0) {
        return;
    }
    [[PTService sharedInstance] addWin:amount];
    _textField.text = nil;
}

- (void)lossPressed:(id)sender {
    NSInteger amount = _textField.text.integerValue;
    if (amount == 0) {
        return;
    }
    [[PTService sharedInstance] addWin:-amount];
    _textField.text = nil;
}

- (void)cancelPressed:(id)sender {
    [_textField resignFirstResponder];
}


@end
