//
//  HMXADViewController.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/1.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

/*
 
 //请求数据 -> 查看接口文档 -> 测试接口文档有没有问题 ->解析数据 -> 找出自己需要的数据
 //w = 480;
 // "w_picurl" = "http://ubmcmm.baidustatic.com/media/v1/0f0000vSCsipFdmkFprLk6.jpg";
 //"ori_curl" = "http://qmqj2.xy.com/idf/uMAU5P";
 //h = 800;
 */

//广告的URL
/*
 http://mobads.baidu.com/cpro/ui/mads.php?code2=phcqnauguhykfmrquanhmgn_iaubthfqmgksuarhiwdgulpxnz3vndtkqw08nau_i1y1p1rhmhwz5hb8nbul5hdknwrhta_qmvqvqhgguhi_py4mqhf1tvchmgky5h6hmypw5rfrhzuet1dgulnhuan85hchuy7s5hdhiywgujy3p1n3mwb1pvdlnvf-pyf4mhr4nyrvmwpbmhwbpjclpyfspht3uwm4fmplphykfh7sta-b5yrzpj6spvrdfhpdtwysfmkzuykemyfqnauguau95rnsnbfknbm1qhnkww6vpjujnbdkfwd1qhnsnbrsnhwkfywawiu9mlfqhbd_h70htv6qnhn1pauvmynqnjclnj0lnj0lnj0lnj0lnj0hthyqniuvujykfhkc5hrvnb3dfh7spyfqnw0srj64nbu9tjysfmub5hdhtzfeujdztlk_mgpcfmp85rnsnbfknbm1qhnkww6vpjujnbdkfwd1qhnsnbrsnhwkfywawiubnhfdnjd4rjnvpwykfh7stzu-twy1qw68nbuwuhydnhchiayqphdzfhqsmypgizbqniuythuytjd1uavxnz3vnzu9ijyzfh6qp1rsfmws5y-fpaq8uht_nbuymycqnau1ijykpjrsnhb3n1mvnhdkqwd4niuvmybqniu1uy3qwd-hqdfkhakhhnn_hr7fq7udq7pchzkhir3_ryqnqd7jfzkpirn_wdkhqdp5hikpfrb_fnc_nbwpqddrhzkdinchtvww5hnvpj0zqwndnhrvnbsdpwb4ri3kpw0kphmhmlnqph6lp1ndm1-wpydvnhkbraw9nju9phihmh9wmh6zrjrhtv7_5iu85hdhtvd15hdhtltqp1rsfh4etjyypw0spzuvuyyqn1mynjc8nwbvrjtdqjrvrhb4qwdvnjddpbuk5yrzpj6spvrdgvpstbu_my4btvp9tarqnam
 */

#import "HMXADViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "HMXADItem.h"
#import <UIImageView+WebCache.h>
#import "HMXTabBarController.h"
//广告的参数
#define HMXCode2 @"phcqnauguhykfmrquanhmgn_iaubthfqmgksuarhiwdgulpxnz3vndtkqw08nau_i1y1p1rhmhwz5hb8nbul5hdknwrhta_qmvqvqhgguhi_py4mqhf1tvchmgky5h6hmypw5rfrhzuet1dgulnhuan85hchuy7s5hdhiywgujy3p1n3mwb1pvdlnvf-pyf4mhr4nyrvmwpbmhwbpjclpyfspht3uwm4fmplphykfh7sta-b5yrzpj6spvrdfhpdtwysfmkzuykemyfqnauguau95rnsnbfknbm1qhnkww6vpjujnbdkfwd1qhnsnbrsnhwkfywawiu9mlfqhbd_h70htv6qnhn1pauvmynqnjclnj0lnj0lnj0lnj0lnj0hthyqniuvujykfhkc5hrvnb3dfh7spyfqnw0srj64nbu9tjysfmub5hdhtzfeujdztlk_mgpcfmp85rnsnbfknbm1qhnkww6vpjujnbdkfwd1qhnsnbrsnhwkfywawiubnhfdnjd4rjnvpwykfh7stzu-twy1qw68nbuwuhydnhchiayqphdzfhqsmypgizbqniuythuytjd1uavxnz3vnzu9ijyzfh6qp1rsfmws5y-fpaq8uht_nbuymycqnau1ijykpjrsnhb3n1mvnhdkqwd4niuvmybqniu1uy3qwd-hqdfkhakhhnn_hr7fq7udq7pchzkhir3_ryqnqd7jfzkpirn_wdkhqdp5hikpfrb_fnc_nbwpqddrhzkdinchtvww5hnvpj0zqwndnhrvnbsdpwb4ri3kpw0kphmhmlnqph6lp1ndm1-wpydvnhkbraw9nju9phihmh9wmh6zrjrhtv7_5iu85hdhtvd15hdhtltqp1rsfh4etjyypw0spzuvuyyqn1mynjc8nwbvrjtdqjrvrhb4qwdvnjddpbuk5yrzpj6spvrdgvpstbu_my4btvp9tarqnam"

