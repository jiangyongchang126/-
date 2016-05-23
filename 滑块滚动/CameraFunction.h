//
//  CameraFunction.h
//  ShuBao
//
//  Created by Longshine on 14-12-23.
//  Copyright (c) 2014年 Longshine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CameraFunction : NSObject <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerControllerSourceType _sourceType;
    UIImagePickerControllerCameraDevice _device;
}

@property (copy ,nonatomic) void (^SelectImage)(UIImage *);
@property (assign, nonatomic) UIViewController *delegateVC;
singleton_interface(CameraFunction);

+ (void)cameraWillShowInController:(UIViewController *)vc;

@end
