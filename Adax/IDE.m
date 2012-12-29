//
//  HelloWorld.m
//  Test
//
//  Created by Alex on 2012-12-27.
//  Copyright (c) 2012 Alex. All rights reserved.
//

#import "IDE.h"


@implementation IDE
@synthesize consoleView;
@synthesize codeEditor;


-(void)awakeFromNib {
    [mainWindow setTitle:@"New document"];
    [self updateGUI];
    document = [[Document alloc]init];
    
}



-(IBAction)save:(id)sender{
    [document setContent:[codeEditor string]];
    [document save];
    [mainWindow setTitle:document.name];
}

-(IBAction)saveAs:(id)sender{
    [document setContent:[codeEditor string]];
    
    NSSavePanel *panel	= [NSSavePanel savePanel];
    if([panel runModal] == NSOKButton){
        [document saveAs:[NSString stringWithFormat:@"%@",[panel URL]]];
    }
}

- (IBAction)open:(id)sender{
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel setCanChooseDirectories:NO];
    [panel setAllowsMultipleSelection:NO];
    [panel setAllowedFileTypes:[NSArray arrayWithObjects:@"txt",@"adb",@"ads",nil]];
    [panel beginWithCompletionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            
            for (NSURL *fileURL in [panel URLs]) {
                [document open:fileURL];
                [mainWindow setTitle:[NSString stringWithFormat:@"%@.%@", document.name, document.extension]];
                codeEditor.string = document.content;
                [self clearConsole];
                
                //upd set file browser to dir of openeded file
            }
        }
    }];
    
   
    [mainWindow setTitle:[NSString stringWithFormat:@"%@.%@",document.name, document.extension]];
}
- (IBAction)compile:(id)sender{
    [self compileDocument:document];
}
- (IBAction)run:(id)sender{
    [self compileDocument:document];
    [self runDocument:document];
}
- (IBAction)print:(id)sender{
    [document print];
}
- (void)runDocument:(Document *)doc{
    [self console:@"Running"];
}
- (void)compileDocument:(Document *)doc{
    [doc setContent:[codeEditor string]];
    [doc save];
    
    NSLog(@"Compiling %@", doc.path);
    
    NSString *processPath = @"/Users/user/alex/gnatmake";
    processPath = @"/usr/local/gnat/bin/gnatmake";
    // NSArray *args = [NSArray arrayWithObjects:@"/Users/user/alex/a.adb", nil];
     NSArray *args = [NSArray arrayWithObjects:@"--help", nil];
   // NSArray *args = [NSArray arrayWithObjects:doc.path, nil];
    
    if([[NSFileManager defaultManager] isExecutableFileAtPath:processPath]){
        NSTask *task = [[NSTask alloc] init];
        [task setLaunchPath: processPath];
        [task setArguments:args];
        
        NSPipe *pipe = [[NSPipe alloc] init];
        [task setStandardError:pipe];
        [task setStandardOutput:pipe];
        
        [task launch];
        
        NSData *data = [[[task standardOutput] fileHandleForReading] readDataToEndOfFile];
        NSString *output = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        [self console:output];
        
    }
    else{
        [self console:[NSString stringWithFormat:@"Path does Not Exist: %@", processPath]];
    }
}


-(void)console:(NSString *)text{
    NSLog(@"%@",text);
    
    //Get the current time
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //Print to the ConsoleView
    consoleView.string = [NSString stringWithFormat:@"%@\n[%@] %@",
                          consoleView.string,
                          [formatter stringFromDate:[NSDate date]],
                          text
                          ];
}

-(void)clearConsole{
    consoleView.string = @"";
}

-(void)updateGUI{
    [consoleView setEditable:NO];
    [consoleView setBackgroundColor:[NSColor blackColor]];
    [consoleView setTextColor:[NSColor whiteColor]];
    [consoleView setFont:[NSFont fontWithName:@"Menlo Bold" size:11]];
    [codeEditor setFont:[NSFont fontWithName:@"Menlo Regular" size:11]];
}





@end
