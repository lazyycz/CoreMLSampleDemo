//
//  VideoCapture.h
//  CoreMLSample
//
//  Created by Stone.Yu on 2017/12/31.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^recognitionCompleteBlock)(NSString *result);

@interface VideoCapture : NSObject

@property (nonatomic, copy) recognitionCompleteBlock completeBlock;

@property (nonatomic,strong) AVCaptureVideoPreviewLayer* previewLayer;

- (void)startVideoCapture;
- (void)stopVideoCapture;

@end
