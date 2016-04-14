//
//  HMXNewViewController.m
//  BuDeJie
//
//  Created by hemengxiang on 16/3/12.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXNewViewController.h"
#import "HMXSubTagViewController.h"
@interface HMXNewViewController ()

@end

@implementation HMXNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    self.navigationItem.title = @"百思不得姐";
    //设置左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" heighLightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick:)];
    
    self.view.backgroundColor = globleBg;
}

-(void)tagClick:(UIButton *)btn
{
    //跳转到订阅标签控制器
    HMXSubTagViewController *subTag = [[HMXSubTagViewController alloc] init];
    
    [self.navigationController pushViewController:subTag animated:YES];
}

@end
