//
//  FYViewControllerTemplate.m
//  FYSDK
//
//  Created by WorkHarder on 12/1/16.
//  Copyright © 2016 Sven. All rights reserved.
//

#import "FYViewControllerTemplate.h"

@interface FYViewControllerTemplate ()

@end

@implementation FYViewControllerTemplate


#pragma mark -

- (void)fy_setupPageData {
    
}

/**
 *  职责：生成view、基础设置、布局
 *  注意：这里的样式是页面整个生命周期里都不会变化的固定样式(按钮的多种state也在此方法中设置)，对应于React Native里的props
 */
- (void)fy_setupUIAndLayout {
    //TODO: 根据UIComponent的复杂度可以划分更细粒度的方法，在内部按序调用
    
}

/**
 *  设置样式
 *  比如颜色、边框等；
 *
 *  注意：这里的样式是需要被控制的样式，也就是说在交互(Interaction)过程中可能被重新设置的样式；对应于React Native里的state
 */
- (void)fy_setupUIStyles {
    //TODO: 在MVVM中，这里用来绑定属性展示
    
}


/**
 *  配置交互
 */
- (void)fy_setupInteractions {
    //TODO: 在MVVM中，这里用来绑定属性动作
}



@end
