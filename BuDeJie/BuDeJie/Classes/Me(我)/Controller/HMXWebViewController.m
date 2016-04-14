//
//  HMXWebViewController.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/7.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXWebViewController.h"

#import <WebKit/WebKit.h>

@interface HMXWebViewController ()
@property(nonatomic,weak)WKWebView *wkWebView;

//进度条
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation HMXWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //WKWebView是UIWebView的升级版
    WKWebView *wkWebView = [[WKWebView alloc] init];
    wkWebView.frame = self.view.bounds;
    [self.view insertSubview:wkWebView atIndex:0];
    self.wkWebView = wkWebView;
    //跳转网页
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:_url];
    [self.wkWebView loadRequest:request];
    
    
    //KVO :让self对象监听wkWebView的estimatedProgress属性
    //监听wkWebView的 estimatedProgress进度值属性(新值得改变)
    [wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];

}

/*
 方法调用的先后顺序如下:
 -[HMXWebViewController setUrl:]
 -[HMXWebViewController viewDidLoad]
 -[HMXWebViewController viewDidAppear:]
 */
//不能将webView的请求放在set方法中写,因为set方法最先调用,这时候WebView为空

//-(void)setUrl:(NSURL *)url
//{
//    _url = url;
//    //跳转网页
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//    [self.wkWebView loadRequest:request];
//    NSLog(@"%@",self.wkWebView);
//    NSLog(@"%s",__func__);
//}

//只要监听到属性的变化就会调用这个方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    self.progressView.progress = self.wkWebView.estimatedProgress;
    //当全部加载完毕的时候,将进度条隐藏
    self.progressView.hidden = (self.progressView.progress == 1) ? YES : NO;
    
}

//KVO一定要移除观察者
-(void)dealloc
{
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
