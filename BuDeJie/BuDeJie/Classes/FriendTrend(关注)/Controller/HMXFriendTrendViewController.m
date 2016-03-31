//
//  HMXFriendTrendViewController.m
//  BuDeJie
//
//  Created by hemengxiang on 16/3/12.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXFriendTrendViewController.h"

@interface HMXFriendTrendViewController ()

@end

@implementation HMXFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    //设置左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" heighLightImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick:)];
    self.view.backgroundColor = globleBg;

}

-(void)friendsClick:(UIButton *)btn
{
    HMXLog(@"我的关注左边按钮被点击");
}
@end
