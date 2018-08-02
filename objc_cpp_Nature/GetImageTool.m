//
//  ImageDownloader.m
//  objc_cpp_Nature
//
//  Created by HL on 2018/7/31.
//  Copyright © 2018年 XL. All rights reserved.
//

#import "GetImageTool.h"

@interface GetImageTool ()

@property(nonatomic, strong) NSMutableArray *imageNameArray;

@end

@implementation GetImageTool

//初始化
- (instancetype)init {
    self = [super init];
    if (self) {
        self.imageNameArray = [[NSMutableArray alloc]init];
    }
    return self;
}
//单例
//声明全局变量

static GetImageTool *download = nil;

+ (instancetype)shared {
    @synchronized(self){
        if (download == nil) {
            download = [[self alloc] init];
        }}
    return download;
}

//下载图片并用Block返回
- (void)setImageWithURL:(NSURL *)url getImage:(GetImageBlock)getImage {
    //首先判断imageUrl 和imageBlock 正确则继续执行
    if (!url || !getImage) {
        return;
    }
    //获取文本路径
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [filePath stringByAppendingPathComponent:@"abcd"];
    NSLog(@"fileName= %@",fileName);
    //判断是否下载过
    if ([self.imageNameArray containsObject:url.path]) {
        //下载过的图片直接取
        NSData *data = [[NSData alloc]initWithContentsOfFile:fileName];
        UIImage *image = [[UIImage alloc]initWithData:data];
        //返回图片
        getImage(image);
        NSLog(@"在本地获取");
    }else{
        
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        ///[NSURLSession dataTaskWithRequest:completionHandler:]
        [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error || !data) {
                NSLog(@"error= %@", error);
                return ;
            }
            UIImage *image = [[UIImage alloc]initWithData:data];
            //返回图片
            getImage(image);
            //把data存到本地
            [data writeToFile:fileName atomically:YES];
            //把下载过的图片加到数组
            [self.imageNameArray addObject:url.path];
            NSLog(@"下载图片%@，并存储",image);
        }];
        
    }
    
}


@end
