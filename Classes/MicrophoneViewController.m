//
//  MicrophoneViewController.m
//  Gripthumb-iOS
//
//  Created by Sean Doyle on 3/12/14.
//
//

#import "MicrophoneViewController.h"

@interface MicrophoneViewController ()

@end

@implementation MicrophoneViewController

#define MAX_RECORDED_SECONDS 20

- (void)viewDidLoad
{
    [super viewDidLoad];
    recording = NO;
    spinnerView.hidesWhenStopped = YES;
    fingerprinter = [[Fingerprinter alloc] init];
}

- (IBAction)buttonWasPressed:(id)sender {
    if(recording) {
        [self stopRecording];
    } else {
        [self startRecording];
    }
    recordButton.selected = recording;
}

- (void) startRecording {
    recording = YES;
    [spinnerView startAnimating];
    [fingerprinter record];
    [self scheduleFingerprint];
}

- (void) stopRecording {
    recording = NO;
    [fingerprinter stop];
    [spinnerView stopAnimating];
}


- (void)scheduleFingerprint {
    if(recording){
        [self performSelector:@selector(fingerprintSong)
                   withObject:self
                   afterDelay:1];
    }
}

- (void)fingerprintSong {
    if(secondsPassed > MAX_RECORDED_SECONDS) {
        [self performSelectorOnMainThread:@selector(stopRecording)
                               withObject:nil
                            waitUntilDone:YES];
    } else {
        NSString* fpCode = [fingerprinter fingerprint];
        NSLog(@"Fingerprinted: %@", fpCode);
        [self scheduleFingerprint];
    }
}

@end