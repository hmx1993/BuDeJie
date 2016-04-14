//
//  HMXMeViewController.m
//  BuDeJie
//
//  Created by hemengxiang on 16/3/12.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXMeViewController.h"
#import "HMXSettingViewController.h"
#import "HMXSquareCell.h"
#import <AFNetworking/AFNetworking.h>
#import "HMXSqaureItem.h"
#import <MJExtension/MJExtension.h>
#import "HMXWebViewController.h"
#import <SafariServices/SafariServices.h>

static NSString *const ID = @"cell";

//cell的列数
static NSInteger const cols = 4;
//每个cell的间距
static CGFloat const margin = 1;
//item的宽高
#define itemWH (HMXScreenW - (cols - 1) * margin) / cols

@interface HMXMeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,weak)UICollectionView *collectionView;
//模型数组
@property(nonatomic,strong)NSMutableArray *squareArray;

@end

@implementation HMXMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条内容
    [self setUpNav];
    
    //设置tableView的底部视图
    [self setFooterView];
    
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"HMXSquareCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    //请求数据
    [self loadData];
    
    //设置tableView的组间距
    //如果是分组样式,默认每组头部和尾部会有一定的间距
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    
    //将tableView的顶部内边距向上调整一定的距离
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}


//请求数据
-(void)loadData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *prame = [NSMutableDictionary dictionary];
    prame[@"a"] = @"square";
    prame[@"c"] = @"topic";
    [manager GET:HMXRequestUrl parameters:prame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {//成功后回调
        
        //解析数据

//        [responseObject writeToFile:@"/Users/hemengxiang/Desktop/GitHub-BuDeJie/BuDeJie/BuDeJie/BuDeJie/square.plist" atomically:YES];
        
        self.squareArray = [HMXSqaureItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        
        //填补模型
        [self resolveData];
       
        
        //重新计算collectionView的高度(计算出有多少行cell)
        NSInteger count = self.squareArray.count;
        //行数
        NSInteger rows = (count - 1)/cols + 1;
        
        //collectionView的高度
        CGFloat collectionH = rows * itemWH + (rows - 1) * margin;
        
        self.collectionView.height = collectionH;
        
        //刷新collectionView
        [self.collectionView reloadData];
        
        //重新设置tableView的滚动范围
        self.tableView.tableFooterView = self.collectionView;
//        self.tableView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.collectionView.frame));
        
        //contentSize的高度计算不准确,重新计算tableView的contentSize的高度
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {//失败后回调
        HMXLog(@"%@",error);
    }];
}

//用空的模型填补最后一行剩余的位置
-(void)resolveData
{
    //计算应当填补的个数
    
    NSInteger count = cols - self.squareArray.count % cols;
    
    if (count == 0) return;
    
    //使用for循环来遍历,添加相应个数的空白模型
    for (NSInteger i = 0; i < count; i++) {
        HMXSqaureItem *item = [[HMXSqaureItem alloc] init];
        [self.squareArray addObject:item];
    }
    
}

//设置tableView的底部视图
-(void)setFooterView
{
    //1.创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //2.设置流水布局参数
    //设置每个cell的尺寸
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    
    //设置每个cell的间距
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    //3.根据流水布局参数创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    
    //底部视图设置frame的时候,只有设置的高度有效
    collectionView.backgroundColor = [UIColor lightGrayColor];
    
    self.collectionView = collectionView;
    
    
    
    //设置数据源
    collectionView.dataSource = self;
    
    //设置代理
    collectionView.delegate = self;
    
    //添加为底部视图
    self.tableView.tableFooterView = collectionView;
}

//设置导航条内容
-(void)setUpNav
{
    //设置标题
    self.navigationItem.title = @"我的";
    
    //添加设置按钮
    UIBarButtonItem *item1 = [UIBarButtonItem itemWithImage:@"mine-setting-icon" heighLightImage:@"mine-setting-icon-click" target:self action:@selector(settingBtnClick:)];
    //添加夜间模式设置按钮
    UIBarButtonItem *item2 = [UIBarButtonItem itemWithImage:@"mine-moon-icon" selectedImage:@"mine-moon-icon-click" target:self action:@selector(nightModeBtnClick:)];
    
    //添加Items
    NSArray *itemArray = @[item1,item2];
    self.navigationItem.rightBarButtonItems = itemArray;
    
    self.view.backgroundColor = globleBg;
    
    //覆盖tabBarController给我们设置的左侧返回按钮
    self.navigationItem.leftBarButtonItem = nil;
}

//点击设置按钮时调用
-(void)settingBtnClick:(UIButton *)btn
{
    
    //创建设置控制器
    HMXSettingViewController *setting = [[HMXSettingViewController alloc] init];

    //跳转到设置界面
    [self.navigationController pushViewController:setting animated:YES];
}

//点击夜间模式时调用
-(void)nightModeBtnClick:(UIButton *)btn
{
    //让按钮处于选中状态
    //注意:按钮的选中状态必须要手动设置
    btn.selected = !btn.selected;
    
    HMXLog(@"夜间模式按钮被点击了");
}


#pragma---collectionView的数据源方法
//返回每组显示多少个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.squareArray.count;
}

//每个item的样子
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //1.从缓存池中获取可以循环利用的cell
    HMXSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    //2.给cell赋值
    cell.sqaureItem = self.squareArray[indexPath.row];
    
    //3.返回cell
    return cell;
}
#pragma---collectionView的代理方法
//点击了每一个item的时候,跳转到一个网页
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //根据对应格子的模型中的URL,跳转网页
    HMXSqaureItem *item = self.squareArray[indexPath.row];
    //如果url不是网页,就不跳转
    if (![item.url containsString:@"http"]) return;
    
    NSURL *url = [NSURL URLWithString:item.url];
    
    //打开网页有3种控制器可以使用
    /*
     1.safari:
     缺点:跳转到safari应用,离开当前应用
     优点:有很多自带的功能,前进,后退,刷新,网址
     
     2.UIWebView
     优点:在当前应用就可以打开
     缺点:前进,后退,刷新等这些功能必须要手动去实现,而且进度条做不了,以前在WebView上面看到的进度条都是假象
     
     现在的需求:
        在当前应用跳转网页,并且需要有safari的那些功能
     解决方案:
        iOS9新出来的控制器,SFSafariViewController,在当前应用打开网页,功能同safari一样
     使用时:导入头文件#import <SafariServices/SafariServices.h>
     */
//    SFSafariViewController *safari = [[SFSafariViewController alloc] initWithURL:url];
//    [self presentViewController:safari animated:YES completion:nil];
    
    HMXWebViewController *web = [[HMXWebViewController alloc] init];
    web.url = url;
    [self.navigationController pushViewController:web animated:YES];
    
}

//验证组样式的第一个cell的frame的y值是从35开始的,{{0, 35}, {375, 44}}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"%@",NSStringFromCGRect(cell.frame));
//}


@end
