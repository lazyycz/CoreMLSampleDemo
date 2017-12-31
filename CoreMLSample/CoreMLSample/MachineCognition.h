//
//  MachineCognition.h
//  CoreMLSample
//
//  Created by Stone.Yu on 2017/12/31.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>

@interface MachineCognition : NSObject

+ (NSString *)googlePredictImageScene:(CMSampleBufferRef)sampleBuffer;

+ (NSString *)squeezeNetPredictImageScene:(CMSampleBufferRef)sampleBuffer;

+ (NSString *)inceptionv3NetPredictImageScene:(CMSampleBufferRef)sampleBuffer;

@end
