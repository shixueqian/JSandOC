//
//  ViewController.m
//  JS与OC交互Demo
//
//  Created by 石学谦 on 16/7/9.
//  Copyright © 2016年 shixueqian. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()<UIWebViewDelegate>

//webView
@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置webView代理
    self.webView.delegate = self;
    
    //获取本地html路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index.html" ofType:nil];
    //中文路径要转码
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //加载html
    NSURL *url = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"网页加载完成");
    
//    [self demo1];
//    [self demo2];
//    [self demo3];
//    [self demo4];
    [self demo5];
}

//OC调用无参数的js方法
- (void)demo1 {
    //创建JSContext对象
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //OC调用JS方法
    [context evaluateScript:@"test1()"];
}

//OC调用有多个参数的JS方法
- (void)demo2 {
    //创建JSContext对象
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    [context evaluateScript:@"test3(\"我是参数a\",\"我是参数b\")"];
}

//OC调用OC代码写出来的js方法
- (void)demo3 {
    //创建JSContext对象
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //JS代码
    NSString *jsCode = [NSString stringWithFormat:@"alert(\"我是OC里面的js方法\")"];
    
    //OC调用JS方法
    [context evaluateScript:jsCode];
}


//js调用OC方法（无参数）
- (void)demo4 {
    
    //创建JSContext对象
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //注册printHelloWorld方法
    context[@"printHelloWorld"] = ^() {
        
        NSLog(@"Hello World !");
    };
}

//js调用OC方法（多参数）
- (void)demo5 {
    //创建JSContext对象
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //注册printAandB方法
    context[@"printAandB"] = ^(NSString *A ,NSString *B) {
        
        NSLog(@"%@,%@",A,B);
    };
}

@end
