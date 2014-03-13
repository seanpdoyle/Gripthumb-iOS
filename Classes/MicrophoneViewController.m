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
#define FINGERPRINTING_INTERVAL 2

- (void)viewDidLoad
{
    [super viewDidLoad];
    recording = NO;
    spinnerView.hidesWhenStopped = YES;
    fingerprinter = [[Fingerprinter alloc] init];
    gripthumber = [[Gripthumber alloc] init];
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

- (void) showResults:(SongModel*) song {
    
}

- (void)scheduleFingerprint {
    if(recording){
        [self performSelector:@selector(fingerprintSong)
                   withObject:self
                   afterDelay:FINGERPRINTING_INTERVAL];
    }
}

- (void)fingerprintSong {
    if(secondsPassed > MAX_RECORDED_SECONDS) {
        [self performSelectorOnMainThread:@selector(stopRecording)
                               withObject:nil
                            waitUntilDone:YES];
    } else {
        NSString* fingerprint = [fingerprinter fingerprint];
        NSLog(@"Fingerprinted: %@", fingerprint);
        SongModel* song = [gripthumber gripthumb:fingerprint];
        
        if(song != nil) {
            [self performSelectorOnMainThread:@selector(showResults)
                                   withObject:song
                                waitUntilDone:YES];
        } else {
            [self scheduleFingerprint];
        }
    }
}

@end