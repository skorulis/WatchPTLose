//  Created by Alexander Skorulis on 24/04/2016.
//  Copyright © 2016 Alex Skorulis. All rights reserved.

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import <Underscore.m/Underscore.h>
#import "PTService.h"

@interface ViewController ()

@end

@implementation ViewController {
    UIStackView *_topStack;
    UIStackView *_bottomStack;
    
    NSArray<UIButton*> *_topButtons;
    NSArray<UIButton*> *_bottomButtons;
    PTService *_service;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _service = [[PTService alloc] init];
    
    NSArray *amounts = @[@5,@10,@20,@50,@100];
    _topButtons = Underscore.array(amounts).map(^UIButton *(NSNumber *amount) {
        UIButton *b = [self makeButton:amount];
        [b addTarget:self action:@selector(winPressed:) forControlEvents:UIControlEventTouchUpInside];
        return b;
    }).unwrap;
    
    _bottomButtons = Underscore.array(amounts).map(^UIButton *(NSNumber *amount) {
        UIButton *b = [self makeButton:amount];
        [b addTarget:self action:@selector(losePressed:) forControlEvents:UIControlEventTouchUpInside];
        return b;
    }).unwrap;
    
    
    _topStack = [[UIStackView alloc] initWithArrangedSubviews:_topButtons];
    _topStack.alignment = UIStackViewAlignmentCenter;
    _topStack.axis = UILayoutConstraintAxisHorizontal;
    _topStack.distribution = UIStackViewDistributionFillEqually;
    [self.view addSubview:_topStack];
    
    _bottomStack = [[UIStackView alloc] initWithArrangedSubviews:_bottomButtons];
    _bottomStack.alignment = UIStackViewAlignmentCenter;
    _bottomStack.axis = UILayoutConstraintAxisHorizontal;
    _bottomStack.distribution = UIStackViewDistributionFillEqually;
    [self.view addSubview:_bottomStack];
    
    [self buildLayout];
}

- (UIButton *)makeButton:(NSNumber *)amount {
    UIButton *b = [[UIButton alloc] init];
    b.tag = amount.intValue;
    NSString *title = [NSString stringWithFormat:@"$%i",amount.intValue];
    [b setTitle:title forState:UIControlStateNormal];
    [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return b;
}

- (void)buildLayout {
    [_topStack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(40);
    }];
    
    [_bottomStack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop).with.offset(-40);
    }];
}

- (void)winPressed:(UIButton *)sender {
    [_service addWin:sender.tag];
    NSLog(@"Win %ld",_service.totalWin);
}

- (void)losePressed:(UIButton *)sender {
    [_service addWin:-sender.tag];
    NSLog(@"Win %ld",_service.totalWin);
}

@end
