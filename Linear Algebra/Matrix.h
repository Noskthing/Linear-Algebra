//
//  Matrix.h
//  Linear Algebra
//
//  Created by ml on 2017/6/13.
//  Copyright © 2017年 Noskthing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Matrix : NSObject

@property (nonatomic, assign)BOOL columnIsCertain;
@property (nonatomic, assign)NSInteger row;
@property (nonatomic, assign)NSInteger column;

@property (nonatomic, assign)NSInteger currentColumn;

#pragma mark others
- (void)log;
- (BOOL)isFull;
- (BOOL)isTransposed;
- (void)transpose;

#pragma mark add methods
- (void)newRow;
- (BOOL)addObject:(id)object;
- (void)setDataSource:(NSMutableArray *)datasource;

#pragma mark delete methods
- (id)deleteObject;

#pragma mark  get methods
- (id)getObjectAtRow:(NSInteger)row Column:(NSInteger)column;
- (id)getObjectAtRow:(NSInteger)row Column:(NSInteger)column NoneValue:(NSString *)str;
- (NSInteger)getRealColumn;
@end
