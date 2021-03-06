/***
 * Excerpted from "iOS Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/cdirec for more book information.
 ***/
//
//  PRPDebug.m
//
//  Created by Matt Drance on 8/28/09.
//  Copyright 2009 Bookhouse. All rights reserved.
//

#import "PRPDebug.h"
#import <objc/runtime.h>
#import "BaseModel.h"

NSString *descriptionForDebug(id object) {
  unsigned int outCount = 0;
  int i = 0;
  
  NSMutableArray *mutableParameterComponents = [NSMutableArray arrayWithObject:@"\r\r\r"];
  
  /***********************               当前类                 ******************************/
  Class currentClass = [object class];
  objc_property_t *properties = class_copyPropertyList(currentClass, &outCount);
  // 类名
  [mutableParameterComponents addObject:[NSString stringWithFormat:@"----------------------  %@ ----------------------\r", NSStringFromClass(currentClass)]];
  // 类属性
  for(i=0; i<outCount; i++) {
    objc_property_t property = properties[i];
    NSString *key = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
    if ([@"description" isEqualToString:key]
        || [@"debugDescription" isEqualToString:key]
        || [@"hash" isEqualToString:key]
        || [@"superclass" isEqualToString:key]) {
      continue;
    }
    id value = [object valueForKey:key];
    
    NSString *component = [NSString stringWithFormat:@"\r[%@  =  %@]", [key description], [value description]];
    
    [mutableParameterComponents addObject:component];
  }
  
  free(properties);
  [mutableParameterComponents addObject:[NSString stringWithFormat:@"\r\r ----------------------  %@ ----------------------\r\r", NSStringFromClass(currentClass)]];
  /******************************************************************************************/
  
  
  /***********************                父类                 ******************************/
  currentClass = [object superclass];
  
  if (currentClass != [NSObject class] && currentClass != [BaseModel class]) {
    //
    properties = class_copyPropertyList(currentClass, &outCount);
    // 类名
    [mutableParameterComponents addObject:[NSString stringWithFormat:@"----------------------  %@ ----------------------\r", NSStringFromClass(currentClass)]];
    // 类属性
    for(i=0; i<outCount; i++) {
      objc_property_t property = properties[i];
      NSString *key = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
      if ([@"description" isEqualToString:key]
          || [@"debugDescription" isEqualToString:key]
          || [@"hash" isEqualToString:key]
          || [@"superclass" isEqualToString:key]) {
        continue;
      }
      id value = [object valueForKey:key];
      
      NSString *component = [NSString stringWithFormat:@"\r[%@  =  %@]", [key description], [value description]];
      
      [mutableParameterComponents addObject:component];
    }
    
    free(properties);
    [mutableParameterComponents addObject:[NSString stringWithFormat:@"\r\r ----------------------  %@ ----------------------\r", NSStringFromClass(currentClass)]];
  }
  /******************************************************************************************/
  
  
  
  
  [mutableParameterComponents addObject:@"\r\r\r"];
  return [mutableParameterComponents componentsJoinedByString:@" "];
}

void PRPDebug(const char *fileName, int lineNumber, NSString *fmt, ...) {

  va_list args;
  va_start(args, fmt);
  
  static NSDateFormatter *debugFormatter = nil;
  if (debugFormatter == nil) {
    debugFormatter = [[NSDateFormatter alloc] init];
    [debugFormatter setDateFormat:@"yyyyMMdd.HH:mm:ss"];
  }
  
  NSString *msg = [[NSString alloc] initWithFormat:fmt arguments:args];
  NSString *filePath = [[NSString alloc] initWithUTF8String:fileName];
  NSString *timestamp = [debugFormatter stringFromDate:[NSDate date]];
  
  NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
  NSString *appName = [info objectForKey:(NSString *)kCFBundleNameKey];
  fprintf(stdout, "%s %s[%s:%d] %s\n",
          [timestamp UTF8String],
          [appName UTF8String],
          [[filePath lastPathComponent] UTF8String],
          lineNumber,
          [msg UTF8String]);
  
  va_end(args);
  
}
