//
//  HMXRecommendViewController.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/1.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXRecommendViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "CategoryItem.h"
@interface HMXRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
//类别
@property (weak, nonatomic) IBOutlet UITableView *CategoryTableView;

//类别模型数组
@property(nonatomic,strong)NSArray *categoryItemArray;

@end

@implementation HMXRecommendViewController

//类别模型数组懒加载
-(NSArray *)categoryItemArray
{
    if (_categoryItemArray == nil) {
        _categoryItemArray = [NSArray array];
    }
    return _categoryItemArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置该控制器的标题
    self.navigationItem.title = @"推荐关注";
    
    //发送请求,将数据显示给左边的tableView
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *pareme = [NSMutableDictionary dictionary];
    pareme[@"a"] = @"category";
    pareme[@"c"] = @"subscribe";
    
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:pareme progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功(此请求responseObject返回的是一个字典)
        HMXLog(@"%@",responseObject);
        
        //字典数组转换为模型数组
        self.categoryItemArray = [CategoryItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新列表
        [self.CategoryTableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        HMXLog(@"%@",error);
        
    }];
    
    
}

#pragma mark - 数据源方法
//显示多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoryItemArray.count;
}

//每行显示什么内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //从缓存池中取出可以循环利用的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"category"];
    //给cell赋值
    
    
    //返回cell
    return cell;
}

@end
