//
//  HMXLoginRegisterView.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/6.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXLoginRegisterView.h"


@interface HMXLoginRegisterView ()

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end
@implementation HMXLoginRegisterView

//快速创建"登录"的View
+(instancetype)loginView
{
    return [[NSBundle mainBundle] loadNibNamed:@"HMXLoginRegisterView" owner:nil options:nil][1];
}

//快速创建"注册"的View
+(instancetype)registerView
{
    return [[NSBundle mainBundle] loadNibNamed:@"HMXLoginRegisterView" owner:nil options:nil][0];
}




-(void)awakeFromNib
{
    //设置按钮当前的背景图片不被拉伸
    UIImage *image = self.loginBtn.currentBackgroundImage;
    //返回一张不被拉伸的图片
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    //设置背景图片
    [self.loginBtn setBackgroundImage:image forState:UIControlStateNormal];
}


@end
