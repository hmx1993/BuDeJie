//
//  HMXFriendTrendViewController.m
//  BuDeJie
//
//  Created by hemengxiang on 16/3/12.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXFriendTrendViewController.h"
#import "HMXRecommendViewController.h"
#import "HMXLoginRegisterController.h"
#import <UIImage+GIF.h>
@interface HMXFriendTrendViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *dongtuImageView;

@end

@implementation HMXFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    //设置左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" heighLightImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick:)];
    self.view.backgroundColor = globleBg;
    self.dongtuImageView.image = [UIImage sd_animatedGIFNamed:@"gaoxiao" ];
    

}


-(void)friendsClick:(UIButton *)btn
{
    //跳转到"推荐关注"控制器
    HMXRecommendViewController *recommend = [[HMXRecommendViewController alloc] init];
    recommend.view.backgroundColor = globleBg;
    
    [self.navigationController pushViewController:recommend animated:YES];
}

//点击了"立即登录注册"
- (IBAction)loginRegisterBtnClick:(id)sender {
    //modal出登录注册的控制器
    HMXLoginRegisterController *loginRegister = [[HMXLoginRegisterController alloc] init];
    
    [self presentViewController:loginRegister animated:YES completion:nil];
}
@end
