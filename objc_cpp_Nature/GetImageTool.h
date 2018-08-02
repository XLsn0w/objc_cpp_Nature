//
//  ImageDownloader.h
//  objc_cpp_Nature
//
//  Created by HL on 2018/7/31.
//  Copyright © 2018年 XL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^GetImageBlock)(UIImage *image);

@interface GetImageTool : NSObject

//单例
+ (instancetype)shared;

//下载图片并用Block返回
- (void)setImageWithURL:(NSURL *)url
               getImage:(GetImageBlock)getImage;

@end
