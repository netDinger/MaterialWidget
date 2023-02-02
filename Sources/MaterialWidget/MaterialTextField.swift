//
//  MaterialTextField.swift
//
//
//  Created by Pyae Phyo Kyaw on 12/27/22.
//

import SwiftUI


@available(iOS 15.0, *)
public struct MaterialTextField: View {
    
    // MARK: - Properties
    
    // MARK: View protocol properties
    
    
    public var body: some View {
     
        ZStack {
            HStack (spacing: 0){
                if showLeadingIcon {
                    Image(systemName: self.leadingIconName)
                    .foregroundColor(self.borderColor)
                    .padding([.leading],8.0)
                    .imageScale(.large)
                }
            ZStack{
            TextField("", text: $text,onEditingChanged: {state in
                               
                                isFocused = state
                                withAnimation(.easeOut(duration: 0.1)) {
                                    updateBorder()
                                    updatePlaceholder(focused: state)
                                }
                                if state{
                                    focusField = .textField
                                }
                                else {
                                }
                            })
                    .onTapGesture {
                        isFocused = true
                    }
                    .padding()
                
                .focused($focusField, equals: .textField)
        
            HStack {
                ZStack {
                    Color(.white)
                        .cornerRadius(4.0)
                        .opacity(hintBackgroundOpacity)
                    Text(hint)
                        .foregroundColor(.white)
                        .colorMultiply(hintColor)
                        .animatableFont(size: hintFontSize)
                        .padding(2.0)
                        .layoutPriority(1)
                        .onTapGesture(perform:{isFocused = true})
                }
                    .padding([.leading], hintLeadingPadding)
                    .padding([.bottom], hintBottomPadding)
                Spacer()
            }
            
            }
                if showTailingIcon {
                    Image(systemName: self.tailingIconName)
                    .foregroundColor(self.borderColor)
                    .padding([.leading],8.0)
                }
            }.frame(minWidth: width, idealWidth: width, maxWidth: width,minHeight: height,idealHeight: height,maxHeight: height)
                .background(RoundedRectangle(cornerRadius: 4.0, style: .continuous)
                            .stroke(borderColor, lineWidth: borderWidth))
            
            if showWarning{
            HStack {
                VStack {
                    Spacer()
                    Text(warningInfo)
                        .font(.system(size: 10.0))
                        .foregroundColor(.gray)
                        .padding([.leading], 10.0)
                }
                Spacer()
            }
                
            }
        }
            
        
            .onChange(of: isFocused) { newV in
                if newV {
                    focusField = .textField
                }
                
//                withAnimation(.easeOut(duration: 0.1)) {
//                    updateBorder()
//                    updatePlaceholder(focused: editing)
//                }
            }
            
            .frame(minWidth: width, idealWidth: width, maxWidth: width,minHeight: totalHeight,idealHeight: totalHeight,maxHeight: totalHeight)
    }
    
    // MARK: Private properties
    
    
    
    @Binding private var text: String
    private let hint: String
    private var width: CGFloat = 300
    private var height: CGFloat = 53
    private var totalHeight: CGFloat = 0
    
    @State private var borderColor = Color.black.opacity(0.5)
    @State private var borderWidth = 1.0
    //@Binding
    @State
    private var isFocused: Bool = false
    

    @FocusState
    private var focusField: Field?
   
    @State private var hintBackgroundOpacity = 0.0
    @State private var hintBottomPadding = 0.0
    @State private var hintColor = Color.gray
    @State private var hintFontSize = 16.0
    @State private var hintLeadingPadding = 4.0
    
    @Binding private var valid: Bool
    
    private var showWarning = false
    @Binding private var warningInfo: String
    
    private var showLeadingIcon = false
    private var showTailingIcon = false
    
    private var leadingIconName = ""
    private var tailingIconName = ""
    
    
    // MARK: - Initialization
    
    /// Creates a Material Design inspired text field with an animated border and placeholder.
    /// - Parameters:
    ///   - text: The text field contents.
    ///   - hint: The field hint string.
    ///   - editing: Whether the field is in the editing state.
    ///   - valid: Whether the field is in the valid state.
    ///   - showLeadingIcon: Show leading icon or not.
    ///   - showTailingIcon: Show tailing icon or not.
    ///   - iconName: System icon name
    ///   - color: Color when focus
    ///   - height: Height
    ///   - width: Width
    ///
    
