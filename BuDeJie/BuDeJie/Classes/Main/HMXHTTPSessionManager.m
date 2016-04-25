//
//  HMXHTTPSessionManager.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/23.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXHTTPSessionManager.h"

@implementation HMXHTTPSessionManager

-(instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    if (self == [super initWithBaseURL:url sessionConfiguration:configuration]) {
        //统一设置请求头
        [self.requestSerializer setValue:@"123" forHTTPHeaderField:@"Cookie"];
        [self.requestSerializer setValue:@"iPhone" forHTTPHeaderField:@"Phone"];
        [self.requestSerializer setValue:@"9.2" forHTTPHeaderField:@"OS_VERSION"];
    }
    return self;
}

@end
