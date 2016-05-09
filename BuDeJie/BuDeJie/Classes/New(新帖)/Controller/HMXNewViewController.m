//
//  HMXNewViewController.m
//  BuDeJie
//
//  Created by hemengxiang on 16/3/12.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXNewViewController.h"
#import "HMXSubTagViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "HMXTipicsItem.h"
#import "SVProgressHUD.h"
#import "HMXTopicCell.h"
#import "HMXDIYHeader.h"
#import "HMXRefreshHeader.h"

#import "HMXHTTPSessionManager.h"
#import "MJRefresh.h"
@interface HMXNewViewController ()

/** 存放模型的数组 */
@property(nonatomic,strong)NSMutableArray *topicsArray;
/** 上一页的最大值 */
@property(nonatomic,strong)NSString *maxtime;
@property(nonatomic,strong)HMXHTTPSessionManager *manager;
@end



static NSString * const ID = @"HMXTopicCellID";

@implementation HMXNewViewController
/**
 *  该服务器不允许上拉和下拉同时存在
 */


-(HMXHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [HMXHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置标题
    self.navigationItem.title = @"幽默天地";
    //设置左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" heighLightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick:)];
    
    self.view.backgroundColor = globleBg;
    
    //处理tableView的细节
    [self dealTableView];
    
    //添加刷新控件
    [self setUpRefresh];
    
    //监听通知
    [self setUpNotification];
}

#pragma mark - ButtonClick

-(void)tagClick:(UIButton *)btn
{
    //跳转到订阅标签控制器
    HMXSubTagViewController *subTag = [[HMXSubTagViewController alloc] init];
    
    [self.navigationController pushViewController:subTag animated:YES];
}



#pragma mark - 处理tableView的细节
-(void)dealTableView
{
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"HMXTopicCell" bundle:nil] forCellReuseIdentifier:ID];
    
    //取消tableView的分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置tableView的背景色
    self.tableView.backgroundColor = globleBg;
}

#pragma mark - 通知相关
-(void)setUpNotification
{
    //监听TabBarButton被重复点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonRepeatClick) name:HMXTabBarButtonRepeatClickNotification object:nil];
    //监听TitleButton被重复点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonRepeatClick) name:HMXTitleButtonRepeatClickNotification object:nil];
    
}
//当tabBarButton被重复点击了之后调用
-(void)tabBarButtonRepeatClick
{
    //判断,如果当前控制器不在窗口上,那么就直接返回(排除点击其他模块的tabBarButton也会刷新)
    if (self.tableView.window == nil) return;
    
    //排除当点击视频,声音等其他控制器的时候也进入刷新转态
    if (self.tableView.scrollsToTop == NO) return;
    
    //进入下拉刷新
    [self.tableView.mj_header beginRefreshing];
}

//当titleButtonRepeatClick被重复点击了后调用
-(void)titleButtonRepeatClick
{
    //判断,如果当前控制器不在窗口上,那么就直接返回(排除点击其他模块的tabBarButton也会刷新)
    if (self.tableView.window == nil) return;
    
    //排除当点击视频,声音等其他控制器的时候也进入刷新转态
    if (self.tableView.scrollsToTop == NO) return;
    
    //进入下拉刷新
    [self.tableView.mj_header beginRefreshing];
}

//一定要记得移除通知
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 加载帖子
-(void)loadNewTopics
{
    //取消manager当前所有的任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //结束刷新(可以不写),请求被取消后,会进到loadMoreTopics的failure的这个block里面,这个里面已经将调用了footerEndRefreshing
    //    [self footerEndRefreshing];
    
    //创建请求参数
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"newlist";
    parame[@"c"] = @"data";
    
    //发送请求
    [self.manager GET:HMXRequestUrl parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {//成功
        
        HMXAFNWriteToPlist(000)
        
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数组
        self.topicsArray = [HMXTipicsItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [self.tableView reloadData];
        
        //header结束刷新
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {//失败
        
        //header结束刷新
        [self.tableView.mj_header endRefreshing];
        
        //如果是取消了请求,就不显示错误信息
        if(error.code == NSURLErrorCancelled) return;
        
        //提示用户错误信息
        [SVProgressHUD showErrorWithStatus:@"网络繁忙,请稍后再试!"];
    }] ;
}

-(void)loadMoreTopics
{
    //取消manager当前所有的任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //结束刷新(可以不写),请求被取消后,会进到loadNewTopics的failure的这个block里面,这个里面已经将调用了headerEndRefreshing
    //    [self headerEndRefreshing];
    
    //创建请求参数
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"newlist";
    parame[@"c"] = @"data";
    parame[@"maxtime"] = self.maxtime;
    
    //发送请求
    [self.manager GET:HMXRequestUrl parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {//成功
        
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典数组->模型数组
        NSArray *more = [HMXTipicsItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topicsArray addObjectsFromArray:more];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        
        //如果需要提示用户没有更多数据的时候用这个方法
        //        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {//失败
        
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        
        //如果是取消了请求,就不显示错误信息
        if(error.code == NSURLErrorCancelled) return;
        
        //提示用户错误信息
        [SVProgressHUD showErrorWithStatus:@"网络繁忙,请稍后再试!"];
    }];
}

#pragma mark - 添加刷新控件
-(void)setUpRefresh
{
    //添加下拉刷新
    self.tableView.mj_header = [HMXRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    //立即进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
    //添加上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
    self.tableView.mj_footer.backgroundColor = [UIColor cyanColor];
}


-(void)test
{
    NSLog(@"加载数据");
}

#pragma mark - 代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //清除缓存
    [[SDImageCache sharedImageCache] clearMemory];
}

#pragma mark - tableView的数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //如果数组为空,则隐藏footer
    self.tableView.mj_footer.hidden = self.topicsArray.count == 0;
    return self.topicsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMXTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //取出对应的模型
    HMXTipicsItem *topics = self.topicsArray[indexPath.row];
    //给cell赋值
    cell.topics = topics;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取出对应的模型
    HMXTipicsItem *topics = self.topicsArray[indexPath.row];
    return topics.cellHeight;
}

@end


