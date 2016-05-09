//
//  HMXEssenceViewController.m
//  BuDeJie
//
//  Created by hemengxiang on 16/3/12.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXEssenceViewController.h"
#import "HMXAllController.h"
#import "HMXVedioController.h"
#import "HMXPictureController.h"
#import "HMXVoiceController.h"
#import "HMXWordController.h"
#import "HMXTitlesButton.h"

@interface HMXEssenceViewController ()<UIScrollViewDelegate>

/** 上一个选中的按钮 */
@property(nonatomic,weak)HMXTitlesButton *preSelectedButton;
/** 红色指示器 */
@property(nonatomic,weak)UIView *indicatorView;
/** scrollView */
@property(nonatomic,weak)UIScrollView *scrollView;
/** 标题栏 */
@property(nonatomic,weak)UIView *titlesView;
@end

@implementation HMXEssenceViewController

#pragma mark ---初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setUpNav];
    
    //添加子控制器
    [self addChildViewVcs];
    
    //添加ScrollView
    [self addScrollView];
    
    //添加标题栏
    [self addTitlesView];
    
    //选中第一个按钮
    [self selectTheFirstButton];
    
    //加载第0个控制器对应的tableView
    [self addTableViewToScrollView:0];
}

#pragma mark --- 初始化方法
//设置导航栏
-(void)setUpNav
{
    //设置标题
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.title = @"幽默天地";
    //设置左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage :@"MainTagSubIcon" heighLightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick:)];
    self.view.backgroundColor = globleBg;

}
//添加子控制器
-(void)addChildViewVcs
{
    //全部
    [self addChildViewController:[[HMXAllController alloc] init]];
    //视频
    [self addChildViewController:[[HMXVedioController alloc] init]];
    //声音
    [self addChildViewController:[[HMXVoiceController alloc] init]];
    //图片
    [self addChildViewController:[[HMXPictureController alloc] init]];
    //段子
    [self addChildViewController:[[HMXWordController alloc] init]];
}
//添加ScrollView
-(void)addScrollView
{
    //创建scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    scrollView.scrollsToTop = NO;
    
    //设置代理
    scrollView.delegate = self;
    
    scrollView.frame = self.view.bounds;
    
    //设置scrollView的属性
    NSInteger childVcsCount = self.childViewControllers.count;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(childVcsCount * scrollView.width, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsVerticalScrollIndicator = YES;
}

//添加标题栏
-(void)addTitlesView
{
    //添加titlesView
    UIView *titlesView = [[UIView alloc] init];
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    titlesView.frame = CGRectMake(0, HMXNavMaxY, HMXScreenW, HMXTitlesViewHeight);
    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    
    //添加标题按钮
    [self addTitlesButton];
    
    //红色指示器
    [self addIndicator];
}

//添加标题按钮
-(void)addTitlesButton
{
    //添加Button
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    NSInteger titlesCount = titles.count;
    for (NSInteger i = 0; i < titlesCount; i++) {
        
        HMXTitlesButton *button = [[HMXTitlesButton alloc] init];
        [self.titlesView addSubview:button];
        
        button.tag = i;
        
        //设置按钮标题
        [button setTitle:titles[i] forState:UIControlStateNormal];
        //设置frame
        CGFloat btnH = HMXScreenW / titlesCount;
        button.frame = CGRectMake(i * btnH, 0, btnH, HMXTitlesViewHeight);
        //添加点击事件
        [button addTarget:self action:@selector(titlesBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

//添加红色指示器
-(void)addIndicator
{
    //添加红色的指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    [self.titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
}

//添加tableView到scrollView
-(void)addTableViewToScrollView:(NSInteger)index
{
    UIView *childView = self.childViewControllers[index].view;
    
    //如果childView已经被加载了,那么就不需要再次添加
    if (childView.superview)  return;
    
    [self.scrollView addSubview:childView];
    
    //设置tableView的位置和尺寸
//    childView.frame = CGRectMake(index * self.scrollView.width,0, self.scrollView.width, self.scrollView.bounds.size.height);
    childView.frame = self.scrollView.bounds;
}

//选中第一个按钮
-(void)selectTheFirstButton
{
    HMXTitlesButton *firstButton = self.titlesView.subviews.firstObject;
    firstButton.selected = YES;
    //将当前按钮保存为上一个选中的按钮
    self.preSelectedButton = firstButton;
    
    //手动让按钮的titleLabel根据文字来计算尺寸
    //按钮的子控件是当即将显示的时候才去加载的
    [firstButton.titleLabel sizeToFit];
    
    //设置位置和尺寸
    //指示器的宽度 == 文字的宽度
    self.indicatorView.width = firstButton.titleLabel.width;
    self.indicatorView.height = 2;
    self.indicatorView.y = self.titlesView.height - self.indicatorView.height;
    self.indicatorView.centerX = firstButton.centerX;
}

#pragma mark ----监听按钮点击
-(void)titlesBtnClick:(HMXTitlesButton *)button
{
    //监听按钮的重复点击
    if(self.preSelectedButton == button)
    {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:HMXTitleButtonRepeatClickNotification object:nil];
    }
   
    //取消上一个按钮的选中状态
    self.preSelectedButton.selected = NO;
    //让当前按钮被选中
    button.selected = YES;
    //让当前按钮成为上一个选中的按钮
    self.preSelectedButton = button;
    
    //让红色指示器跟随被选中的按钮(带有动画)
    [UIView animateWithDuration:0.25 animations:^{
        
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
        //联动
        self.scrollView.contentOffset = CGPointMake(button.tag * self.scrollView.width, 0);
    } completion:^(BOOL finished) {
        //添加子控制的View到scrollView中
        [self addTableViewToScrollView:button.tag];
    }];
    
    //控制scrollView的scrollToTop属性
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        
        UIViewController *childViewController = self.childViewControllers[i];
        
        //如果控制器的View没有被创建,那么跳过
        if (!childViewController.isViewLoaded) continue;
       
        //如果不是scrollView类或者其子类,就直接返回
        if (![childViewController.view isKindOfClass:[UIScrollView class]]) continue;
        
        // 如果控制器的view是scrollView
        UIScrollView *scrollView = (UIScrollView *)childViewController.view;
        
        scrollView.scrollsToTop = (i == button.tag);
    }
}

-(void)tagClick:(UIButton *)btn
{
    
}

#pragma mark - scrollView的代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算当前偏移量对应的按钮角标
    NSInteger index = self.scrollView.contentOffset.x / self.scrollView.width;
    
    //选中按钮
    HMXTitlesButton *btn = [self.titlesView.subviews objectAtIndex:index];
    
    //如果上一次点击的按钮  和 这次想要点击的按钮 相同,那么直接返回(不然手松了之后回到原来的界面的情况下就相当于点击了重复点击某个按钮,这样会重新加载数据)
    if (self.preSelectedButton == btn) return;
    
     [self titlesBtnClick:btn];
    
}

@end
