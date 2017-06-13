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

- (void)log;
- (void)newRow;
- (BOOL)addObject:(id)object;
@end
