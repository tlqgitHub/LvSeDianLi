//
//  LSDTitleViewCell.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/29.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDTitleViewCell.h"
#import "ACMacros.h"
#import "UIImageView+AFNetworking.h"
#import "NSDictionary+SafeAccess.h"

@implementation LSDTitleViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(NSDictionary*)data
{
    ViewBorderRadius(self.ib_contentView, 5, 1, [UIColor whiteColor]);
//    [self.ib_img_icon setImageWithURL:[NSURL URLWithString:[data stringForKey:@"PhotoFile"]]];
//    self.ib_lbName.text = [data stringForKey:@"Name"];
    
    self.ib_lbpaomaName.text = [data stringForKey:@"Name"];
    self.ib_lbpaomaName.textColor = [UIColor colorWithRed:90/255.0 green:117/255.0 blue:84/255.0 alpha:1];
//    [self setPAOMA:self.ib_lbName];
}

-(void)setPAOMA:(UILabel*)label
{
    CGRect frame = label.frame;
    frame.origin.x = label.frame.origin.x;
    label.frame = frame;
    [UIView beginAnimations:@"testAnimation"context:NULL];
    [UIView setAnimationDuration:10.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:999999];
    frame = label.frame;
    frame.origin.x =-160;
    label.frame = frame;
    [UIView commitAnimations];
}
-(void)setPaoMaDeng:(UILabel*)labelShow
{
    [labelShow sizeToFit];
    CGRect frame = labelShow.frame;
    frame.origin.x = 320;
    labelShow.frame = frame;
    
    [UIView beginAnimations:@"testAnimation" context:NULL];
    [UIView setAnimationDuration:8.8f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:999999];
    
    frame = labelShow.frame;
    frame.origin.x = -frame.size.width;
    labelShow.frame = frame;
    [UIView commitAnimations];
}

@end
