//
//  HelloWorld.h
//  Test
//
//  Created by Alex on 2012-12-27.
//  Copyright (c)  2012 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Document.h"


@interface IDE : NSObject {
    IBOutlet NSWindow *mainWindow;
    Document *document;

}

@property (retain) IBOutlet NSTextView *codeEditor;
@property (retain) IBOutlet NSTextView *consoleView;

-(IBAction) open:(id) sender;
-(IBAction) compile:(id) sender;
-(IBAction) run:(id) sender;
-(IBAction) save:(id) sender;
-(IBAction) saveAs:(id) sender;
-(IBAction) print:(id) sender;

-(void) console:(NSString *) text;
-(void) clearConsole;
-(void) compileDocument:(Document *) doc;
-(void) updateGUI;

@end
