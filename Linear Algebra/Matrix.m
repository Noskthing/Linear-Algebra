//
//  Matrix.m
//  Linear Algebra
//
//  Created by ml on 2017/6/13.
//  Copyright © 2017年 Noskthing. All rights reserved.
//

#import "Matrix.h"

@interface Matrix ()

@property (nonatomic, strong) NSMutableArray * array;
@end

@implementation Matrix

-(instancetype)init
{
    if (self = [super init])
    {
        _array = [NSMutableArray array];
        
        _columnIsCertain = NO;
        _row = 0;
        _column = -1;
        _currentColumn = -1;
    }
    return self;
}

#pragma mark add methods
-(BOOL)addObject:(id)object
{
    [_array addObject:object];
    _currentColumn ++;
    if (_columnIsCertain && _currentColumn == _column)
    {
        return NO;
    }
    return YES;
}

- (void)newRow
{
    //第一行换行，确定矩阵的列数
    if (_column == -1)
    {
        if (_currentColumn == -1)
        {
            _column = 0;
            [_array addObject:@"0"];
        }
        else
        {
            _column = _currentColumn;
        }
    }
    else
    {
        //新增行时如果当前行未满，补全为0
        if (_currentColumn != _column)
        {
            for (int i = 0; i < _column - _currentColumn; i ++)
            {
                [_array addObject:@"0"];
            }
        } 
    }
    
    
    _currentColumn = -1;
    _row ++;
}


#pragma mark  others
- (void)log
{
    NSInteger c = _column == -1?_currentColumn:_column;
    NSLog(@"row is %ld, column is %ld, array is %@", (long)_row, (long)c, _array);
    
    for (int i = 0; i <= _row; i++)
    {
        NSLog(@"--------");
        NSMutableString * str = [NSMutableString string];
        for (int j = 0; j <= c; j ++)
        {
            NSInteger index = i * c + j;
            
            if (_array.count > index)
            {
                [str appendString:[NSString stringWithFormat:@"%@ ",_array[index]]];
            }
        }
        NSLog(@"%@",str);
        NSLog(@"---------");
    }
}
@end
