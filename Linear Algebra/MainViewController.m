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
#import "MatrixView.h"

static NSString * MainVCTableViewCellID = @"MainVCTableViewCellID";

@interface MainViewController ()<LATextFieldViewDelegate>

@property (nonatomic, strong)MatrixView * matrixViewA;

@property (nonatomic, strong)MatrixView * matrixViewB;

@property (nonatomic, strong)UITableView * tableView;

@property (nonatomic, strong)LATextField * textField;

@property (nonatomic, strong)NumberEditView * numberView;

@property (nonatomic, strong)UILabel * multipSymbolView;

@property (nonatomic, assign)BOOL isMultiply;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _isMultiply = NO;
    [self createUI];
}

-(void)createUI
{
    _matrixViewA = [[MatrixView alloc] init];
    _matrixViewA.backgroundColor = [UIColor colorWithRed:227/255.0 green:231/255.0 blue:232/255.0 alpha:1.];
    _matrixViewA.layer.anchorPoint = CGPointMake(1, 0.5);
    _matrixViewA.layer.position = CGPointMake(self.view.frame.size.width - 5, (self.view.bounds.size.height * 0.55 - 35)/2);
    [self.view addSubview:_matrixViewA];
    
    _multipSymbolView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _multipSymbolView.layer.anchorPoint = CGPointMake(1, 0.5);
    _multipSymbolView.text = @"x";
    _multipSymbolView.textAlignment = NSTextAlignmentCenter;
    _multipSymbolView.backgroundColor = [UIColor colorWithRed:227/255.0 green:231/255.0 blue:232/255.0 alpha:1.];
    [self.view addSubview:_multipSymbolView];
    
    _matrixViewB = [[MatrixView alloc] init];
    _matrixViewB.hidden = YES;
    _matrixViewB.backgroundColor = [UIColor colorWithRed:227/255.0 green:231/255.0 blue:232/255.0 alpha:1.];
    _matrixViewB.layer.anchorPoint = CGPointMake(1, 0.5);
    _matrixViewB.layer.position = CGPointMake(self.view.frame.size.width - 5, (self.view.bounds.size.height * 0.55 - 35)/2);
    [self.view addSubview:_matrixViewB];
    
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

- (void)reloadMatrixView:(NSArray *)matrixs
{
    if (matrixs.count == 1)
    {
        Matrix * matrix = matrixs[0];
        _matrixViewA.frame = CGRectMake(0, 0, 50 * ([matrix getRealColumn] + 1) + 6, 20 * (matrix.row + 1) + 6);
        _matrixViewA.layer.position = CGPointMake(self.view.frame.size.width - 5, (self.view.bounds.size.height * 0.55 - 35)/2);
        [_matrixViewA setMatrix:matrix];
        
        _matrixViewB.hidden = YES;
        _multipSymbolView.hidden = YES;
    }
    else
    {
        _matrixViewB.hidden = NO;
        _multipSymbolView.hidden = NO;
        
        Matrix * matrixB = matrixs[1];
        _matrixViewB.frame = CGRectMake(0, 0, 50 * ([matrixB getRealColumn] + 1) + 6, 20 * (matrixB.row + 1) + 6);
        _matrixViewB.layer.position = CGPointMake(self.view.frame.size.width - 5, (self.view.bounds.size.height * 0.55 - 35)/2);
        [_matrixViewB setMatrix:matrixB];
        
        _multipSymbolView.layer.position = CGPointMake(CGRectGetMinX(_matrixViewB.frame) - 10, (self.view.bounds.size.height * 0.55 - 35)/2);
        
        Matrix * matrixA = matrixs[0];
        _matrixViewA.frame = CGRectMake(0, 0, 50 * ([matrixA getRealColumn] + 1) + 6, 20 * (matrixA.row + 1) + 6);
        _matrixViewA.layer.anchorPoint = CGPointMake(1, 0.5);
        _matrixViewA.layer.position = CGPointMake(CGRectGetMinX(_multipSymbolView.frame) - 10, (self.view.bounds.size.height * 0.55 - 35)/2);
    }
}

#pragma mark  textViewDelegate
- (void)textFieldViewNumberButtonTouched:(UIButton *)button Matrixs:(NSArray *)matrixs Chars:(NSArray *)chars IsNegative:(BOOL)isNegative TextFieldView:(LATextFieldView *)textFieldView
{
    Matrix * matrix = matrixs[matrixs.count - 1];
    [self layoutNumberEditViewWithmatrix:matrix IsNegative:isNegative Chars:chars];
}

- (void)textFieldViewSymbolButtonTouched:(UIButton *)button Matrixs:(NSArray *)matrixs Chars:(NSArray *)chars IsNegative:(BOOL)isNegative TextFieldView:(LATextFieldView *)textFieldView
{
    Matrix * matrix = matrixs[matrixs.count - 1];
    [self layoutNumberEditViewWithmatrix:matrix IsNegative:isNegative Chars:chars];
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
            [self reloadMatrixView:matrixs];
        }
            break;
        case 3:
        {
            //C
            if (_isMultiply)
            {
                _isMultiply = NO;
            }
            [self reloadMatrixView:matrixs];
        }
            break;
        case 4:
        {
            //x
            _isMultiply = YES;
            [self reloadMatrixView:matrixs];
        }
            break;
        case 5:
        {
            //huanhang
            [self reloadMatrixView:matrixs];
        }
            break;
        case 6:
        {
            //next
            [self reloadMatrixView:matrixs];
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

- (void)layoutNumberEditViewWithmatrix:(Matrix *)matrix IsNegative:(BOOL)isNegative Chars:(NSArray *)chars
{
    self.numberView.hidden = (chars.count == 0 || (matrix.column == matrix.currentColumn && matrix.column != -1));
    
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
    self.numberView.rowLabel.text = [NSString stringWithFormat:@"%ld",matrix.row];
    self.numberView.columnLabel.text = [NSString stringWithFormat:@"%ld",matrix.currentColumn + 1];
}


- (BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
