//
//  MainViewController.m
//  Linear Algebra
//
//  Created by ml on 2017/6/12.
//  Copyright © 2017年 Noskthing. All rights reserved.
//

#import "MainViewController.h"
#import "LATextField.h"
#import "NumberEditView.h"

static NSString * MainVCTableViewCellID = @"MainVCTableViewCellID";

@interface MainViewController ()<LATextFieldViewDelegate>



@property (nonatomic, strong)UITableView * tableView;

@property (nonatomic, strong)LATextField * textField;

@property (nonatomic, assign)BOOL keybordIsShow;

@property (nonatomic, strong)NumberEditView * numberView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initVar];
    [self createUI];
}

- (void)initVar
{
    
}

-(void)createUI
{
    self.view.backgroundColor = [UIColor colorWithRed:227/255.0 green:231/255.0 blue:232/255.0 alpha:1.];
    LATextFieldView * textView = [[LATextFieldView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 0.55, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.45)];
    textView.delegate = self;
    [self.view addSubview:textView];
    
    self.numberView = [[[NSBundle mainBundle] loadNibNamed:@"NumberEditView" owner:self options:nil] lastObject];
    self.numberView.hidden = YES;
    self.numberView.backgroundColor = [UIColor colorWithRed:227/255.0 green:231/255.0 blue:232/255.0 alpha:1.];;
    self.numberView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 0.55 - 35, self.view.frame.size.width, 30);
    [self.view addSubview:self.numberView];
}

#pragma mark  textViewDelegate
- (void)textFieldViewNumberButtonTouched:(UIButton *)button Matrix:(Matrix *)martix Chars:(NSArray *)chars IsNegative:(BOOL)isNegative TextFieldView:(LATextFieldView *)textFieldView
{
    [self layoutNumberEditViewWithMartix:martix IsNegative:isNegative Chars:chars];
}

- (void)textFieldViewSymbolButtonTouched:(UIButton *)button Matrix:(Matrix *)martix Chars:(NSArray *)chars IsNegative:(BOOL)isNegative TextFieldView:(LATextFieldView *)textFieldView
{
    [self layoutNumberEditViewWithMartix:martix IsNegative:isNegative Chars:chars];
    switch (button.tag - 50)
    {
        case 0:
        {
            //det
        }
            break;
        case 1:
        {
            //A-1
        }
            break;
        case 2:
        {
            //AT
        }
            break;
        case 3:
        {
            //C
        }
            break;
        case 4:
        {
            //x
        }
            break;
        case 5:
        {
            //huanhang
        }
            break;
        case 6:
        {
            //next
        }
            break;
        case 7:
        {
            //equal
        }
            break;
        case 8:
        {
            //.
        }
            break;
        case 9:
        {
            //+/-
        }
            break;
        default:
            break;
    }
}

- (void)layoutNumberEditViewWithMartix:(Matrix *)martix IsNegative:(BOOL)isNegative Chars:(NSArray *)chars
{
    self.numberView.hidden = (chars.count == 0 || (martix.column == martix.currentColumn && martix.column != -1));
    
    NSMutableString * str = [NSMutableString string];
    if (isNegative)
    {
        [str appendString:@"-"];
    }
    for (NSString * s in chars)
    {
        [str appendString:s];
    }
    self.numberView.numberLabel.text = str;
    self.numberView.rowLabel.text = [NSString stringWithFormat:@"%ld",martix.row];
    self.numberView.columnLabel.text = [NSString stringWithFormat:@"%ld",martix.currentColumn + 1];
}
@end
