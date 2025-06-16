-keep class **.zego.**  { *; }
-keep class **.**.zego_zpns.** { *; }
# تجاهل التحذيرات الخاصة بالكلاسات الغير موجودة في Android
-dontwarn java.beans.**
-dontwarn org.w3c.dom.bootstrap.**

# السماح بالاحتفاظ بكود مكتبة jackson
-keep class com.fasterxml.jackson.** { *; }

# مهم للحفاظ على خصائص Jackson المرتبطة بالـ JSON
-keepattributes *Annotation*

-keepnames class * {
    @com.fasterxml.jackson.annotation.JsonCreator <init>(...);
}

-keepclassmembers class * {
    @com.fasterxml.jackson.annotation.JsonProperty <fields>;
}
