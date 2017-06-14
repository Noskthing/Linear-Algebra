//
//  LATextField.h
//  Linear Algebra
//
//  Created by ml on 2017/6/12.
//  Copyright © 2017年 Noskthing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Matrix.h"

@class LATextFieldView;
@protocol LATextFieldViewDelegate <NSObject>

@required
- (void)textFieldViewNumberButtonTouched:(UIButton *)button Matrix:(Matrix *)martix Chars:(NSArray *)chars IsNegative:(BOOL)isNegative TextFieldView:(LATextFieldView *)textFieldView;

- (void)textFieldViewSymbolButtonTouched:(UIButton *)button Matrix:(Matrix *)martix Chars:(NSArray *)chars IsNegative:(BOOL)isNegative TextFieldView:(LATextFieldView *)textFieldView;
@end

@interface LATextFieldView : UIView

@property (nonatomic,strong)id<LATextFieldViewDelegate> delegate;
@end

@interface LATextField : UIView

@property (nonatomic,strong)UIButton * okBtn;

@property (nonatomic,strong)NSString * text;

- (void)resignFirstResponder;

@end
