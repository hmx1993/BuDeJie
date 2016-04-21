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
#import <Photos/Photos.h>

@interface HMXSeeBigPictureController ()<UIScrollViewDelegate>

@property(nonatomic,weak)UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

// 在interface中写方法的声明，是为了点语法有智能提示
- (PHFetchResult<PHAsset *> *)getAssets;
- (PHAssetCollection *)getAssetCollection;

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

/*
 //    //以后凡是看到陌生的方法中带有@selector类型的参数的时候,应该进到头文集中去看看这个方法对@selector中包装的方法有没有特定的格式,如果有的话,最好是按照苹果要求的格式来写
 //    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
 */
    //取出用户之前对该应用程序是否能够访问相册的授权状态
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    /*
     requestAuthorization方法的功能:
     1.如果用户还没有做过选择,这个方法会弹框让用户做出选择,用户做出选择后才会回调Block
     2.如果用户之前就已经做过选择,那么这个方法就不会再去弹框,直接进入到block里面去,并且把授权状态传到block中去
     */
    
    //请求授权
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        
        //此方法在异步线程调用
        NSLog(@"%@",[NSThread currentThread]);
        
        //将和UI相关的东西放在主线程去做
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //根据用户的授权状态来做不同的事情
            switch (status) {
                case PHAuthorizationStatusAuthorized://用户已经允许过当前App访问相片数据（用户已经点击过OK按钮）
                    
                    //保存图片到相册
                    [self saveImageToAlbum];
                    
                    break;
                    
                case PHAuthorizationStatusDenied://用户已经明显拒绝过当前App访问相片数据（用户已经点击过Don't Allow按钮）
                    
                    //如果用户是第一次授权并且点击了"Don't allow"按钮,那么什么事情都不做
                    if (oldStatus == PHAuthorizationStatusNotDetermined) return;
                    //如果用户之前已经授权过,那么就要提示用户打开相册的访问开关
                    NSLog(@"提醒用户打开相册的访问开关");
                    
                    break;
                    
                case PHAuthorizationStatusRestricted://因为一些系统原因导致无法访问相册（比如家长控制）
                    
                    //提示用户无法访问到相册
                    [SVProgressHUD showErrorWithStatus:@"由于系统原因,无法访问相册"];
                    
                    break;
                    
                default:
                    break;
            }
        });
    }];
}

/**
 *  保存照片到相册
 */
-(void)saveImageToAlbum
{
    
    //1.获得刚刚保存到[相机胶卷]中的相片
    PHFetchResult<PHAsset *> *assets = self.getAssets;
    
    //2.获取相册
    PHAssetCollection *collection = self.getAssetCollection;
    
    //如果相片或相册为空,就提醒用户保存失败
    if (assets == nil || collection == nil) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
        return;
    }
    
    //3.将相片添加到相册
    
    NSError *error = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        
        PHAssetCollectionChangeRequest *requst = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
        [requst insertAssets:assets atIndexes:[NSIndexSet indexSetWithIndex:0]];
        
        
    } error:&error];
    
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else
    {
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
    }
}

/**
 *  获得刚才添加到[相机胶卷]中的相片
 */
-(PHFetchResult<PHAsset *> *)getAssets
{
    //被__block修饰的变量才能在后面的block块中修改它
    __block NSString *creatAssetID = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        
        creatAssetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
        
    } error:nil];
    
    if (creatAssetID == nil) return nil;
    
    //在保存完毕后取出图片
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[creatAssetID] options:nil];
}

/**
 *  获得[自定义相册]
 */
-(PHAssetCollection *)getAssetCollection
{
    //获取软件的名称作为相册的标题
    NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    
    //获取所有的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    //遍历所有获取的相册
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            
            return collection;
        }
    }
    
    //代码来到这里说明还没有创建过相册
    __block  NSString *createdCollectionID = nil;
    
    //创建一个新的相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        
        createdCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
        
    } error:nil];
    
    if (createdCollectionID == nil) return nil;
    
    //创建成功后再取出相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionID] options:nil].firstObject;
}

/*

//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
//{
//    //如果保存成功
//    if (error) {
//        [SVProgressHUD showErrorWithStatus:@"保存失败"];
//    }else
//    {
//        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
//    }
//}
 
 */


#pragma mark - <scrollViewDelegate>
//告诉scollView想缩放哪一个View
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
@end
