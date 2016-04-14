//
//  HMXSettingViewController.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/1.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXSettingViewController.h"
#import "BuDeJieFileManager.h"
static NSString * const ID = @"cell";

@interface HMXSettingViewController ()

@end

@implementation HMXSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置标题
    self.navigationItem.title = @"设置";
    
    //设置背景颜色
//    self.view.backgroundColor = globleBg;
    
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}
//获取缓存字符串
-(NSString *)getFileSizeStr
{
    // 获取Cache文件夹路径
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    //获取Cache文件夹路径文件下的大小
    NSInteger totalSize = [BuDeJieFileManager getDirectorySize:cachePath];
    
    NSString *str = nil;
    CGFloat totalSizeF = 0;
    
    if (totalSize > (1000 * 1000)) {
        totalSizeF = totalSize / 1000.0 / 1000.0;
        str = [NSString stringWithFormat:@"清除缓存(%.1fMB)",totalSizeF];
    }else if(totalSize > 1000){
        totalSizeF = totalSize / 1000.0 ;
        str = [NSString stringWithFormat:@"清除缓存(%.1fKB)",totalSizeF];
    }else if(totalSize > 0){
        
        str = [NSString stringWithFormat:@"清除缓存(%zdB)",totalSize];
    }else
    {
        str = @"清除缓存";
    }
    return str;
    
}

#pragma mark - Table view data source
//返回一行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

//返回这一行显示的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //从缓存池中取出cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //设置cell
    cell.textLabel.text = [self getFileSizeStr];
    
    //返回cell
    return cell;
}

#pragma mark  - 代理方法
//当选中某一行的时候代用
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //清除缓存
    //获取cache文件路径
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"%@",cachePath);
    
    //删除该文件路径下所有的文件
    [BuDeJieFileManager removeDirectoryPath:cachePath];
    
    //刷新表格,重新计算缓存
    [self.tableView reloadData];
}

@end
