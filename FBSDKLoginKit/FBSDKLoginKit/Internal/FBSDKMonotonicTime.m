// Copyright (c) 2014-present, Facebook, Inc. All rights reserved.
//
// You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
// copy, modify, and distribute this software in source code or binary form for use
// in connection with the web services and APIs provided by Facebook.
//
// As with any software that integrates with the Facebook platform, your use of
// this software is subject to the Facebook Developer Principles and Policies
// [http://developers.facebook.com/policy/]. This copyright notice shall be
// included in all copies or substantial portions of the software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#if !TARGET_OS_TV

#import "FBSDKMonotonicTime.h"

#include <assert.h>
#include <dispatch/dispatch.h>
#include <mach/mach.h>
#include <mach/mach_time.h>

static uint64_t _get_time_nanoseconds(void)
{
  static struct mach_timebase_info tb_info = {0};
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    int ret = mach_timebase_info(&tb_info);
    assert(0 == ret);
  });

  return (mach_absolute_time() * tb_info.numer) / tb_info.denom;
}

FBSDKMonotonicTimeSeconds FBSDKMonotonicTimeGetCurrentSeconds(void)
{
  const uint64_t nowNanoSeconds = _get_time_nanoseconds();
  return (FBSDKMonotonicTimeSeconds)nowNanoSeconds / (FBSDKMonotonicTimeSeconds)1000000000.0;
}

#endif
