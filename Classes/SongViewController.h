//
//  SongViewController.h
//  Gripthumb-iOS
//
//  Created by Sean Doyle on 3/13/14.
//
//

#import <UIKit/UIKit.h>
#import "SongModel.h"

@interface SongViewController : UIViewController<UITableViewDataSource,UITableViewDelegate> {
    IBOutlet UILabel* name;
    IBOutlet UILabel* artistName;
    IBOutlet UITableView* table;
}


@property (atomic, strong) SongModel* song;
@property (atomic, strong) NSArray<PartModel>* parts;

- (void) loadSong:(SongModel*) songToLoad;
- (IBAction)close:(id)sender;

@end
