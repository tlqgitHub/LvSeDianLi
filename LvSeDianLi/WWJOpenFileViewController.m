//
//  WWJOpenFileViewController.m
//  OrderKing
//
//  Created by TianLinqiang on 16/6/3.
//  Copyright © 2016年 TianLinqiang. All rights reserved.
//

#import "WWJOpenFileViewController.h"

@interface WWJOpenFileViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *mWebView;

@end

@implementation WWJOpenFileViewController

-(void)navLeftAction
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addLeftNavBarWithText:@"返回"];
    
    [self initSelfView];
    
    [self loadUrlFile:[self.parmsDic stringForKey:@"url"]];
}

-(void)initSelfView
{
    self.mWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    self.mWebView.delegate = self;
    
    [self.view addSubview:self.mWebView];
    
    self.mWebView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    self.mWebView.dataDetectorTypes = YES;//自动检测网页上的电话号码，单击可以拨打
}

-(void)loadUrlFile:(NSString*)fileUrl
{
    fileUrl = [fileUrl stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    fileUrl = [fileUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //    NSURL *url = [NSURL fileURLWithPath:fileUrl];
    NSURL *url = [NSURL URLWithString:fileUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.mWebView loadRequest:request];
}

#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
     self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
//    [MBProgressHUD showError:@"不支持的文件类型"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
