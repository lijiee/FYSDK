//
//  OSMessage+DictionarySupport.h
//  FYSDK
//
//  Created by WorkHarder on 11/17/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import <OpenShare/OpenShare.h>
#import "FYTPAConstants.h"

@interface OSMessage (DictionarySupport)

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary;

@end
