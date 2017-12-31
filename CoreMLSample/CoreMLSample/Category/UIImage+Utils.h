//
//  UIImage+Utils.h
//  CoreMLSample
//
//  Created by Stone.Yu on 2017/12/31.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMedia/CoreMedia.h>

@interface UIImage (Utils)

- (UIImage *)scaleToSize:(CGSize)size;

- (CVPixelBufferRef)pixelBufferFromImage:(UIImage *)image;

+ (UIImage *)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer;

@end
