//
//  UIImageView+DownloadImage.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/16.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "UIImageView+DownloadImage.h"
@implementation UIImageView (DownloadImage)
//sd_setImageWithURL: placeholderImage:底层做的事情
/*
 1.取消其他ImageView发出的下载请求,哪个imageView发出的请求,等图片下载完之后会自动将图片设置到对应的ImageView上面去
 2.设置占位图片
 3.根据传过来的URL发送请求
 4.图片下载完成后设置到对应的imageView上去
 */

/**
 *  @param OriginalImageUrl    原始图片
 *  @param thumbnailImageUrl   缩略图
 *  @param placeHodlerImageUrl 占位图片
 *  @param completedBlock      图片设置完成后的block回调
 */
-(void)hmx_setImageWithOriginalImageUrl:(NSString *)OriginalImageUrl thumbnailImageUrl:(NSString *)thumbnailImageUrl placeHodlerImage:(UIImage *)placeHodlerImage completed:(SDWebImageCompletionBlock)completedBlock
{
    //无论用户是什么网络状况,都应该首先考虑让用户显示高清图片
    //去缓存池中找有没有图片,会先去内存中找,然后再去磁中找
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:OriginalImageUrl];
    UIImage *smallImage = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:thumbnailImageUrl];
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    //如果缓存池中没有,就根据网络状态去下载相应大小的图片
    if (originalImage)
    {
        //注意点:不能写成self.picture.image = originalImage
        [self sd_setImageWithURL:[NSURL URLWithString:OriginalImageUrl] completed:completedBlock];
    }else
    {
        if (manager.reachableViaWiFi){//WiFi
            [self sd_setImageWithURL:[NSURL URLWithString:OriginalImageUrl] placeholderImage:placeHodlerImage completed:completedBlock];
            
        }else if (manager.reachableViaWWAN){//流量
            
            BOOL isAlwaysDownLoadBigImage = [[NSUserDefaults standardUserDefaults] boolForKey:@"isAlwaysDownLoadBigImage"];
            
            if (isAlwaysDownLoadBigImage == YES){//用户允许下载大图
                
                [self sd_setImageWithURL:[NSURL URLWithString:OriginalImageUrl] placeholderImage:placeHodlerImage completed:completedBlock];
                
            }else{//用户不允许
                
                //查找缓存中有没有小图,如果没有就直接下载
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageUrl] placeholderImage:placeHodlerImage completed:completedBlock];
            }
        }else{//没有网络
            
            if (smallImage) {//如果缓存池中有缩略图片
                
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageUrl]  completed:completedBlock];
            }else{//如果没有就设置占位图片
                
                [self sd_setImageWithURL:nil placeholderImage:placeHodlerImage completed:completedBlock];
            }
        }
    }
}

/**
 *  @param OriginalImageUrl    原始图片
 *  @param thumbnailImageUrl   缩略图
 *  @param completedBlock      图片设置完成后的block回调
 */
-(void)hmx_setImageWithOriginalImageUrl:(NSString *)OriginalImageUrl thumbnailImageUrl:(NSString *)thumbnailImageUrl completed:(SDWebImageCompletionBlock)completedBlock
{
    [self hmx_setImageWithOriginalImageUrl:OriginalImageUrl thumbnailImageUrl:thumbnailImageUrl placeHodlerImage:nil completed:completedBlock];
}


/**
 *  @param OriginalImageUrl    原始图片
 *  @param thumbnailImageUrl   缩略图
 *  @param placeHodlerImageUrl 占位图片
 */
-(void)hmx_setImageWithOriginalImageUrl:(NSString *)OriginalImageUrl thumbnailImageUrl:(NSString *)thumbnailImageUrl placeHodlerImage:(UIImage *)placeHodlerImage
{
    [self hmx_setImageWithOriginalImageUrl:OriginalImageUrl thumbnailImageUrl:thumbnailImageUrl placeHodlerImage:placeHodlerImage completed:nil];
}


/**
 *  @param OriginalImageUrl    原始图片
 *  @param thumbnailImageUrl   缩略图
 */
-(void)hmx_setImageWithOriginalImageUrl:(NSString *)OriginalImageUrl thumbnailImageUrl:(NSString *)thumbnailImageUrl {
    
    [self hmx_setImageWithOriginalImageUrl:OriginalImageUrl thumbnailImageUrl:thumbnailImageUrl placeHodlerImage:nil completed:nil];
}
@end
