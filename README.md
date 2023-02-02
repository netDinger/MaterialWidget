# MaterialWidget

Simple Material Theme Widgets for SwiftUI.

See <https://m3.material.io/components/text-fields/overview>

##Usages:

For MaterialTextField,

```swift
MaterialTextField(self.$email, hint: "Email", width: 320, height: 53,showWarning: true,warningInfo: self.$info,valid: self.$valid, showLeadingIcon: true,leadingIconName: "account.circle.fill",showTailingIcon: true,tailingIconName: "account.circle.fill")
```


For MaterialPasswordField,


```swift
MaterialPasswordField(self.$password,
                hint: "Password",
                width: 320,
                height: 53,
                showWarning: true,
                warningInfo: self.$warningInfo,
                warningColor: self.$warningColor, 
                valid: self.$valid,
                showLeadingIcon: true,
                leadingIconName: "lock.circle.fill")
```

** If you don't want dynamic features, replace all ```self.$``` Binding value with ```.constant()``` value.**

You can also remove some unwanted paramaters too.

AddIt! UseIt! Easy and Simple but ATTRACTIVE!




 