@interface HMXADViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *lunchImageView;
/** 广告模型 */
@property (nonatomic,strong)HMXADItem *adItem;
/** 装广告的View */
@property (weak, nonatomic) IBOutlet UIView *adView;
/** 展示广告图片 */
@property (weak, nonatomic) UIImageView *imageView;
/** 跳过按钮 */
@property (weak, nonatomic) IBOutlet UIButton *jump;
/** 定时器 */
@property(nonatomic,strong)NSTimer *timer;

@end

static NSInteger second = 3;

@implementation HMXADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置启动图片(根据不同的屏幕加载不同的图片,屏幕适配)
    [self setLunchImage];
    
    //加载广告数据
    [self loadAdData];
    
    //添加定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
}

//ADView的懒加载
-(UIImageView *)imageView
{
    if (_imageView == nil) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
        [self.adView addSubview:imageView];
        //给imageView添加点按手势
        
        imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [imageView addGestureRecognizer:tap];
        
        
    }
    return _imageView;
}

//当图片被点击的时候进入到广告界面
-(void)tap
{
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:[NSURL URLWithString:self.adItem.ori_curl]])
    {
        [app openURL:[NSURL URLWithString:self.adItem.ori_curl]];
    }
}

-(void)timeChange
{
    second--;
    
    //如果剩下0秒的时候,直接跳转到主界面
    if (second < 0) {
        [self jumpClick:nil];
    }
    //改变"跳过"按钮上的文字
    NSString *jumpStr = [NSString stringWithFormat:@"跳过(%zd)",second];
    
    [self.jump setTitle:jumpStr forState:UIControlStateNormal];
}
//点击"跳过"后调用
- (IBAction)jumpClick:(id)sender {
    
    //跳转到主界面(1.push 2.modal 3.改变窗口根控制器)根据跳转的样式最终决定使用第三种方式
    HMXTabBarController *tabBar = [[HMXTabBarController alloc] init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
    
    //销毁定时器
    [self.timer invalidate];
}

//加载广告数据
-(void)loadAdData
{
    //创建AFN会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //让AFN能够处理html格式的数据
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //发送请求
    NSMutableDictionary *prameters = [NSMutableDictionary dictionary];
    prameters[@"code2"] = HMXCode2;
   
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:prameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {//成功后的回调
        
        //字典->模型
        self.adItem = [HMXADItem mj_objectWithKeyValues:responseObject[@"ad"][0]];
    
        //设置imageView的尺寸
        self.imageView.frame = CGRectMake(0, 0, HMXScreenW, self.adItem.h.floatValue / self.adItem.w.floatValue * HMXScreenW);
        //设置imageView的图片
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.adItem.w_picurl]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {//失败后的回调
        
        NSLog(@"广告加载失败");
        
    }];
}

//根据不同的手机屏幕展示不同大小的图片
-(void)setLunchImage
{
    UIImage *image = nil;
    if (iphone6P) {
        image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }else if(iphone6){
        image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    }else if (iphone5){
        image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    }else if (iphone4){
        image = [UIImage imageNamed:@"LaunchImage-700"];
    }
    self.lunchImageView.image = image;
}


@end
