//
//  LSDHelpViewController.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/8/24.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDHelpViewController.h"

@interface LSDHelpViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *ib_webView;

@end

@implementation LSDHelpViewController

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
     [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#2aa08a'"];
}

//状态的链接如下，需根据系统语言判断使用哪个
//https://www.smart-pv.net/explainEN.html英文
//
//https://www.smart-pv.net/explainJP.html 日文
//
//https://www.smart-pv.net/explainCH.html 中文

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    NSString *filePath = nil;
    NSString *webUrl = nil;
    
    if ([[self getPreferredLanguage] rangeOfString:@"zh-Hans"].location != NSNotFound)
    {
        filePath = [[NSBundle mainBundle]pathForResource:@"WeChat_1469444388" ofType:@"png"];
        webUrl = @"https://www.smart-pv.net/explainCH.html";
    }else if ([[self getPreferredLanguage] rangeOfString:@"ja"].location != NSNotFound)
    {
        filePath = [[NSBundle mainBundle]pathForResource:@"WeChat_1470645020" ofType:@"png"];
        webUrl = @"https://www.smart-pv.net/explainJP.html";
    }else if ([[self getPreferredLanguage] rangeOfString:@"en"].location != NSNotFound)
    {
        filePath = [[NSBundle mainBundle]pathForResource:@"WeChat_1469444362" ofType:@"png"];
        webUrl = @"https://www.smart-pv.net/explainEN.html";
    }else{
        
        filePath = [[NSBundle mainBundle]pathForResource:@"WeChat_1469444362" ofType:@"png"];
        webUrl = @"https://www.smart-pv.net/explainCH.html";
    }
    
//    if (filePath)
//    {
//        NSURL *url = [NSURL fileURLWithPath:filePath];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        [self.ib_webView  loadRequest:request];
//    }
    
    if (webUrl)
    {
        NSURL *url = [NSURL URLWithString:webUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.ib_webView  loadRequest:request];
    }

}

- (NSString*)getPreferredLanguage

{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    
    NSString * preferredLang = [allLanguages objectAtIndex:0];
    
    NSLog(@"当前语言:%@", preferredLang);
    
    return preferredLang;
    
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
