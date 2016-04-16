//
//  UIImageView+DownloadImage.h
//  BuDeJie
//
//  Created by hemengxiang on 16/4/16.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>
#import <AFNetworkReachabilityManager.h>
@interface UIImageView (DownloadImage)

/**
 *  @param OriginalImageUrl    原始图片
 *  @param thumbnailImageUrl   缩略图
 *  @param placeHodlerImageUrl 占位图片
 *  @param completedBlock      图片设置完成后的block回调
 */
-(void)hmx_setImageWithOriginalImageUrl:(NSString *)OriginalImageUrl thumbnailImageUrl:(NSString *)thumbnailImageUrl placeHodlerImage:(UIImage *)placeHodlerImage completed:(SDWebImageCompletionBlock)completedBlock;

/**
 *  @param OriginalImageUrl    原始图片
 *  @param thumbnailImageUrl   缩略图
 *  @param completedBlock      图片设置完成后的block回调
 */
-(void)hmx_setImageWithOriginalImageUrl:(NSString *)OriginalImageUrl thumbnailImageUrl:(NSString *)thumbnailImageUrl completed:(SDWebImageCompletionBlock)completedBlock;

/**
 *  @param OriginalImageUrl    原始图片
 *  @param thumbnailImageUrl   缩略图
 *  @param placeHodlerImageUrl 占位图片
 */
-(void)hmx_setImageWithOriginalImageUrl:(NSString *)OriginalImageUrl thumbnailImageUrl:(NSString *)thumbnailImageUrl placeHodlerImage:(UIImage *)placeHodlerImage;

/**
 *  @param OriginalImageUrl    原始图片
 *  @param thumbnailImageUrl   缩略图
 */
-(void)hmx_setImageWithOriginalImageUrl:(NSString *)OriginalImageUrl thumbnailImageUrl:(NSString *)thumbnailImageUrl;

@end
