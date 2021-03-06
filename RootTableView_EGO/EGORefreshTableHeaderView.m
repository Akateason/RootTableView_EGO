//
//  EGORefreshTableHeaderView.m
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "EGORefreshTableHeaderView.h"

//#import <AKATeasonFramework/AKATeasonFramework.h>
#import "XTAnimation.h"

#define APPFRAME                        [UIScreen mainScreen].bounds
#define TEXT_COLOR	 [UIColor colorWithRed:163.0/255.0 green:163.0/255.0 blue:163.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f


@interface EGORefreshTableHeaderView (Private)
- (void)setState:(EGOPullRefreshState)aState;
@end

@implementation EGORefreshTableHeaderView

@synthesize delegate=_delegate;



- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
		
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = nil ; //[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0] ;

//		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 30.0f, self.frame.size.width, 20.0f)];
//		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//		label.font = [UIFont systemFontOfSize:12.0f];
//		label.textColor = TEXT_COLOR;
//		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
//		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
//		label.backgroundColor = [UIColor clearColor];
//		label.textAlignment = UITextAlignmentCenter;
//		[self addSubview:label];
//		_lastUpdatedLabel=label;
//		[label release];
		
/*
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont boldSystemFontOfSize:13.0f];
		label.textColor = TEXT_COLOR;
		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		[self addSubview:label];
		_statusLabel=label;
		[label release];
*/
        
		CALayer *layer = [CALayer layer];
        float width = 40.0f ;
		layer.frame = CGRectMake( (APPFRAME.size.width - width) / 2, frame.size.height - 55.0f, width, width);
		layer.contentsGravity = kCAGravityResizeAspect;
		layer.contents = (id)[UIImage imageNamed:@"5"].CGImage;

        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
        
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        {
			layer.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		
		[[self layer] addSublayer:layer];
		_arrowImage = layer;
		
//		UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//		view.frame = CGRectMake(25.0f, frame.size.height - 18.0f, 20.0f, 20.0f);
//		[self addSubview:view];
//		_activityView = view;
//		[view release];
		
		
		[self setState:EGOOPullRefreshNormal];
		
    }
	
    return self;
	
}


#pragma mark -
#pragma mark Setters

- (void)refreshLastUpdatedDate {
	
//	if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceLastUpdated:)]) {
//		
////		NSDate *date = [_delegate egoRefreshTableHeaderDataSourceLastUpdated:self];
////		
////		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
////		[formatter setAMSymbol:@"AM"];
////		[formatter setPMSymbol:@"PM"];
////		[formatter setDateFormat:@"MM/dd/yyyy hh:mm:a"];
//////		_lastUpdatedLabel.text = [NSString stringWithFormat:@"上次刷新: %@", [formatter stringFromDate:date]];
//////		[[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"EGORefreshTableView_LastRefresh"];
////		[[NSUserDefaults standardUserDefaults] synchronize];
////		[formatter release];
//		
//	} else {
//		
////		_lastUpdatedLabel.text = nil;
//		
//	}

}

- (void)setState:(EGOPullRefreshState)aState{
    
	switch (aState)
    {
		case EGOOPullRefreshPulling:
        {
//			_statusLabel.text = NSLocalizedString(@"请释放我吧...", @"Release to refresh status");
            CATransform3D rotationTransform  = CATransform3DMakeRotation( (M_PI / 180.0) * 180.0, 0, 0, 0.5);
            CABasicAnimation* animation ;
            animation                     = [CABasicAnimation animationWithKeyPath:@"transform"];
            animation.toValue             = [NSValue valueWithCATransform3D:rotationTransform];
            animation.duration            = FLIP_ANIMATION_DURATION;
            animation.autoreverses        = NO;
            animation.cumulative          = YES;
            animation.removedOnCompletion = YES;
            animation.fillMode            = kCAFillModeForwards;
            animation.repeatCount         = 2;
            
            [_arrowImage addAnimation:animation forKey:nil];
            
            [XTAnimation animationTransformWithLayer:_arrowImage] ;

        }
			break;
        case EGOOPullRefreshNormal:
        {
			
			if (_state == EGOOPullRefreshPulling) {
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
				_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
			}
			
//			_statusLabel.text = NSLocalizedString(@"下拉刷新...", @"Pull down to refresh status");
            [CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            _arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
			
			[self refreshLastUpdatedDate] ;

        }
			break;
		case EGOOPullRefreshLoading:
        {
//			_statusLabel.text = NSLocalizedString(@"加载中...", @"Loading Status");
            
            [CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			[CATransaction commit];
            
        }
			break;
		default:
			break;
	}
	
	_state = aState;
}


#pragma mark -
#pragma mark ScrollView Methods

- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {	
	
	if (_state == EGOOPullRefreshLoading) {
		
		CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
		offset = MIN(offset, 60);
		scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
		
	} else if (scrollView.isDragging) {
		
		BOOL _loading = NO;
		if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
			_loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
		}
		
		if (_state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !_loading) {
			[self setState:EGOOPullRefreshNormal];
		} else if (_state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !_loading) {
			[self setState:EGOOPullRefreshPulling];
		}
		
		if (scrollView.contentInset.top != 0) {
			scrollView.contentInset = UIEdgeInsetsZero;
		}
		
	}
	
}

- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView
{
    
	BOOL _loading = NO;
	if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
		_loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
	}
	
	if (scrollView.contentOffset.y <= - 65.0f && !_loading) {
		
		if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDidTriggerRefresh:)]) {
			[_delegate egoRefreshTableHeaderDidTriggerRefresh:self];
		}
		
		[self setState:EGOOPullRefreshLoading];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[UIView commitAnimations];
		
	}
	
}

- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView
{
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
	[self setState:EGOOPullRefreshNormal];
    
}


#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
	
	_delegate=nil;
//	_activityView = nil;
//	_statusLabel = nil;
	_arrowImage = nil;
//	_lastUpdatedLabel = nil;
    [super dealloc];
}


@end
