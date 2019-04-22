//
//  LSDPage3ViewController.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/16.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDPage3ViewController.h"
#import "NSDate+Addition.h"

#import "LSDMsgListViewController.h"

@interface LSDPage3ViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *ib_pac_today;
@property (weak, nonatomic) IBOutlet UILabel *ib_pac_month;
@property (weak, nonatomic) IBOutlet UILabel *ib_pac_year;
@property (weak, nonatomic) IBOutlet UILabel *ib_pac_total;
@property (weak, nonatomic) IBOutlet UILabel *ib_kwh;

@property (weak, nonatomic) IBOutlet UILabel *ib_pac_todayTitle;
@property (weak, nonatomic) IBOutlet UILabel *ib_styleTitle;
@property (weak, nonatomic) IBOutlet UILabel *ib_styleOk;
@property (weak, nonatomic) IBOutlet UILabel *ib_styleNo;
@property (weak, nonatomic) IBOutlet UILabel *ib_pac_monthTitle;
@property (weak, nonatomic) IBOutlet UILabel *ib_pac_yearTitle;
@property (weak, nonatomic) IBOutlet UILabel *ib_pac_totalTitle;
@property (weak, nonatomic) IBOutlet UILabel *ib_kwhTitle;

@property (weak, nonatomic) IBOutlet UILabel *ib_styleOkNum;
@property (weak, nonatomic) IBOutlet UILabel *ib_styleNoNum;
@property (weak, nonatomic) IBOutlet UIButton *ib_btnShowList;
@property (weak, nonatomic) IBOutlet UIWebView *ib_webView;
@end

@implementation LSDPage3ViewController

-(void)navRightAction
{
    [self.navigationController pushViewController:[[LSDMsgListViewController alloc] init] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:LocalString(@"p1_app_name")];
    
    __weak LSDPage3ViewController *selfWeak = self;
    
    [self addLeftNavBarWithImage:[UIImage imageNamed:@"back.png"] block:^{
        [selfWeak.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self addRightNavBarWithImage:[UIImage imageNamed:@"msg.png"]];
    [self initViewData];
    
    [self initData];
 
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNum) name:@"UpdateNumUnRead" object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self getNum];
}

-(void)getNum
{
    NSString* urlStr = [NSString stringWithFormat:@"%@", API_URL_GetShuliang];
    
    NSDictionary *params = @{@"userId":[USER_DEFAULT stringForKey:KEY_USERID],
                             @"GetLixian_Shebei_Time":[self stringForDataApi:@"GetLixian_Shebei"],
                             @"GetLixian_Caijiqi_Time":[self stringForDataApi:@"GetLixian_Caijiqi"],
                             @"GetTingji_Shebei_Time":[self stringForDataApi:@"GetLixian_Shebei"],
                             @"GetTingji_Dianzhan_Time":[self stringForDataApi:@"GetTingji_Dianzhan"],
                             @"GetDixiao_Shebei_Time":[self stringForDataApi:@"GetDixiao_Shebei"],
                             @"GetDixiao_Dianzhan_Time":[self stringForDataApi:@"GetDixiao_Dianzhan"],
                             @"GetGuzhang_Time":[self stringForDataApi:@"GetGuzhang"],
                             @"GetGonggao_Time":[self stringForDataApi:@"GetGonggao"],};
    
    [self httpGetUrl:urlStr WithData:params completionHandler:^(NSDictionary *data) {
        
        NSInteger num = 0;
        
        if ([data stringForKey:@"Gonggao_UnReadNum"].length>0) {
            num += [data integerForKey:@"Gonggao_UnReadNum"];
        }
        
        if ([data stringForKey:@"Guzhang_UnReadNum"].length>0) {
            num += [data integerForKey:@"Guzhang_UnReadNum"];
        }
        
        if ([data stringForKey:@"Lixian_Caijiqi_UnReadNum"].length>0) {
            num += [data integerForKey:@"Lixian_Caijiqi_UnReadNum"];
        }
        
        if ([data stringForKey:@"Lixian_Shebei_UnReadNum"].length>0) {
            num += [data integerForKey:@"Lixian_Shebei_UnReadNum"];
        }
        
        if ([data stringForKey:@"Tingji_Shebei_UnReadNum"].length>0) {
            num += [data integerForKey:@"Tingji_Shebei_UnReadNum"];
        }
        
        if ([data stringForKey:@"Tingji_Dianzhan_UnReadNum"].length>0) {
            num += [data integerForKey:@"Tingji_Dianzhan_UnReadNum"];
        }
        
        if ([data stringForKey:@"Dixiao_Shebei_UnReadNum"].length>0) {
            num += [data integerForKey:@"Dixiao_Shebei_UnReadNum"];
        }
        
        if ([data stringForKey:@"Dixiao_Dianzhan_UnReadNum"].length>0) {
            num += [data integerForKey:@"Dixiao_Dianzhan_UnReadNum"];
        }
        
        NSString *brageStr = @"";
        
        if (num>0) {
            brageStr = [NSString stringWithFormat:@"%ld", (long)num];
        }
        
        if (num>99) {
            brageStr = [NSString stringWithFormat:@"..."];
        }
        
        [self addRightNavBarWithImage:[UIImage imageNamed:@"msg.png"] text:brageStr];
        
    } errorHandler:^(NSString *errMsg) {
        
    }];
}

