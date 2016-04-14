//
//  HMXSubTagViewController.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/6.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXSubTagViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "HMXSubTagItem.h"
#import "HMXSubTagCell.h"
@interface HMXSubTagViewController ()

/** 模型数组 */
@property(nonatomic,strong)NSArray *subTagArray;

/** 请求任务 */
//AFN中的任务,它会自动帮我们管理,因此,只需要设置为weak属性就可以了
@property(nonatomic,weak)NSURLSessionDataTask *dataTask;
@end

static NSString * const ID = @"subTag";

@implementation HMXSubTagViewController
//模型数组懒加载
-(NSArray *)subTagArray
{
    if (_subTagArray == nil) {
        _subTagArray = [NSArray array];
    }
    return _subTagArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"推荐标签";
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"HMXSubTagCell" bundle:nil] forCellReuseIdentifier:ID];
    
    //加载数据
    [self loadData];
    
//    //方案一(不适用与iOS8,iOS8需要修改两个系统属性,而在iOS7的时候只需要修改一个)
//    //设置分割线占据全屏
//    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    //方案二(万能的)
    //取消系统的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置tableView的背景色为分割线的颜色
    self.tableView.backgroundColor = globleColor(213, 215, 215);
    //重写cell的frame方法,将每个cell的高度减1,其他的属性不变
    
}
//加载数据
-(void)loadData
{
    //1.创建请求会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.设置请求参数
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"tag_recommend";
    parame[@"c"] = @"topic";
    parame[@"action"] = @"sub";
    
    //提示用户
    [SVProgressHUD showWithStatus:@"正在加载..."];
    
    //3.发送请求
        
      _dataTask = [manager GET:HMXRequestUrl parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {//请求成功后调用
            
            //        [responseObject writeToFile:@"/Users/hemengxiang/Desktop/GitHub-BuDeJie/BuDeJie/BuDeJie/BuDeJie/subTag.plist" atomically:YES];
            
            //移除提示
            [SVProgressHUD dismiss];
            
            //字典数组->模型数组
            self.subTagArray = [HMXSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
            //刷新列表
            [self.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {//请求失败后调用
            HMXLog(@"%@",error);
            
            //移除提示
            [SVProgressHUD dismiss];
        }];
   }

//当"订阅标签"一直加载不了数据的时候,用户想反回到上一个控制器,这个时候,要将提示取消,并且取消请求
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //移除指示器
    [SVProgressHUD dismiss];
    
    //取消任务
    [_dataTask cancel];
}


#pragma mark - Table view data source
//返回每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.subTagArray.count;
}

//返回每行显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //获取cell
    HMXSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
//    //方案一
//    cell.layoutMargins = UIEdgeInsetsZero;
    
    //给cell模型赋值
    cell.subTagItem = self.subTagArray[indexPath.row];
    
    return cell;
}

//设置tableView的行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //根描述cell的xib的高度一样高
    return 70;
}
@end
