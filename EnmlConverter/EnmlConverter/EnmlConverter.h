//
//  EnmlConverter.h
//  EnmlConverter
//
//  Created by Jiang Chuncheng on 3/12/15.
//  Copyright (c) 2015 SenseForce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnmlConverter : NSObject

+ (instancetype)sharedInstance;

- (NSString *)convertToENML:(NSString *)html;

@end
