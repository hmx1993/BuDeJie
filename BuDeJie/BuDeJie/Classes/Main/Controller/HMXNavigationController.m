//
//  HMXNavigationController.m
//  BuDeJie
//
//  Created by hemengxiang on 16/3/31.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXNavigationController.h"

@interface HMXNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation HMXNavigationController

+(void)load
{
    [[UINavigationBar appearanceWhenContainedIn:self, nil] setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    //设置富文本属性
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    navBar.titleTextAttributes = attr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //一旦重写了返回按钮,系统的侧滑功能就没有了
    //滑动返回功能为什么会失效:用了滑动手势去做,验证滑动手势在不在?(pass不在)
    //猜测代理可以控制手势是否有效,验证:代理做了一些事情,导致滑动手势失效
    
    //下面两句打印验证了interactivePopGestureRecognizer的代理就是它被触发时的target
//    NSLog(@"%@",self.interactivePopGestureRecognizer.delegate);
//    NSLog(@"%@",self.interactivePopGestureRecognizer);
    
    //重置手势代理,恢复侧滑返回功能
//    self.interactivePopGestureRecognizer.delegate = self;
    
    //全屏侧滑(给导航控制器添加pan手势)
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    
    pan.delegate = self;
    
    [self.view addGestureRecognizer:pan];
    
    //让系统的手势失效
//    self.interactivePopGestureRecognizer.enabled = NO;
}


#pragma mark - 手势代理方法
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //当该控制器是根控制器的时候,就允许触发手势
    return self.childViewControllers.count > 1;
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

//重写Push方法,可以修改返回按钮的设置
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //如果不判断当前控制器是不是导航控制器的第一个子控制器,调用以下代码就会出现第一个控制器出现左侧有返回按钮的情况
//    viewController.view;
    
    if (self.childViewControllers.count > 0) {
        
        //在push之前隐藏即将push出来的控制器(根控制器除外)
        viewController.hidesBottomBarWhenPushed = YES;
        
        //设置push进来的控制器的返回按钮的样式(点击会显示红色,因此可以是按钮)
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:@"返回" forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        //设置按钮的的尺寸
        //    [button sizeToFit];
        //也可以设置size(点语法来自于分类)
        button.size = CGSizeMake(70, 30);
        
        //让按钮的内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //让按钮的内容向前移动一定的距离
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 0);
        
        //返回按钮修改失败,对"左侧"的按钮下手
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        //监听按钮点击
        [button addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
      
    }
    
    //在最后调用super可以让相应的控制器重新设置返回按钮的内容,因为这个push方法之后,等控制器的View加载完毕的时候还会调用viewDidLoad方法,可以让控制器自由设置
    [super pushViewController:viewController animated:animated];
}

//返回按钮被点击的时候调用
-(void)leftBtnClick
{
    //跳转到上一级
    [self popViewControllerAnimated:YES];
}

@end
