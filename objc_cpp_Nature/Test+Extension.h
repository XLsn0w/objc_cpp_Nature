//
//  Test+Extension.h
//  objc_cpp_Nature
//
//  Created by HL on 2018/7/31.
//  Copyright © 2018年 XL. All rights reserved.
//

#import "Test.h"

@interface Test (Extension) <NSCopying>
- (void)test;
+ (void)abc;
@property (assign, nonatomic) int age;
- (void)setAge:(int)age;
- (int)age;



@end
