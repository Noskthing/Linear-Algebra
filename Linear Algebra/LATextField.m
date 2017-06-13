//
//  LATextField.m
//  Linear Algebra
//
//  Created by ml on 2017/6/12.
//  Copyright © 2017年 Noskthing. All rights reserved.
//

#import "LATextField.h"
#import "Matrix.h"

#pragma mark LATextFieldButton
@interface LATextFieldButton : UIView

@property (nonatomic, strong) UIButton * button;
@property (nonatomic, strong) UIView * lineView;

- (void)setButtonTitle:(NSString *)title;

@end

@implementation LATextFieldButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.lineView = [[UIView alloc] initWithFrame:(CGRect){0, 0, frame.size.width, frame.size.height}];
        self.lineView.layer.borderColor = [UIColor colorWithRed:206/255.0 green:207/255.0 blue:208/255.0 alpha:1].CGColor;
        self.lineView.layer.borderWidth = 0.5;
        [self addSubview:self.lineView];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Thin" size:20.f];;
        self.button.frame = CGRectMake(0.4, 0.4, frame.size.width - 0.4, frame.size.height - 0.4);
        self.button.backgroundColor = [UIColor colorWithRed:231/255.0 green:232/255.0 blue:233/255.0 alpha:1];
        [self.button setBackgroundImage:[LATextFieldButton imageColor:[UIColor colorWithRed:247/255. green:247/255. blue:247/255. alpha:1.]] forState:UIControlStateNormal];
        [self.button setBackgroundImage:[LATextFieldButton imageColor:[UIColor colorWithRed:231/255.0 green:232/255.0 blue:233/255.0 alpha:1]] forState:UIControlStateHighlighted];
        [self addSubview:self.button];
    }
    return self;
}

- (void)setButtonTitle:(NSString *)title
{
    [self.button setTitle:title forState:UIControlStateNormal];
}

+ (UIImage *)imageColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end

#pragma mark LATextFieldView

@interface LATextFieldView ()

@property (nonatomic, copy)NSMutableString * tempStr;

@property (nonatomic, assign)BOOL isFloat;

@property (nonatomic, strong)Matrix * matrix;

@end

static const NSInteger row =5;
static const NSInteger column = 4;

@implementation LATextFieldView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _tempStr = [NSMutableString string];
        _isFloat = NO;
        _matrix = [[Matrix alloc] init];
        
        CGFloat buttonWidth = frame.size.width/column;
        CGFloat buttonHeight = frame.size.height/row;
        NSArray * titles = @[@"det", @"A-1", @"AT", @"C",
                             @"7", @"8", @"9", @"x",
                             @"4", @"5", @"6", @"√",
                             @"1", @"2", @"3", @"→",
                             @".", @"0", @"+/-", @"="];
        for (int i = 0; i < row * column; i ++)
        {
            NSInteger r = i/column;
            NSInteger c = i%column;
            LATextFieldButton * btn = [[LATextFieldButton alloc] initWithFrame:CGRectMake(c * buttonWidth, r * buttonHeight, buttonWidth, buttonHeight)];
            [btn setButtonTitle:titles[i]];
            [self addSubview:btn];
            if ((r > 0 && r < 4 && c < 3) || (r == 4 && c == 1))
            {
                btn.button.tag = [titles[i] integerValue] + 20;
                [btn.button addTarget:self action:@selector(numberButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
                continue;
            }
            else if (r == 0 && c == 0)
            {
                //det
                btn.button.tag =  50 + 0;
            }
            else if (r == 0 && c == 1)
            {
                //A-1
                btn.button.tag =  50 + 1;
            }
            else if (r == 0 && c == 2)
            {
                //AT
                btn.button.tag =  50 + 2;
            }
            else if (r == 0 && c == 3)
            {
                //C
                btn.button.tag =  50 + 3;
            }
            else if (r == 1 && c == 3)
            {
                //x
                btn.button.tag =  50 + 4;
            }
            else if (r == 2 && c == 3)
            {
                //huanhang
                btn.button.tag =  50 + 5;
            }
            else if (r == 3 && c == 3)
            {
                //next
                btn.button.tag =  50 + 6;
            }
            else if (r == 4 && c == 3)
            {
                //equal
                btn.button.tag =  50 + 7;
            }
            else if (r == 4 && c == 0)
            {
                //.
                btn.button.tag =  50 + 8;
            }
            else if (r == 4 && c == 2)
            {
                //+/-
                btn.button.tag =  50 + 9;
                btn.button.enabled = !self.isFloat;
            }
            [btn.button addTarget:self action:@selector(symbolButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

- (void)numberButtonTouched:(UIButton *)button
{
    NSLog(@"num %ld clicked!",button.tag - 20);
    [_tempStr appendString:[NSString stringWithFormat:@"%ld",button.tag - 20]];
}

- (void)symbolButtonTouched:(UIButton *)button
{
    switch (button.tag - 50)
    {
        case 0:
        {
            //det
            NSLog(@"det click");
        }
            break;
        case 1:
        {
            //A-1
            NSLog(@"A-1 click");
        }
            break;
        case 2:
        {
            //AT
            NSLog(@"AT click");
            [_matrix log];
        }
            break;
        case 3:
        {
            //C
            NSLog(@"C click");
        }
            break;
        case 4:
        {
            //x
            NSLog(@"x click");
        }
            break;
        case 5:
        {
            //huanhang
            NSLog(@"huanhang click");
            _tempStr = [[NSMutableString alloc] init];
            [_matrix newRow];
        }
            break;
        case 6:
        {
            //next
            NSLog(@"next click");
            button.enabled = [_matrix addObject:_tempStr];
            _tempStr = [[NSMutableString alloc] init];
        }
            break;
        case 7:
        {
            //equal
            NSLog(@"equal click");
            
        }
            break;
        case 8:
        {
            //.
            NSLog(@". click");
        }
            break;
        case 9:
        {
            //+/-
            NSLog(@"+/- click");
        }
            break;
        default:
            break;
    }
}
@end

#pragma mark LATextField
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
        
        LATextFieldView * view = [[LATextFieldView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.35)];
        
        CGFloat height = frame.size.height - 2 * edge;
        self.backgroundColor = [UIColor colorWithRed:247/255. green:247/255. blue:247/255. alpha:1.];
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(edge, edge, frame.size.width - 3 * edge - okBtnWidth, height)];
        self.textField.borderStyle = UITextBorderStyleRoundedRect;
        self.textField.delegate = self;
        self.textField.inputView = view;
        [self.textField becomeFirstResponder];
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
