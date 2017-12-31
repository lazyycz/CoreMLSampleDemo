//
//  MachineCognition.m
//  CoreMLSample
//
//  Created by Stone.Yu on 2017/12/31.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "MachineCognition.h"

#import "UIImage+Utils.h"

#import "GoogLeNetPlaces.h"
#import "SqueezeNet.h"
#import "Inceptionv3.h"

@implementation MachineCognition

+ (NSString *)googlePredictImageScene:(CMSampleBufferRef)sampleBuffer
{
    CVPixelBufferRef buffer = [self bufferRefFromSampleBuffer:sampleBuffer imageSize:CGSizeMake(224, 224)];
    
    NSError *error;
    GoogLeNetPlaces *model = [GoogLeNetPlaces new];
    GoogLeNetPlacesInput *input = [[GoogLeNetPlacesInput alloc] initWithSceneImage:buffer];
    GoogLeNetPlacesOutput *output = [model predictionFromFeatures:input error:&error];
    return output.sceneLabel;
}

+ (NSString *)squeezeNetPredictImageScene:(CMSampleBufferRef)sampleBuffer
{
    CVPixelBufferRef buffer = [self bufferRefFromSampleBuffer:sampleBuffer imageSize:CGSizeMake(227, 227)];
    
    NSError *error;
    SqueezeNet *squeezeNet = [SqueezeNet new];
    SqueezeNetInput *input = [[SqueezeNetInput alloc] initWithImage:buffer];
    SqueezeNetOutput *output = [squeezeNet predictionFromFeatures:input error:&error];
    return output.classLabel;
}

+ (NSString *)inceptionv3NetPredictImageScene:(CMSampleBufferRef)sampleBuffer
{
    CVPixelBufferRef buffer = [self bufferRefFromSampleBuffer:sampleBuffer imageSize:CGSizeMake(299, 299)];
    
    NSError *error;
    Inceptionv3 *inceptionv3 = [Inceptionv3 new];
    Inceptionv3Input *input = [[Inceptionv3Input alloc] initWithImage:buffer];
    Inceptionv3Output *output = [inceptionv3 predictionFromFeatures:input error:&error];
    return output.classLabel;
}

+ (CVPixelBufferRef)bufferRefFromSampleBuffer:(CMSampleBufferRef)sampleBuffer imageSize:(CGSize)size
{
    UIImage *image = [UIImage imageFromSampleBuffer:sampleBuffer];
    UIImage *scaledImage = [image scaleToSize:size];
    return [image pixelBufferFromImage:scaledImage];
}

@end
