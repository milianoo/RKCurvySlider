//
//  RKCurvySlider.h
//  RKCurvySlider
//
//  Created by Milad Rezazadeh on 5/26/13.
//  Copyright (c) 2013 Milad Rezazadeh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface RKCurvySlider : UIControl
{
    NSMutableDictionary* curvePoints;
    bool isShapeSelected;
    
    IBOutlet UIImageView* btn_slider;
}

@end