//本地化
-(void)initViewData
{
//    ViewBorderRadius(self.ib_btnShowList, 3.0, 2, [UIColor whiteColor]);
    [self.ib_btnShowList setTitle:LocalString(@"电站列表") forState:UIControlStateNormal];
    
    self.ib_pac_todayTitle.text = LocalString(@"今日发电量");
    self.ib_styleTitle.text = LocalString(@"电站状态");
    
    self.ib_pac_monthTitle.text = LocalString(@"月发电量1");
    self.ib_pac_yearTitle.text = LocalString(@"年发电量1");
    self.ib_pac_totalTitle.text = LocalString(@"累计");
    self.ib_kwhTitle.text = LocalString(@"发电所容量");
    
    self.ib_styleOk.text = LocalString(@"正常");
    self.ib_styleNo.text = LocalString(@"总数");
    
//    self.ib_pac_total.textColor = [UIColor colorWithRed:253/255.0 green:137/255.0 blue:0/255.0 alpha:1.0];
    
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"sun" ofType:@"gif"]];
    
    [self.ib_webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];

}

-(NSString *)reSetValue:(NSString*)strValue
{
    if ([strValue integerValue]>1000000) {
        return [NSString stringWithFormat:@"%.2f GWh",[strValue floatValue]/1000000];
    }
    
    if ([strValue integerValue]>1000) {
        return [NSString stringWithFormat:@"%.2f MWh",[strValue floatValue]/1000];
    }
    
    return [NSString stringWithFormat:@"%@ kWh",strValue];
    return @"";
}

-(NSString *)reSetValue0:(NSString*)strValue
{
    if ([strValue integerValue]>1000000) {
        return [NSString stringWithFormat:@"%.2f GW",[strValue floatValue]/1000000];
    }
    
    if ([strValue integerValue]>1000) {
        return [NSString stringWithFormat:@"%.2f MW",[strValue floatValue]/1000];
    }
    return [NSString stringWithFormat:@"%@ kW",strValue];
    return @"";
}

