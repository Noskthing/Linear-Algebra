
//
//  LAView.m
//  Linear Algebra
//
//  Created by ml on 2017/6/12.
//  Copyright © 2017年 Noskthing. All rights reserved.
//

#import "LAView.h"

@implementation LAView

/*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect
{
    //设置字体样式
    UIFont *helveticaBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0f];
    /* Load the color */
    UIColor *magentaColor =[UIColor colorWithRed:0.5f
                                           green:0.0f blue:0.5f
                                           alpha:1.0f];
    /* Set the color in the graphical context */
    [magentaColor set];
    
    
    //文字内容
    NSString *myString = @"2  3  -2  10";
    
    CGSize size=[myString sizeWithAttributes:@{NSFontAttributeName:helveticaBold}];
    NSLog(@"w is %f, h is %f",size.width, size.height);
    //在屏 幕上 x 轴的 25 及 y 轴 190 处以 30 点的字体画出一个简单的字符串
    //    [myString drawAtPoint:CGPointMake(25, 190) withFont:helveticaBold];
    [myString drawInRect:CGRectMake(100, 200, size.width, size.height) withAttributes:@{NSFontAttributeName:helveticaBold}];
    
    NSString *myString1 = @"0  3  -2  12";
    //在屏 幕上 x 轴的 25 及 y 轴 190 处以 30 点的字体画出一个简单的字符串
    //    [myString drawAtPoint:CGPointMake(25, 190) withFont:helveticaBold];
    [myString1 drawInRect:CGRectMake(100, 200 + size.height + 20, size.width, size.height) withAttributes:@{NSFontAttributeName:helveticaBold}];
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(95, 200)];
    [path addLineToPoint:CGPointMake(90, 200)];
    [path addLineToPoint:CGPointMake(90, size.height * 2 + 200 + 20)];
    [path addLineToPoint:CGPointMake(95, size.height * 2 + 200 + 20)];
    
    path.lineWidth = 2.;
    [path stroke];
    
    UIBezierPath * path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(100 + size.width, 200)];
    [path1 addLineToPoint:CGPointMake(100 + size.width + 5, 200)];
    [path1 addLineToPoint:CGPointMake(100 + size.width + 5, size.height * 2 + 200 + 20)];
    [path1 addLineToPoint:CGPointMake(100 + size.width, size.height * 2 + 200 + 20)];
    
    path1.lineWidth = 2.;
    [path1 stroke];
}


@end
