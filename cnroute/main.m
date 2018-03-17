//
//  main.m
//  cnroute
//
//  Created by Zeo on 17/03/2018.
//  Copyright © 2018 Zeo. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSError *error;
        NSString *path = @"这里输入原始路由表文件";//举个栗子:类似这样https://raw.githubusercontent.com/CNMan/ocserv-cn-no-route/master/tmp/chnroute_merged.txt
        NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        NSArray *array = [str componentsSeparatedByString:@"\n"];
        NSString *outPath = @"这里输入生成的路由表文件路径,文件需要提前创建";
        
        for (int i = 0; i < array.count; i++) {
            NSLog(@"%@",[array[i] description]);
            NSString *tmp = [NSString stringWithFormat:@"\n        <dict>\n            <key>class</key>\n            <string>Route</string>\n            <key>mode</key>\n            <integer>2</integer>\n            <key>networkAddress</key>\n            <string>%@</string>\n        </dict>",[array[i] description]];
            NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:outPath];
            [fileHandle seekToEndOfFile];
            NSData *data = [tmp dataUsingEncoding:NSUTF8StringEncoding];
            [fileHandle writeData:data];
            [fileHandle closeFile];
        }
    }
    return 0;
}
