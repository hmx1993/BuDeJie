//
//  HMXMeViewController.m
//  BuDeJie
//
//  Created by hemengxiang on 16/3/12.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXMeViewController.h"

@interface HMXMeViewController ()

@end

@implementation HMXMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置标题
    self.navigationItem.title = @"我的";
    
    //添加设置按钮
    UIButton *Btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [Btn1 setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [Btn1 setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    
    //添加夜间模式设置按钮
    UIButton *Btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [Btn2 setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [Btn2 setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
    
    //设置按钮自适应
    [Btn1 sizeToFit];
    [Btn2 sizeToFit];
    
    //监听按钮的点击
    [Btn1 addTarget:self action:@selector(nightModeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [Btn2 addTarget:self action:@selector(settingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:Btn1];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:Btn2];
    
    //添加Items
    NSArray *itemArray = @[item1,item2];
    self.navigationItem.rightBarButtonItems = itemArray;
}

-(void)settingBtnClick:(UIButton *)btn
{
    HMXLog(@"设置按钮被点击了");
}
-(void)nightModeBtnClick:(UIButton *)btn
{
    HMXLog(@"夜间模式按钮被点击了");
}

@end
