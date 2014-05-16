filed as rdar://16940667

Summary
====

In an app where UIApplication.idleTimerDisabled was set to YES, after the UIImagePickerController is presented and dismissed, the app no longer stays awake.

Steps to Reproduce:
====
I have attached a simplified Xcode project to demonstrate the bug.

1. Run UIImagePickerControllerBug on a device not connected to Xcode (because Xcode always keeps the device from sleeping).  
2. Observe that the app does not fall asleep.
3. Press the Show ImagePicker Button.
4. Take a photo or just press cancel
5. Observe that the app will now fall asleep.

Expected Results:
====
UIImagePickerController should inspect the UIApplication.idleTimerDisabled and not set it to NO if it was previously set to YES.


Notes:
====
This bug and my workaround are discussed at
http://stackoverflow.com/questions/23391564/ios-idletimerdisabled-yes-works-only-until-imagepicker-was-used

