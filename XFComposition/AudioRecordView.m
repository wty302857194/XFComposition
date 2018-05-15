//
//  AudioRecordView.m
//  XFComposition
//
//  Created by qiannian on 2018/5/11.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "AudioRecordView.h"
#import "lame.h"
@implementation AudioRecordView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib{
    
    [super awakeFromNib];
    
}
-(void)showAudioRecordView{
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:self];
 self.sd_layout.rightEqualToView(window).leftEqualToView(window).topEqualToView(window).bottomEqualToView(window);
    
}
- (IBAction)startRecord:(id)sender{
    
    UIButton * btn = (UIButton*)sender;
    
    [btn setSelected:!btn.isSelected];
    
    
    if (btn.isSelected) {
        
        AVAudioSession *session =[AVAudioSession sharedInstance];
        NSError *sessionError;
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        
        if (session == nil) {
            
            NSLog(@"Error creating session: %@",[sessionError description]);
            
        }else{
            [session setActive:YES error:nil];
            
        }
        
        self.session = session;
        
        
        //1.获取沙盒地址
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        _filePath = [path stringByAppendingString:@"/AudioRecord.caf"];
        
        //2.获取文件路径
        self.recordFileUrl = [NSURL fileURLWithPath:_filePath];
        
        //设置参数
        NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       //采样率  8000/11025/22050/44100/96000（影响音频的质量）
                                       [NSNumber numberWithFloat: 11025.0],AVSampleRateKey,
                                       // 音频格式
                                       [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                       //采样位数  8、16、24、32 默认为16
                                       [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                       // 音频通道数 1 或 2
                                       [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,
                                       //录音质量
                                       [NSNumber numberWithInt:AVAudioQualityHigh],AVEncoderAudioQualityKey,
                                       nil];
        
        
        _recorder = [[AVAudioRecorder alloc] initWithURL:self.recordFileUrl settings:recordSetting error:nil];
        
        if (_recorder) {
            
            _recorder.meteringEnabled = YES;
            [_recorder prepareToRecord];
            [_recorder record];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self stopRecord:nil];
            });
            
            
            
        }else{
            NSLog(@"音频格式和文件存储格式不匹配,无法初始化Recorder");
            
        }

        
    }else{
        
        if ([self.recorder isRecording]) {
            [self.recorder stop];
        }
        [self removeFromSuperview];
        if (_recordViewBlock) {
            _recordViewBlock([self audio_PCMtoMP3]);
        }
        
    }
    
    
}

#pragma mark ===== 转换成MP3文件=====
- (NSData*)audio_PCMtoMP3
{
    NSString *strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *mp3FilePath = [strUrl stringByAppendingPathComponent:@"lll.mp3"];
    
    @try {
        
        int read, write;
        
        FILE *pcm = fopen([_filePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 11025.0);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read =(int)fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        strUrl = mp3FilePath;
        NSData * data = [NSData dataWithContentsOfFile:mp3FilePath];
        NSLog(@"MP3生成成功: %@",strUrl);

        return data;
    }
    
}
- (IBAction)stopRecord:(id)sender {
    
    NSLog(@"停止录音");
    [_audioBtn setSelected:NO];

    if ([self.recorder isRecording]) {
        [self.recorder stop];
    }
    if (_recordViewBlock) {
        _recordViewBlock([self audio_PCMtoMP3]);
    }
    [self removeFromSuperview];

    
    
}
@end
