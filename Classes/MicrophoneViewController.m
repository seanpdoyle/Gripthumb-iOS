//
//  MicrophoneViewController.m
//  Gripthumb-iOS
//
//  Created by Sean Doyle on 3/12/14.
//
//

#import "MicrophoneViewController.h"
#import "SongViewController.h"

@interface MicrophoneViewController ()

@end

@implementation MicrophoneViewController

#define MAX_RECORDED_SECONDS 30
#define FINGERPRINTING_INTERVAL 2

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

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
}

- (IBAction)slayerButtonPressed:(id)sender {
    NSString* fingerprint = @"eJyll11uJSsMhLeE_7BZDjaw_yXcIg9zZiKFPFxF-RT1SXeDXVXmtNZ4tQdkv2D0gvcXxnrhzAdI-gv2hMsDTC80Hi_IesHGC-9anXyAaL4g8cIvtdIHuOUDv-hKnyh9Ye8HiJ74P_tleuGu7Ee0K8yfYU8MeSHphXetzF54OoVuj3_Eb9rwF2y-0OuFsV9IfmHTA8Txwv9x2bOSTewFkxc8Xni77PADdO__GWO-UPzCXg_wjbSfoflAE3nhl1mmL8x44dADv6T34AfeLmOeD8ARL7zzqscLb9Wd9sAvPrqB9zN-SaT1I3T2XRKTnOeShgwansl7dtk-6lDSwht4mHDo8j1TvXawdg-Vqs242Ao3RqSPrV2iLOceWgNBLFjgqTH2XGu4pZ_lk_Nm8EhjYhXTvsZh8YGRP3jZjG2OwdPHyD2pK2cNjjzWu5PlzhXDt8lcUyaOYzbPDkOl_JhUi94nb-uEv0bfZ-GH6fTE82vuI1u3qp2-sFOtvwDR8vdrf2Dl0nMfjVFCkliI6RHbXNNQm17bZdA6ccRRAB-npnQ_Ry1qkS9ZtEdIk0PWVu4YMklwgsIG4xhPi4NFjI6S6MzZQrokWoBt4qa2DxF2pBOvHmuE1uzfPuXgWTh2xYHH8nx9ulaLwjPZvz6VHJa9Cv1DxwTFlpHdYuOx00rWGTaQsFNybWu-Oh3H0ptiKX_gWGf7du2Do5v4-PKT3Rv1MjcNp8jqE53QRLt9UaCujDfhtRWQ0BJatQo1oXHCc_HtOfyxdpJ2SjYePISqJsTW-pk0jLfTCvHAXrXzgtq2nz63unk3H0x9u226z6rRF3p4blfRxrMZS47QhtIzxGMLmyMUg72jwVZ0RwrTtrot6zTG9FoLevwL-6R-v_YHxYdkXTvsRRgi0SFRTECe3KrN9iUpHHfNdswp3jZuSmw02izFoWO1DWlCEdQhcF9LnVkpTizMnb0cVRFY5eveVkNS1AZDKVjoqgictBnmtZPXjiS1ZdYumA_aoCu5QklN71tGZqcecIx6y8NjKXTgqq2QzCh4tj4NB6XdsTX46_iZ0c8HO1Deb9c-iJTOUHh0qZljEp7QNk4pK2AaQsDo0Y6AYjxJiNCfPophtRV8MnWoTa0zz2qGKtwYi8pmZ--czuXILfaaKGApggfdXAvBj5cRQm118Z1wGtqPIGuQo1s0mCKzuMOSnRVyW4JS1OIQVo2mSMHFLqEq0wQxVX3A36JnYG4oMk3zBszoXVigw907vtFBho4c5Bq4ZU-0pBp_gLpjZf9e-wBPTFQ4F8FTNBMFM1gCT0LsKEGRePV1Q-Y6FvDUvvGKhksJfuGNdm7wbB4VhOKPNm5zVuCoQ2F8BN3wbBAEMmwhG-2UwJrKupBETXSzRzVF4s7bqImQ2NAK-Z16aOf2heUcvLeugXQj4abmKAwDDshnqsjYlm2ZT9hRIKxIqG1jE4hJpBLyX_mMk5tPM-y1Y8w0TJjNELNDDNhQU92ujrQjDImTgZZ_sNHg_HbtA0QKhI-duWPoDYhoG_pxHHOsI0sEceStjPtExWlxYQOJGdWQQ_NmxFppkw_iHJYbZyq2XulBk74SP7Ygo3AoXqkyAhO1LYyJ7F9hCiPjSQZJobUoTzVaWXcWQevQLVJW7ncAhjUNyY1XpLIcyO-GaOs4MCNDkOAI50g9mCAbUdWgNsS5VUem9g_YTejbtQ8G5oEjQ7xDZimoN7IYi8NnOoqQlBAGIh57riyHCqj16zYM9WCkeUczInBgwMxwjFicIO6QxUkCCjWoZIzT73EAxmVoU7FGnKD8Fh7_e-OI7MwNH2H8Ixn4uh2VxWiGKjBIOZu4QJOJdDYKBHCDi-aEhav3deMK6YpzikH0RgVxDkRCX0gK6BOl-gA5ghz899oH_wGeH3Hx";

    SongModel* song = [gripthumber gripthumb:fingerprint];
    [self performSelectorOnMainThread:@selector(showResults:)
                           withObject:song
                        waitUntilDone:NO];
}

- (void) startRecording {
    recording = YES;
    recordButton.selected = YES;
    [spinnerView startAnimating];
    [fingerprinter record];
    [self scheduleFingerprint];
}

- (void) stopRecording {
    recording = NO;
    recordButton.selected = NO;
    [fingerprinter stop];
    [spinnerView stopAnimating];
}

- (void) showResults:(SongModel*) song {
    if (song == nil || song.parts.count < 1) {
        NSLog(@"Song without parts: %@", song);
        return;
    }
    
    [self stopRecording];
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Storyboard"
                                                         bundle:nil];
    
    SongViewController* songViewController = [storyboard instantiateViewControllerWithIdentifier:@"song"];
    
    [songViewController loadSong:song];
    
    [self.navigationController pushViewController:songViewController
                                         animated:YES];
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
                            waitUntilDone:NO];
    } else {
        NSString* fingerprint = [fingerprinter fingerprint];
        NSLog(@"Fingerprinted: %@", fingerprint);
        SongModel* song = [gripthumber gripthumb:fingerprint];
        
        if(song != nil && [song.parts count] > 0) {
            [self performSelectorOnMainThread:@selector(showResults:)
                                   withObject:song
                                waitUntilDone:NO];
        } else {
            [self scheduleFingerprint];
        }
    }
    secondsPassed = secondsPassed + FINGERPRINTING_INTERVAL;
}

@end