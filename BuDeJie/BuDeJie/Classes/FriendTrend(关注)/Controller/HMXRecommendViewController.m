//
//  HMXRecommendViewController.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/1.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXRecommendViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "HMXHTTPSessionManager.h"
#import "HMXUsersCell.h"
#import "HMXCategoryCell.h"
#import "HMXRefreshHeader.h"
#import "CategoryItem.h"
#import "UserItem.h"
#import "SVProgressHUD.h"
@interface HMXRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 👈左边类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *CategoryTableView;
/** 👈左边类别模型数组 */
@property(nonatomic,strong)NSArray<CategoryItem *> *categoryItemArray;

/** 👉右边用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *usersTableView;
/** 👉右边用户模型数组 */
@property(nonatomic,strong)NSArray<UserItem *> *usersItemArray;

/** manager */
@property(nonatomic,weak)HMXHTTPSessionManager *manager;

@end

/** 👈类别表格cell的重用标识 */
static NSString *categoryCellId = @"categoryCellId";
/** 👉用户表格cell的重用标识 */
static NSString *usersCellId = @"usersCellId";

@implementation HMXRecommendViewController

#pragma mark - 懒加载
-(HMXHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [HMXHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置该控制器的标题
    self.navigationItem.title = @"推荐关注";
    
    //不让导航控制器自动给调整内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置tableView
    [self setUpTableView];
    
    //👈左边类别表格 - 加载数据
    [self loadCategoryData];
}

/**
 *  设置tableView
 */
-(void)setUpTableView
{
    //调整tableView和滚动条的内边距
    UIEdgeInsets inset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.CategoryTableView.contentInset = inset;
    self.CategoryTableView.scrollIndicatorInsets = inset;
    self.usersTableView.contentInset =inset;
    self.usersTableView.scrollIndicatorInsets = inset;
    
    //取消tableView的分隔线
    self.CategoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.usersTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //注册cell
    [self.CategoryTableView registerNib:[UINib nibWithNibName:@"HMXCategoryCell" bundle:nil] forCellReuseIdentifier:categoryCellId];
    [self.usersTableView registerNib:[UINib nibWithNibName:@"HMXUsersCell" bundle:nil] forCellReuseIdentifier:usersCellId];
    
    //设置数据源和代理
    self.CategoryTableView.dataSource = self;
    self.CategoryTableView.delegate = self;
    self.usersTableView.dataSource = self;
    self.usersTableView.delegate = self;
    
    //设置👉用户表格的行高
    self.usersTableView.rowHeight = 60;
    
    //添加刷新控件
    self.usersTableView.mj_header = [HMXRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
}

#pragma mark - 加载数据
/**
 *  👈类别表格-加载数据
 */
-(void)loadCategoryData
{
    //提示用户
    [SVProgressHUD showWithStatus:@"正在加载,请稍后..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];

    NSMutableDictionary *pareme = [NSMutableDictionary dictionary];
    pareme[@"a"] = @"category";
    pareme[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:pareme progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) { //请求成功
        
        //请求成功后将提示隐藏
        [SVProgressHUD dismiss];
        
        //字典数组->模型数组
        self.categoryItemArray = [CategoryItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新👈 类别表格
        [self.CategoryTableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { //请求失败
  
        //请求失败后将提示隐藏
        [SVProgressHUD dismiss];
        
    }];
}
/**
 *  👉用户表格-加载数据
 */
-(void)loadNewUsers
{
    NSMutableDictionary *pareme = [NSMutableDictionary dictionary];
    pareme[@"a"] = @"list";
    pareme[@"c"] = @"subscribe";
    pareme[@"category_id"] = self.categoryItemArray[self.CategoryTableView.indexPathForSelectedRow.row].id;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:pareme progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) { //请求成功
        
        //字典数组->模型数组
        self.usersItemArray = [UserItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新👈 类别表格
        [self.usersTableView reloadData];
        
        //结束刷新
        [self.usersTableView.mj_header endRefreshing];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { //请求失败
        
        //结束刷新
        [self.usersTableView.mj_header endRefreshing];
        
    }];
}

#pragma mark - 数据源方法
//显示多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.CategoryTableView) {
        return self.categoryItemArray.count;
    }else{
        return self.usersItemArray.count;
    }
}

//每行显示什么内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.CategoryTableView) {
        //从缓存池中取出可以循环利用的cell
        HMXCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCellId];
        //给cell赋值
        cell.categoryItem = self.categoryItemArray[indexPath.row];
        //返回cell
        return cell;
    }else{
        //从缓存池中取出可以循环利用的cell
        HMXUsersCell *cell = [tableView dequeueReusableCellWithIdentifier:usersCellId];
        //给cell赋值
        cell.userItem = self.usersItemArray[indexPath.row];
        //返回cell
        return cell;
    }
}


#pragma mark - 代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.CategoryTableView) {
        
        //进入刷新状态(加载数据)
        [self.usersTableView.mj_header beginRefreshing];
        
    }else
    {
        NSLog(@"选中了👉用户表格中的-%zd行",indexPath.row);
    }
}
@end
