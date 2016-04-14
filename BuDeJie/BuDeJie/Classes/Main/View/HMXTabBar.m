//
//  HMXTabBar.m
//  BuDeJie
//
//  Created by hemengxiang on 16/3/27.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXTabBar.h"

@interface HMXTabBar ()
@property(nonatomic,strong)UIButton *plusBtn;
/** 上一次点击的TabBarButton  */
@property(nonatomic,strong)UIControl *PreClickedTabBarButton;

@end

@implementation HMXTabBar

//在初始化HMXTabBar的时候添加加号按钮
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加加号按钮
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.plusBtn = plusBtn;
        //设置按钮的图片
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        
        //添加加号按钮
        [self addSubview:plusBtn];
    }
    return self;
}


//布局子控件的位置
-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置发布按钮的frame
    self.plusBtn.bounds = CGRectMake(0, 0, self.plusBtn.currentBackgroundImage.size.width, self.plusBtn.currentBackgroundImage.size.height);
    self.plusBtn.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    //遍历自己当前所拥有的所有子控件,设置其他UITabBarButton的位置
    CGFloat height = self.height;
    CGFloat width = self.width / 5.0;
    CGFloat y = 0;
    NSInteger index = 0;
   
    for (UIControl *btn in self.subviews) {
        if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            //如果该btn对应第一个精华控制器,那么就给PreClickedTabBarButton赋值,因为程序一进来相当于是点击了第一个UITabBarButton
            //因为layoutSubviews这个方法的调用可能会很多次,因此我们要考虑当一个方法被执行很多次的时候会出现什么情况,如果该方法被执行很多次,那么就会来到这里给 self.PreClickedTabBarButton重新赋值,又设置为精华控制器所对应的UITabBarButton,如果上一次点击了新帖对应的按钮,这一次再点击就会失效,所以还要加一个判断,就是当self.PreClickedTabBarButton有值的时候,就不重新赋值
            if (index == 0 && self.PreClickedTabBarButton == nil) {
                self.PreClickedTabBarButton = btn;
            }
            //改变尺寸
            //如果按钮的角标大于1,就让它显示往后面一个位置显示,给发布按钮留出位置来
            btn.frame = CGRectMake(width * ((index > 1)?(index + 1):index), y, width, height);
            index++;
            
            //监听UITabBarButton的点击
            [btn addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}
//当UITabbarButton被点击之后调用
-(void)tabBarButtonClick:(UIControl *)tabBarButton
{
    if (tabBarButton == self.PreClickedTabBarButton)
    {
        //重复点击了按钮之后应该让对应的显示在窗口上的控制器刷新,而这个事情应该让对应的控制器去做,所以我们在这里只需要发通知给相应的控制器就可以了,不能使用代理和block的原因是代理和block只能设置一个,而在这里,我们可能要让多个控制器进行刷新,因此选择通知
        [[NSNotificationCenter defaultCenter] postNotificationName:HMXTabBarButtonRepeatClickNotification object:nil];
    }
    self.PreClickedTabBarButton = tabBarButton;
}
@end