    public init(_ text: Binding<String>,
                hint: String,
                width: CGFloat,
                height: CGFloat,
                showWarning: Bool = false,
                warningInfo: Binding<String> = .constant(""),
                valid: Binding<Bool> = .constant(true),
showLeadingIcon: Bool = false,leadingIconName: String = "",
                showTailingIcon: Bool = false, tailingIconName: String = ""){
        self._text = text
        self.hint = hint
       
        self._valid = valid
        self.width = width
        self.height = height
        self.totalHeight = showWarning ? height + 27 : height
        
        self.showWarning = showWarning
        self._warningInfo = warningInfo
        self.showLeadingIcon = showLeadingIcon
        self.showTailingIcon = showTailingIcon
        self.leadingIconName = leadingIconName
        self.tailingIconName = tailingIconName
        
    }
    

    // MARK: - Methods
    
    // MARK: Private methods
    
    private func updateBorder() {
        updateBorderColor()
        updateBorderWidth()
    }
    
    private func updateBorderColor() {
        if !valid {
            borderColor = .red
        } else if isFocused {
            borderColor = Color("Color")
        } else {
            borderColor = .gray
        }
    }
    
    private func updateBorderWidth() {
        borderWidth = isFocused
            ? 2.0
            : 1.0
    }
    
    private func updatePlaceholder(focused: Bool) {
           if(focused || !text.isEmpty){
               hintBackgroundOpacity = 1.0
               hintFontSize = 11.0
               hintBottomPadding = 53.0
               hintLeadingPadding = 4.0
           }
           else {
               hintBackgroundOpacity = 0.0
               hintFontSize = 16.0
               hintBottomPadding = 0.0
               hintLeadingPadding = 8.0
           }
   
           if valid {
               hintColor = focused
                   ? Color("Color")
                   : .gray
           } else if text.isEmpty {
               hintColor = focused
                   ? .red
                   : .gray
           } else {
               hintColor = .red
           }
   
   //        updatePlaceholderBackground()
   //        updatePlaceholderColor()
   //        updatePlaceholderFontSize(focused: focused)
   //        updatePlaceholderPosition(focused: focused)
       }
    
    private func updatePlaceholderBackground() {
        if isFocused
            || !text.isEmpty {
            hintBackgroundOpacity = 1.0
        } else {
            hintBackgroundOpacity = 0.0
        }
    }
    
    private func updatePlaceholderColor() {
        if valid {
            hintColor = isFocused
            ? Color("Color")
                : .gray
        } else if text.isEmpty {
            hintColor = isFocused
                ? .red
                : .gray
        } else {
            hintColor = .red
        }
        
    }
    
    private func updatePlaceholderFontSize() {
        if isFocused
            || !text.isEmpty {
            hintFontSize = 10.0
        } else {
            hintFontSize = 16.0
        }
    }
    
    private func updatePlaceholderPosition() {
        if isFocused
            || !text.isEmpty {
            hintBottomPadding = 34.0
            hintLeadingPadding = 8.0
        } else {
            hintBottomPadding = 0.0
            hintLeadingPadding = 4.0
        }
    }
    
    // MARK: -
    
    private enum Field {
        
        case textField
        
    }
    
}


/// A view modifier that makes the view's font size animatable.
///
/// Inspired by Paul Hudson's <https://www.hackingwithswift.com/quick-start/swiftui/how-to-animate-the-size-of-text>
@available(iOS 15.0, *)
struct AnimatableCustomFontModifier: AnimatableModifier {
    
    // MARK: - Properties
    
    /// The font size.
    var size: CGFloat
    
    // MARK: AnimatableModifier protocol properties
    
    var animatableData: CGFloat {
        get { size }
        set { size = newValue }
    }
    
    // MARK: - Methods
    
    // MARK: AnimatableModifier protocol methods
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size))
    }
    
}


@available(iOS 15.0, *)
extension View {
    
    // MARK: - Methods
    
    /// Sets the default font for text in the view and makes its change animatable.
    /// - Parameter size: The size of the font.
    /// - Returns: The view with this modification applied.
    func animatableFont(size: CGFloat) -> some View {
        modifier(AnimatableCustomFontModifier(size: size))
    }
    
}


