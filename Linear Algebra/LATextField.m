//
//  LATextField.m
//  Linear Algebra
//
//  Created by ml on 2017/6/12.
//  Copyright © 2017年 Noskthing. All rights reserved.
//

#import "LATextField.h"

static CGFloat edge = 5;
static CGFloat okBtnWidth = 50;
@interface LATextField ()<UITextFieldDelegate>

@property (nonatomic,strong)UITextField * textField;

@end

@implementation LATextField

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        CGFloat height = frame.size.height - 2 * edge;
        self.backgroundColor = [UIColor colorWithRed:247/255. green:247/255. blue:247/255. alpha:1.];
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(edge, edge, frame.size.width - 3 * edge - okBtnWidth, height)];
        self.textField.borderStyle = UITextBorderStyleRoundedRect;
        self.textField.delegate = self;
        [self addSubview:self.textField];
        
        self.okBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.textField.frame) + edge, edge, okBtnWidth, height)];
        self.okBtn.backgroundColor = [UIColor redColor];
        [self addSubview:self.okBtn];
    }
    return self;
}

-(void)setText:(NSString *)text
{
    self.textField.text = text;
}

-(NSString *)text
{
    return self.textField.text;
}

- (void)resignFirstResponder
{
    self.textField.text = @"";
    [self.textField resignFirstResponder];
}

#pragma mark  textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
