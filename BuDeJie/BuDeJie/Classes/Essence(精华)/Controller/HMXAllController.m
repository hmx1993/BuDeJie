
//
//  HMXAllController.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/9.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXAllController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "HMXTipicsItem.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface HMXAllController ()

/** 存放模型的数组 */
@property(nonatomic,strong)NSMutableArray *topicsArray;
/** 上一页的最大值 */
@property(nonatomic,strong)NSString *maxtime;
/** 上拉刷新控件 */
@property(nonatomic,weak)UILabel *footer;
/** 上拉刷新控件的刷新状态 */
@property(nonatomic,assign)BOOL footerRefreshing;
/** 下拉刷新控件 */
@property(nonatomic,weak)UILabel *header;
/** 下拉刷新控件的刷新状态 */
@property(nonatomic,assign)BOOL headerRefreshing;
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@end

@implementation HMXAllController
/**
 *  该服务器不允许上拉和下拉同时存在
 */

-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(HMXNavMaxY + HMXTitlesViewHeight , 0, HMXTabBarHeight, 0);
    //设置滚动条的边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;

    //添加刷新控件
    [self setUpRefresh];
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
    parame[@"a"] = @"list";
    parame[@"c"] = @"data";
    parame[@"type"] = @(31);
    
    //发送请求
    [self.manager GET:HMXRequestUrl parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {//成功
        
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数组
        self.topicsArray = [HMXTipicsItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
       
        //刷新表格
        [self.tableView reloadData];
        
        //header结束刷新
        [self headerEndRefreshing];
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {//失败
        
        //header结束刷新
        [self headerEndRefreshing];
        
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
    parame[@"a"] = @"list";
    parame[@"c"] = @"data";
    parame[@"maxtime"] = self.maxtime;
    parame[@"type"] = @(31);
    
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
        [self footerEndRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {//失败
        
        //结束刷新
        [self footerEndRefreshing];
        
        //如果是取消了请求,就不显示错误信息
        if(error.code == NSURLErrorCancelled) return;
        
        //提示用户错误信息
        [SVProgressHUD showErrorWithStatus:@"网络繁忙,请稍后再试!"];
    }];
}

#pragma mark - 添加刷新控件
-(void)setUpRefresh
{
    //添加上拉刷新
    UILabel *footer = [[UILabel alloc] init];
    footer.height = 35;
    footer.text = @"上拉加载更多";
    footer.textAlignment = NSTextAlignmentCenter;
    footer.backgroundColor = [UIColor redColor];
    self.tableView.tableFooterView = footer;
    self.footer = footer;
    
    //添加下拉刷新
    UILabel *header = [[UILabel alloc] init];
    header.height = 50;
    header.frame = CGRectMake(0, -header.height, self.tableView.width, header.height);
    header.text = @"下拉可以刷新";
    header.textAlignment = NSTextAlignmentCenter;
    header.backgroundColor = [UIColor redColor];
    [self.tableView addSubview:header];
    self.header = header;
    
    //立即进入刷新状态
    [self headerBeginRefreshing];
}

#pragma mark - footer
/**
 处理footer
 */
-(void)dealFooter
{
    //如果数组为空,就直接返回
    if (self.topicsArray.count == 0) return;
    
    //如果正在刷新,就直接返回
    if(self.footerRefreshing == YES) return;
    
    //如果偏移量大于一定的值,就进入上拉刷新状态
    CGFloat offset = self.tableView.contentSize.height + HMXTabBarHeight - self.tableView.height;
    
    if (self.tableView.contentOffset.y >= offset) {
        
        //进入刷新状态
        [self footerBeginRefreshing];
    }

}
/**
 *  footer进入刷新状态
 */
-(void)footerBeginRefreshing
{
    //如果正在执行下拉刷新,那么上拉刷新就不做(不允许上拉和下拉同时存在)
//    if (self.headerRefreshing == YES) return;
    //第二种做法是,让下拉刷新别做,做上拉刷新(也就是取消manager当前的所有任务,在加载帖子的方法中实现)
    
    //如果在某些情况下直接调用这个方法,那么就要避免重复调用这个方法,因此要判断是否正在刷新,如果是,就直接返回
    if (self.footerRefreshing == YES) return;
    
    self.footerRefreshing = YES;
    self.footer.text = @"正在刷新,请稍后!";
    self.footer.backgroundColor = [UIColor blueColor];
    [self loadMoreTopics];
}
/**
 *  footer结束刷新
 */
-(void)footerEndRefreshing
{
    self.footerRefreshing = NO;
    self.footer.text = @"上拉加载更多数据";
    self.footer.backgroundColor = [UIColor redColor];
}
#pragma mark - header
/**
 处理header
 */
-(void)dealHeader
{
    //如果header还没有被创建,直接返回
    if (self.header == nil) return;
    
    //如果正在刷新,直接返回
    if(self.headerRefreshing == YES) return;
    
    //当偏移量小于某个值得时候,显示其他状态
    CGFloat headerOffset = -(self.tableView.contentInset.top + self.header.height);
    
    if (self.tableView.contentOffset.y <= headerOffset)
    {
        self.header.text = @"松开立即刷新";
        self.header.backgroundColor = [UIColor purpleColor];
    }else
    {
        self.header.text = @"下拉可以刷新";
        self.header.backgroundColor = [UIColor redColor];
    }

}

/**
 *  header进入刷新状态
 */
-(void)headerBeginRefreshing
{
    //如果正在进行上拉刷新,那么下拉刷新就不做了
//    if (self.footerRefreshing == YES) return;
    //第二种做法是,让上拉刷新别做,做下拉刷新(也就是取消manager当前的所有任务,在加载帖子的方法中实现)
    
    //如果点击tabelView的某一行,会直接调用这个方法,但是多次点击就会多次来到这个方法,因此,要避免在刷新的时候再次进入到这个方法
    if (self.headerRefreshing == YES) return;
    
    //进入刷新状态
    self.headerRefreshing = YES;
    self.header.text = @"正在刷新,请稍后...";
    self.header.backgroundColor = [UIColor blueColor];
    
    //增大内边距
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top += self.header.height;
        self.tableView.contentInset = inset;
        
        //增大偏移量
        CGPoint offset = self.tableView.contentOffset;
        offset = CGPointMake(0, - self.tableView.contentInset.top);
        self.tableView.contentOffset = offset;
    }];
    //发请求
    [self loadNewTopics];

}
/**
 *  header结束刷新
 */
-(void)headerEndRefreshing
{
    //恢复刷新控件的状态
    self.headerRefreshing = NO;
    
    //减小内边距
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top -= self.header.height;
        self.tableView.contentInset = inset;
        
    }];
}

#pragma mark - 监听tableView的滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self dealFooter];
    [self dealHeader];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //如果正在刷新,直接返回
    if (self.headerRefreshing == YES) return;
   
    CGFloat headerOffset = -(self.tableView.contentInset.top + self.header.height);
    
    if (self.tableView.contentOffset.y <= headerOffset)
    {
        //header进入刷新状态
        [self headerBeginRefreshing];
    }
}

#pragma mark - tableView的数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //如果数组为空,则隐藏footer
    self.footer.hidden = (self.topicsArray.count == 0);
    return self.topicsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    //取出对应的模型
    HMXTipicsItem *topics = self.topicsArray[indexPath.row];
    
    //给cell赋值
    cell.textLabel.text = topics.name;
    
    cell.detailTextLabel.text = topics.text;
    return cell;
}
#pragma mark - tableView的代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //模拟,当选中某一行的时候,发送请求加载最新数据
    [self headerBeginRefreshing];
}

@end
