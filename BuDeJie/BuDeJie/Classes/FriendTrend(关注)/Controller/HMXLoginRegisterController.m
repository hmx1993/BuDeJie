//
//  HMXLoginRegisterController.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/6.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXLoginRegisterController.h"
#import "HMXLoginRegisterView.h"
#import "HMXFastLogin.h"
@interface HMXLoginRegisterController ()
//注册,登录的View
@property (weak, nonatomic) IBOutlet UIView *loginRegisterView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftToView;
//快速登录
@property (weak, nonatomic) IBOutlet UIView *fastLoginView;

@end

@implementation HMXLoginRegisterController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建HMXLoginRegisterView
    //登录
    HMXLoginRegisterView *loginView = [HMXLoginRegisterView loginView];
    [self.loginRegisterView addSubview:loginView];
    
    //注册
    HMXLoginRegisterView *registerView= [HMXLoginRegisterView registerView];
    [self.loginRegisterView addSubview:registerView];
    
    //快速登录
    HMXFastLogin *fastLogin = [HMXFastLogin fastLogin];
    [self.fastLoginView addSubview:fastLogin];
}

//1.从Xib中加载的View一定要设置它的位置和尺寸 2.一定要在ViewDidLayoutSubviews中设置
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //设置registerView的frame
    HMXLoginRegisterView *loginView = self.loginRegisterView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.loginRegisterView.width * 0.5, self.loginRegisterView.height);
    
    //设置loginView的frame
    HMXLoginRegisterView *registerView = self.loginRegisterView.subviews[1];
    registerView.frame = CGRectMake(self.loginRegisterView.width * 0.5, 0, self.loginRegisterView.width * 0.5, self.loginRegisterView.height);
    
    //设置快速登陆view的frame
    HMXFastLogin *fastLogin = self.fastLoginView.subviews[0];
    fastLogin.frame = CGRectMake(0, 0, self.fastLoginView.width, self.fastLoginView.height);
}

//点击了"关闭"
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//点击了"注册账号"
- (IBAction)clickRegister:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    //修改loginRegisterView左边的约束
    self.leftToView.constant = (self.leftToView.constant == 0)? - HMXScreenW : 0 ;
    
    //刷新
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

//点击屏幕退出键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
