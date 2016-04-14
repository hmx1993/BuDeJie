//
//  BuDeJieFileManager.h
//  BuDeJie
//
//  Created by hemengxiang on 16/4/7.
//  Copyright © 2016年 hemengxiang. All rights reserved.
// 该类专门用于文件的处理

#import <Foundation/Foundation.h>

@interface BuDeJieFileManager : NSObject

/**
 *  获取文件夹尺寸
 *
 *  @param directoryPath 文件夹全路径
 *
 *  @return 文件夹的尺寸
 */

+(NSInteger)getDirectorySize:(NSString *)directoryPath;
/**
 *  删除文件夹下所有文件
 *
 *  @param directoryPath 文件夹全路径
 */
+(void)removeDirectoryPath:(NSString *)directoryPath;

@end
