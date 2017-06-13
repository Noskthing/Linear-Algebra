//
//  LATextField.h
//  Linear Algebra
//
//  Created by ml on 2017/6/12.
//  Copyright © 2017年 Noskthing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LATextFieldView : UIView

@end

@interface LATextField : UIView

@property (nonatomic,strong)UIButton * okBtn;

@property (nonatomic,strong)NSString * text;

- (void)resignFirstResponder;

@end
