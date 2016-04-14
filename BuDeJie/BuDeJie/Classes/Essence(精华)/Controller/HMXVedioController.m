//
//  HMXVedioController.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/9.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXVedioController.h"

@interface HMXVedioController ()

@end

@implementation HMXVedioController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(HMXNavMaxY + HMXTitlesViewHeight , 0, HMXTabBarHeight, 0);
    //设置滚动条的边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //监听通知
    [self setUpNotification];
}

#pragma mark - 通知相关
-(void)setUpNotification
{
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonRepeatClick) name:HMXTabBarButtonRepeatClickNotification object:nil];
}
//当tabBarButton被重复点击了之后调用
-(void)tabBarButtonRepeatClick
{
    //判断,如果当前控制器不在窗口上,那么就直接返回(排除点击其他模块的tabBarButton也会刷新)
    if (self.tableView.window == nil) return;
    
    //排除当点击视频,声音等其他控制器的时候也进入刷新转态
    if (self.tableView.scrollsToTop == NO) return;
    
    //进入下拉刷新
    NSLog(@"headerBeginRefreshing");

}

//一定要记得移除通知
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSString *text = [NSString stringWithFormat:@"%@---%zd",[self class],indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.text = text;
    
    return cell;
}

@end
