//
//  HMXSeeBigPictureController.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/16.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXSeeBigPictureController.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
@interface HMXSeeBigPictureController ()<UIScrollViewDelegate>

@property(nonatomic,weak)UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation HMXSeeBigPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //通过xib加载控制器的View,在viewDidLoad方法中得到的尺寸是xib中view的原始大小,因此,此时设置的self.view.bounds中的尺寸就是xib中的尺寸,但是当控制器的View即将要显示的时候,它会随着窗口的宽高伸缩而伸缩,但是因为scrollView是手动创建,所以如果不去主动设置它的宽高比随着父控件的拉伸而拉伸的时候
    
    //添加一个scrollView
    UIScrollView *scroll = [[UIScrollView alloc] init];
    scroll.contentSize = CGSizeMake(0, HMXScreenW * self.topics.height / self.topics.width);
    scroll.frame = self.view.bounds;
    scroll.backgroundColor = [UIColor greenColor];
    scroll.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //设置代理(实现缩放)
    scroll.delegate = self;
    //图片缩放
    CGFloat maxScale = self.topics.width / HMXScreenW;
    if (maxScale > 1.0) {//放大
        scroll.maximumZoomScale = maxScale;
    }
    
    //点击scrollView,退出查看大图
    [scroll addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backBtn:)]];
    
    [self.view insertSubview:scroll atIndex:0];
    
    //添加ImageView
    UIImageView *imageView = [[UIImageView alloc] init];
   
    imageView.width = HMXScreenW;
    imageView.height = HMXScreenW * self.topics.height / self.topics.width;
    
    //设置图片(直接加载大图)
    UIImage *placeHodlerImage = nil;
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topics.image1] placeholderImage:placeHodlerImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        //如果图片为空,就直接返回
        if(image == nil) return;
        
        //将保存按钮恢复为可用状态
        self.saveBtn.enabled = YES;
    }];
    
    self.imageView = imageView;
    
    [scroll addSubview:imageView];
}

-(void)viewDidLayoutSubviews
{
    //根据imageView高度设置imageView的位置
    if ( self.imageView.height >= HMXScreenH) {//如果大于一个屏幕的高度
        self.imageView.x = 0;
        self.imageView.y = 0;
    }else{
        self.imageView.center = self.view.center;
    }
}
//返回
- (IBAction)backBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//当点击保存图片按钮的时候调用
- (IBAction)saveBtnClick:(id)sender {
    
    //以后凡是看到陌生的方法中带有@selector类型的参数的时候,应该进到头文集中去看看这个方法对@selector中包装的方法有没有特定的格式,如果有的话,最好是按照苹果要求的格式来写
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    //如果保存成功
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else
    {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

#pragma mark - <scrollViewDelegate>
//告诉scollView想缩放哪一个View
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
@end
