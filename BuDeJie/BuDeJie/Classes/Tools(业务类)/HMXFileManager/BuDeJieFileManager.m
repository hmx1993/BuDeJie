//
//  BuDeJieFileManager.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/7.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "BuDeJieFileManager.h"

@implementation BuDeJieFileManager

//获取文件大小
+(NSInteger)getDirectorySize:(NSString *)directoryPath
{
    
    //获取文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //如果用户传入的不是文件夹或者该文件不存在就报错
    BOOL isDirectory;
    BOOL isExist = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExist || !isDirectory)
    {
        NSException *exception = [NSException exceptionWithName:@"filePathError" reason:@"请传入符合规范的文件夹路径" userInfo:nil];
        [exception raise];
    };
    
    
    //获取这个文件路径下所有的文件
    NSArray *subPaths = [fileManager subpathsAtPath:directoryPath];
    
    NSInteger totalSize = 0;
    
    //遍历数组
    for (NSString *subPath in subPaths) {
        
        //拼接全文件路径
        NSString *fileFullPath = [directoryPath stringByAppendingPathComponent:subPath];
        
        //排除文件夹和不存在的文件
        BOOL isDirectory;
        BOOL isExist = [fileManager fileExistsAtPath:fileFullPath isDirectory:&isDirectory];
        if (!isExist || isDirectory) continue;
        
        //排除隐藏文件
        if ([fileFullPath containsString:@".DS"] ) continue;
        
        //获取指定路径下的文件属性
        NSDictionary *artt = [fileManager attributesOfItemAtPath:fileFullPath error:nil];
        NSInteger size = [artt fileSize];
        totalSize += size;
    }
    
    return totalSize;
}

//删除文件
+(void)removeDirectoryPath:(NSString *)directoryPath
{
    //获取文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //如果用户传入的不是文件夹或者该文件不存在就报错
    BOOL isDirectory;
    BOOL isExist = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExist || !isDirectory)
    {
        NSException *exception = [NSException exceptionWithName:@"filePathError" reason:@"请传入符合规范的文件夹路径" userInfo:nil];
        [exception raise];
    };
    
    //获取cachePath文件路径下所有的一级文件夹
    NSArray *subPaths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:nil];
    
    //拼接全路径
    for (NSString *subPath in subPaths) {
      
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        //移除该文件夹下所有的文件
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    
}

@end
