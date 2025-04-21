# Keep all Facebook Ads SDK classes
-keep class com.facebook.** { *; }
-keep class com.facebook.ads.** { *; }
-keep class com.facebook.ads.internal.** { *; }
-dontwarn com.facebook.**
-dontwarn com.facebook.ads.**
-dontwarn com.facebook.ads.internal.**

# Keep AndroidX and Google libraries
-keep class androidx.** { *; }
-keep class com.google.** { *; }
-keep class kotlin.** { *; }
-dontwarn com.google.**
# Keep annotations for ProGuard/R8
-keepattributes *Annotation*

# Keep the proguard.annotation.Keep class
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }
-keep @proguard.annotation.Keep class * { *; }
-keep @proguard.annotation.KeepClassMembers class * { *; }

# Keep Razorpay SDK classes (if you're using Razorpay)
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**


# Stripe SDK-related rules (if used)
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivity$g
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Args
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Error
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider

# Keep ExoPlayer-related classes
-keep class com.google.android.exoplayer2.** { *; }
-keep class com.google.android.exoplayer2.ext.** { *; }
-keep class com.google.android.exoplayer2.util.** { *; }
-keep class com.google.android.exoplayer2.source.** { *; }
-keep class com.google.android.exoplayer2.trackselection.** { *; }
-keep class com.google.android.exoplayer2.ui.** { *; }
-keep class com.google.android.exoplayer2.upstream.** { *; }
-keep class com.google.android.exoplayer2.decoder.** { *; }
-keep class com.google.android.exoplayer2.audio.** { *; }
-keep class com.google.android.exoplayer2.video.** { *; }
-keep class com.google.android.exoplayer2.mediacodec.** { *; }

# Prevent ExoPlayer dependencies from being removed
-dontwarn com.google.android.exoplayer2.**
-dontwarn com.google.android.exoplayer2.ui.**
-dontwarn com.google.android.exoplayer2.source.**
-dontwarn com.google.android.exoplayer2.trackselection.**
-dontwarn com.google.android.exoplayer2.upstream.**
-dontwarn com.google.android.exoplayer2.decoder.**

# Keep MediaCodec and media-related classes
-keep class android.media.MediaCodec { *; }
-keep class android.media.MediaExtractor { *; }
-keep class android.media.MediaFormat { *; }
-keep class android.media.MediaPlayer { *; }

# Keep Flutter plugin classes
-keep class io.flutter.plugins.** { *; }

# Keep WebView and video playback components
-keep class android.webkit.** { *; }
-dontwarn android.webkit.**

# Keep VideoView and TextureView
-keep class * extends android.media.MediaPlayer { *; }
-keep class * extends android.view.TextureView { *; }
-keep class * extends android.widget.VideoView { *; }
-keep class * implements android.view.SurfaceHolder$Callback { *; }
-dontwarn proguard.annotation.Keep
-dontwarn proguard.annotation.KeepClassMembers

# Keep all annotation attributes
-keepattributes *Annotation*
