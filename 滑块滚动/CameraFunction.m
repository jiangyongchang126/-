//
//  CameraFunction.m
//  ShuBao
//
//  Created by Longshine on 14-12-23.
//  Copyright (c) 2014年 Longshine. All rights reserved.
//

#import "CameraFunction.h"
#import "Helper.h"

@implementation CameraFunction

singleton_implementation(CameraFunction);

+ (void)cameraWillShowInController:(UIViewController *)vc
{
    _instance.delegateVC = vc;
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:_instance cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    action.tag = 1001;
    [action showInView:vc.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 || buttonIndex == 1) {
        
        if (actionSheet.tag == 1001) {
            
            if (buttonIndex == 1) {
                
                //相册
                _sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            else if (buttonIndex == 0) {
                
                //拍照
                UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"请选择拍照硬件" delegate:_instance cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"后置摄像头", @"前置摄像头", nil];
                action.tag = 1002;
                
                [action showInView:self.delegateVC.view];
                
                return;
            }
        }
        else if (actionSheet.tag == 1002) {
            
            _sourceType = UIImagePickerControllerSourceTypeCamera;
            
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                [Helper tipMessage:@"请前往设置-通用-相机中开启本应用权限" afterDelay:1.5 completion:^{
                    
                }];
            }
            else if (buttonIndex == 0) {
                
                if (![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
                    
                    [Helper tipMessage:@"设备不支持后置摄像头" afterDelay:1.5 completion:^{
                        
                    }];
                    return;
                }
                else
                {
                    _device = UIImagePickerControllerCameraDeviceRear;
                }
            }
            else if (buttonIndex == 1)
            {
                if (![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
                    
                    [Helper tipMessage:@"设备不支持前置摄像头" afterDelay:1.5 completion:^{
                        
                    }];
                    
                    return;
                }
                else
                {
                    _device = UIImagePickerControllerCameraDeviceFront;
                }
            }
        }
        
        UIImagePickerController *pick = [UIImagePickerController new];
        pick.sourceType = _sourceType;
        if (actionSheet.tag != 1001) {
            
            pick.cameraDevice = _device;
        }
        pick.delegate = self;
        pick.allowsEditing = YES;
        
        [self.delegateVC presentViewController:pick animated:YES completion:^{
            
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (self.SelectImage) {
        
        self.SelectImage(info[UIImagePickerControllerEditedImage]);
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        [picker removeFromParentViewController];
    }];
}

@end
