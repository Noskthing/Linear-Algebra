//
//  MatrixViewCollectionViewCell.h
//  Linear Algebra
//
//  Created by ml on 2017/6/15.
//  Copyright © 2017年 Noskthing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatrixViewCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIView *line;

@end
