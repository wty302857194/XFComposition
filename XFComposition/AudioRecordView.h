//
//  AudioRecordView.h
//  XFComposition
//
//  Created by qiannian on 2018/5/11.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^AudioRecordViewBlock)(id recordFileUrl);

@interface AudioRecordView : UIView
@property (nonatomic, strong)   AVAudioSession *session;
@property (nonatomic, strong)   AVAudioRecorder *recorder;
@property (nonatomic, copy)   NSString *filePath;
@property (nonatomic, strong)   NSURL *recordFileUrl;
@property (nonatomic, copy)   AudioRecordViewBlock recordViewBlock;
@property (nonatomic, assign)   BOOL isStar;

@property (strong, nonatomic) IBOutlet UIButton *audioBtn;
@property (strong, nonatomic) IBOutlet UIView *audioView;


-(void)showAudioRecordView;

@end
