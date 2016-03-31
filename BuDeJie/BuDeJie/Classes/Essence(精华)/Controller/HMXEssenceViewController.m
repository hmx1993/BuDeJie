//
//  HMXEssenceViewController.m
//  BuDeJie
//
//  Created by hemengxiang on 16/3/12.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXEssenceViewController.h"
#import "TestViewController.h"
@interface HMXEssenceViewController ()

@end

@implementation HMXEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //设置左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage :@"MainTagSubIcon" heighLightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick:)];
    self.view.backgroundColor = globleBg;
    
}

-(void)tagClick:(UIButton *)btn
{
    HMXLog(@"左边的按扭被点击了");
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TestViewController *test = [[TestViewController alloc] init];
    test.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:test animated:YES];
}


@end
