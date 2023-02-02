//
//  MaterialPasswordField.swift
//  
//
//  Created by Pyae Phyo Kyaw on 2/2/23.
//

import SwiftUI
@available(iOS 15.0, *)
public struct MaterialPasswordField: View {
    
    // MARK: - Properties
    
    // MARK: View protocol properties
    
    public var body: some View {
  
            
        ZStack {
            HStack (spacing: 0) {
                if showLeadingIcon {
                    Image(systemName: self.leadingIconName)
                    .foregroundColor(self.borderColor)
                    .padding([.leading],8.0)
                    .imageScale(.large)
                    }
            ZStack{
                
                VStack{
                    
                    if self.passwordVisibility{
                        
                        TextField("", text: self.$password,onEditingChanged: {state in
                            
                            isFocused = state
                            withAnimation(.easeOut(duration: 0.1)) {
                                updateBorder(focused: state)
                                updatePlaceholder(focused: state)
                            }
                            if state{
                                focusField = .textField
                            }
                            else {
                            }
                        })
                            .autocapitalization(.none)
                            .padding()
                            .focused($focusField, equals: .textField)
                    }
                    else{
                        SecureField("", text: self.$password)
                            .autocapitalization(.none)
                            .padding()
                            .focused($isFocused)
                            .focused($focusField, equals: .textField)
                            .simultaneousGesture(TapGesture().onEnded{
                               
                                isFocused = true
                                withAnimation(.easeOut(duration: 0.1)) {
                                    updateBorder(focused: true)
                                    updatePlaceholder(focused: true)
                    
                                }
                            }).onSubmit({
                                
                                withAnimation(.easeOut(duration: 0.1)) {
                                    updateBorder(focused: false)
                                    updatePlaceholder(focused: false)
                                    
                                }
                            })
                            
                    }
                }.focused($focusField, equals: .textField)

            HStack {
                ZStack {
                    Color(.white)
                        .cornerRadius(4.0)
                        .opacity(hintBackgroundOpacity)
                    Text(hint)
                        .foregroundColor(.white)
                        .colorMultiply(hintColor)
                        .animatableFont(size: hintFontSize)
                        .padding(0)
                        
                        .layoutPriority(1)
                        .onTapGesture(perform: {
                          
                            isFocused = true
                            withAnimation(.easeOut(duration: 0.1)) {
                                updateBorder(focused: true)
                                updatePlaceholder(focused: true)
                
                            }
                        })
                }
                    .padding([.leading], hintLeadingPadding)
                    .padding([.bottom], hintBottomPadding)
                Spacer()
            }
            
            }
                Button(action: {
                    
                    self.passwordVisibility.toggle()
                    
                }) {
                    
                    Image(systemName: self.passwordVisibility ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(self.borderColor)
                    
                }.padding([.trailing],8.0)
                
            }.frame(minWidth: width, idealWidth: width, maxWidth: width,minHeight: height,idealHeight: height,maxHeight: height)
                .background(RoundedRectangle(cornerRadius: 4.0, style: .continuous)
                            .stroke(borderColor, lineWidth: borderWidth))
            
            if showWarning {
            HStack {
                VStack {
                    Spacer()
                    Text(warningInfo)
                        .font(.system(size: 11.0))
                        .foregroundColor(warningColor)
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
            
                withAnimation(.easeOut(duration: 0.1)) {
                    updateBorder(focused: isFocused)
                    updatePlaceholder(focused: isFocused)
                }
            }

            
            .frame(minWidth: width, idealWidth: width, maxWidth: width,minHeight: totalHeight,idealHeight: totalHeight,maxHeight: totalHeight)
    }
    
    // MARK: Private properties
    
    
   
    @Binding
    private var password: String
    private let hint: String
    
    private var width: CGFloat = 300
    private var height: CGFloat = 53
    private var totalHeight: CGFloat = 0
    
    private var showWarning = false
    @Binding
    private var warningInfo: String
    @Binding var warningColor: Color
    private var showLeadingIcon: Bool = false
    private var leadingIconName: String = ""
    private var showToggle: Bool = true
    
    @State
    private var borderColor = Color.black.opacity(0.5)
    @State
    private var borderWidth = 1.0
    @FocusState
    private var isFocused: Bool
   
    @FocusState
    private var focusField: Field?
   
    @State private var hintBackgroundOpacity = 0.0
    @State private var hintBottomPadding = 0.0
    @State private var hintColor = Color.gray
    @State private var hintFontSize = 16.0
    @State private var hintLeadingPadding = 4.0
    
    @Binding private var valid: Bool
    @State var passwordVisibility = false
    
    // MARK: - Initialization
    /// Creates a Material Design inspired text field with an animated border and placeholder.
    /// - Parameters:
    ///   - text: The text field contents.
    ///   - placeholder: The placeholder string.
    ///   - hint: The field hint string.
    ///   - editing: Whether the field is in the editing state.
    ///   - valid: Whether the field is in the valid state.

    
    public init(_ password: Binding<String>,
                hint: String,
                width: CGFloat,
                height: CGFloat,
                showWarning: Bool = false,
                warningInfo: Binding<String> = .constant(""),
                warningColor: Binding<Color> = .constant(.black),
                valid: Binding<Bool> = .constant(true),
                showLeadingIcon: Bool = false,
                leadingIconName: String = ""){
        self._password = password
        self.hint = hint
        self.showWarning = showWarning
        self._warningInfo = warningInfo
        self._warningColor = warningColor
    
        self._valid = valid
        self.width = width
        self.height = height
        totalHeight = showWarning ? height+27 : height
        self.showLeadingIcon = showLeadingIcon
        self.leadingIconName = leadingIconName
        
    }

    // MARK: - Methods
    
    // MARK: Private methods
    
    private func updateBorder(focused: Bool) {
        
        if !valid {
            borderColor = .red
        } else if focused {
            borderColor = Color("Color")
        } else {
            borderColor = .gray
        }
        borderWidth = focused
            ? 2.0
            : 1.0
    }
    
    private func updateBorderColor(focused: Bool) {
       
    }
    
  
    
    private func updatePlaceholder(focused: Bool) {
           if(focused || !password.isEmpty){
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
           } else if password.isEmpty {
               hintColor = focused
                   ? .red
                   : .gray
           } else {
               hintColor = .red
           }
   
  
       }
    // MARK: -
    
    private enum Field {
        
        case textField
        
    }
    
}