//
-(void)initData
{
    [self addMBProgressHUD];
    NSDictionary *pram = @{@"userId":[USER_DEFAULT stringForKey:KEY_USERID]};
    
    NSString* urlStr = [NSString stringWithFormat:@"%@", API_URL_GetUserPac];
    
    [self httpGetUrl:urlStr WithData:pram completionHandler:^(NSDictionary *data) {
        [self dissMBProgressHUD];
        
//        self.ib_pac_today.text = [self reSetValue:[data stringForKey:@"pac_today"]];
        self.ib_pac_today.attributedText = 
        [self attributeString:[self reSetValue:[data stringForKey:@"pac_today"]] rangeStringLenth:3 font:[UIFont systemFontOfSize:10.0] value:[UIColor whiteColor]];
        
//        self.ib_pac_month.text = [self reSetValue:[data stringForKey:@"pac_month"]];
        self.ib_pac_month.attributedText = [self attributeString:[self reSetValue:[data stringForKey:@"pac_month"]] rangeStringLenth:3 font:[UIFont systemFontOfSize:10.0]];
        
//        self.ib_pac_year.text = [self reSetValue:[data stringForKey:@"pac_year"]];
        self.ib_pac_year.attributedText = [self attributeString:[self reSetValue:[data stringForKey:@"pac_year"]] rangeStringLenth:3 font:[UIFont systemFontOfSize:10.0]];
        
//        self.ib_pac_total.text = [self reSetValue:[data stringForKey:@"pac_total"]];
        self.ib_pac_total.attributedText =
        [self attributeString:[self reSetValue:[data stringForKey:@"pac_total"]] rangeStringLenth:3 font:[UIFont systemFontOfSize:10.0]];
        
    } errorHandler:^(NSString *errMsg) {
        [self dissMBProgressHUD];
    }];

    NSDictionary *pram0 = @{@"userId":[USER_DEFAULT stringForKey:KEY_USERID]};
    NSString* urlStr0 = [NSString stringWithFormat:@"%@", API_URL_GetPsInfo];
    
    [self httpGetUrl:urlStr0 WithData:pram0 completionHandler:^(NSDictionary *data) {
        
//        NSArray *mListData = [data arrayForKey:@"PsInfo"];
        NSArray *mListData = [self isNoArr:data key:@"PsInfo"];
        CGFloat total =0.00;
        for (NSDictionary *mdic in mListData) {
            NSString *str = [mdic stringForKey:@"Capacity"];
            total = total+ [[str substringToIndex:str.length-2] floatValue];
        }
        
//        self.ib_kwh.text = [self reSetValue0:[NSString stringWithFormat:@"%.2f",total]];
        self.ib_kwh.attributedText = [self attributeString:[self reSetValue0:[NSString stringWithFormat:@"%.2f",total]] rangeStringLenth:2 font:[UIFont systemFontOfSize:10.0]];
        
        
        if (mListData)
        {
            self.ib_styleNoNum.text = [NSString stringWithFormat:@"%zd", [mListData count]];
            
//            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.Status == '正常' OR SELF.Status == '停机' OR SELF.Status == '部分停机'"];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.Status == '正常'"];
            NSArray *okArr = [mListData filteredArrayUsingPredicate: predicate];
            
            self.ib_styleOkNum.text = [NSString stringWithFormat:@"%zd", [okArr count]];
        }
        
        if(mListData && mListData.count>0)
        {
            if ([[[mListData firstObject]stringForKey:@"Status"] isEqualToString:@"-"]) {
                self.ib_styleOkNum.text = @"-";
            }
        }
        
        
    } errorHandler:^(NSString *errMsg) {

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableAttributedString*)attributeString:(NSString*)string rangeString:(NSString*)apartString value:(UIColor*)aColor
{
    NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange firstRange = [string rangeOfString:apartString];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:aColor range:firstRange];
    return attributeStr;
}

- (NSMutableAttributedString*)attributeString:(NSString*)string rangeStringLenth:(NSInteger)apartStrLength font:(UIFont*)aFont
{
    NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange firstRange = NSMakeRange(string.length-apartStrLength, apartStrLength);
    [attributeStr addAttribute:NSFontAttributeName value:aFont range:firstRange];
    return attributeStr;
}

- (NSMutableAttributedString*)attributeString:(NSString*)string rangeStringLenth:(NSInteger)apartStrLength font:(UIFont*)aFont value:(UIColor*)aColor
{
    NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange firstRange = NSMakeRange(string.length-apartStrLength, apartStrLength);
    
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:aColor, NSFontAttributeName:aFont} range:firstRange];

//    [attributeStr addAttribute:NSFontAttributeName value:aFont range:firstRange];
    
//    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:253/255.0 green:137/255.0 blue:0 alpha:1.0] range:NSMakeRange(0, string.length-apartStrLength)];
    
//    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:firstRange];
    return attributeStr;
}

-(NSString*)stringForDataApi:(NSString*)api
{
    NSString *lastTime = [[NSUserDefaults standardUserDefaults] stringForKey:[NSString stringWithFormat:@"lastTime%@", api]];
    if (lastTime==nil) {
        lastTime = @"";
    }
    return lastTime;
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
