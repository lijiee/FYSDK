//
//  FYBadge_ENUM.h
//  FYSDK
//
//  Created by WorkHarder on 12/3/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#ifndef FYBadge_ENUM_h
#define FYBadge_ENUM_h

typedef NS_ENUM(NSUInteger, FYBadgeStyle)
{
    FYBadgeStyleRedDot = 0,          /* red dot style */
    FYBadgeStyleNumber,              /* badge with number */
    FYBadgeStyleNew                  /* badge with a fixed text "new" */
};

typedef NS_ENUM(NSUInteger, FYBadgeAnimType)
{
    FYBadgeAnimTypeNone = 0,         /* without animation, badge stays still */
    FYBadgeAnimTypeScale,            /* scale effect */
    FYBadgeAnimTypeShake,            /* shaking effect */
    FYBadgeAnimTypeBounce,           /* bouncing effect */
    FYBadgeAnimTypeBreathe           /* breathing light effect, which makes badge more attractive */
};

#endif /* FYBadge_ENUM_h */
