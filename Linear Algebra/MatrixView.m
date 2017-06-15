//
//  MatrixView.m
//  Linear Algebra
//
//  Created by ml on 2017/6/15.
//  Copyright © 2017年 Noskthing. All rights reserved.
//

#import "MatrixView.h"
#import "MatrixViewCollectionViewCell.h"

@interface MatrixView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView * collectionView;

@property (nonatomic, strong)Matrix * matrix;
@end

@implementation MatrixView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.contentMode = UIViewContentModeRedraw;
        
        //创建一个layout布局类
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置每个item的大小为100*100
        layout.itemSize = CGSizeMake(50, 20);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor colorWithRed:227/255.0 green:231/255.0 blue:232/255.0 alpha:1.];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        [self addSubview:self.collectionView];
        
        [self.collectionView registerNib:[UINib nibWithNibName:@"MatrixViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellid"];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (self.matrix && (self.matrix.row + 1) * ([self.matrix getRealColumn] + 1) > 0)
    {
        UIBezierPath * leftPath = [UIBezierPath bezierPath];
        [leftPath moveToPoint:CGPointMake(7, 2)];
        [leftPath addLineToPoint:CGPointMake(2, 2)];
        [leftPath addLineToPoint:CGPointMake(2, rect.size.height - 2)];
        [leftPath addLineToPoint:CGPointMake(7, rect.size.height - 2)];
        
        leftPath.lineWidth = 1.;
        [leftPath stroke];
        
        UIBezierPath * rightPath = [UIBezierPath bezierPath];
        [rightPath moveToPoint:CGPointMake(rect.size.width - 7, 2)];
        [rightPath addLineToPoint:CGPointMake(rect.size.width - 2, 2)];
        [rightPath addLineToPoint:CGPointMake(rect.size.width - 2, rect.size.height - 2)];
        [rightPath addLineToPoint:CGPointMake(rect.size.width - 7, rect.size.height - 2)];
        
        rightPath.lineWidth = 1.;
        [rightPath stroke];
    }
}

- (void)setMatrix:(Matrix *)matrix
{
    _collectionView.frame = CGRectMake(3, 3, self.frame.size.width - 6, self.frame.size.height - 6);
    _matrix = matrix;
    
    [_collectionView reloadData];
    [self setNeedsLayout];
}

#pragma mark  collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger ss = self.matrix?(self.matrix.row + 1) * ([self.matrix getRealColumn] + 1) : 0;
    NSLog(@"ss %ld  --- %ld ---- %ld",ss,self.matrix.row,[self.matrix getRealColumn]);
    return self.matrix?(self.matrix.row + 1) * ([self.matrix getRealColumn] + 1) : 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MatrixViewCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    NSInteger row = indexPath.row/(self.matrix.column + 1);
    NSInteger column = indexPath.row%(self.matrix.column + 1);
    cell.numberLabel.text = [self.matrix getObjectAtRow:row Column:column NoneValue:@""];
    return cell;
}
@end
