//
//  AppController.h
//  LWBPChanger
//
//  Created by Deri Taufan on 8/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString *globFile;
@class FileDropView;

@interface AppController : NSObject {
	IBOutlet NSWindow *window;
	IBOutlet NSTextField *textField;
}
- (IBAction)changeSetting:(id)sender;


@end
