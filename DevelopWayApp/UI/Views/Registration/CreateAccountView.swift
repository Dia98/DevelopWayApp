//
//  CreateAccountView.swift
//  DevelopWayApp
//
//  Created by Diana Sargsyan on 18.10.21.
//

import SwiftUI

struct CreateAccountView: View {
    @ObservedObject private var model: CreateAccountModel = CreateAccountModel()
    
    @State private var password: String = ""
    @State private var rePassword: String = ""
    
    @State private var isShowPhotoLibrary_ = false
    @State private var isShowPhotoLibrary = false
    
    @State private var goNext: Bool = false
    
    @State var alert: AlertItem?
    
    static var uniqueKey: String {
        UUID().uuidString
    }
    
    private let options: [DropdownOption] = [
        DropdownOption(key: uniqueKey, value: "Male"),
        DropdownOption(key: uniqueKey, value: "Female"),
        DropdownOption(key: uniqueKey, value: "Other")
    ]
    
    var body: some View {
        ZStack {
            Color.darkBlue
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                imagePicker
                
                fieldsView
                    .zIndex(17)
                
                Spacer()
                
                createButton
                    .zIndex(7)
            }
            .padding(.horizontal)
        }
        .onAppear {
            configurationUI()
        }
        .setupAlert($alert)
    }
    
    private var createButton: some View {
        NavigationLink(
            destination: ProfileView(),
            isActive: $goNext,
            label: {
                HStack {
                    Spacer()
                    
                    Text("CREATE ACCOUNT")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .modifier(RoundedFillModifier())
                        .onTapGesture {
                            checkForCreateUser()
                        }
                    
                    Spacer()
                }
            })
            .padding(.vertical)
            .zIndex(1)
    }
    
    private func checkForCreateUser() {
        model.validate { errortext in
            alert = AlertItem(message: errortext)
        } success: {
            goNext.toggle()
        }
    }
    
    private func configurationUI() {
        UIDatePicker.appearance().backgroundColor = UIColor.inertBlue // changes bg color
        UIDatePicker.appearance().tintColor = UIColor.darkBlue
    }
    
    private var fieldsView: some View {
        VStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 15) {
                emailField
                
                nameSurnameFields
                
                passwordfieldsView
                
                birthdayPicker
            }
            genderSelector
                .padding(.bottom)
        }
    }
    
    private var passwordfieldsView: some View {
        Group {
            TextField("", text: $model.user.password)
                .placeholder(when: model.user.password.isEmpty) {
                    Text("Password").foregroundColor(.inertBlue)
                }
                .modifier(TextFieldWithIcon(imageName: "key", trailingPadding: 5))
            
            TextField("", text: $model.user.repassword)
                .placeholder(when: model.user.repassword.isEmpty) {
                    Text("Re-Password").foregroundColor(.inertBlue)
                }
                .modifier(TextFieldWithIcon(imageName: "key", trailingPadding: 5))
        }
    }
    
    private var imagePicker: some View {
        Group {
            if let image = model.selectedProfileImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                    .cornerRadius(40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.neoCyan, lineWidth: 2))
            } else {
                Image(systemName: "person.circle")
                    .font(.system(size: 75, weight: .thin))
            }
        }
        .foregroundColor(.inertBlue)
        .padding(.bottom, 40)
        .onTapGesture {
            isShowPhotoLibrary.toggle()
//            model.showImageSheet.toggle()
        }
        .modifier(PhotoPick(showSheet: $isShowPhotoLibrary, pickerShow: $isShowPhotoLibrary_, completionHandler: didSelectImage, preferFrontCam: false))
    }
    
    private func didSelectImage(_ uiimage: UIImage?, _ url: URL?) {
        isShowPhotoLibrary_ = false
        isShowPhotoLibrary = false
        model.didSelectImage(uiimage, url)
    }
    
    private var emailField: some View {
        TextField("", text: $model.user.email)
            .placeholder(when: model.user.email.isEmpty) {
                Text("Email").foregroundColor(.inertBlue)
            }
            .modifier(EmailModifier())
            .modifier(TextFieldWithIcon(imageName: "envelope"))
    }
    
    private var nameSurnameFields: some View {
        HStack {
            TextField("", text: $model.user.name)
                .placeholder(when: model.user.name.isEmpty) {
                    Text("Name").foregroundColor(.inertBlue)
                }
                .modifier(TextFieldWithIcon(imageName: "person"))
            
            TextField("", text: $model.user.surname)
                .placeholder(when: model.user.surname.isEmpty) {
                    Text("Surname").foregroundColor(.inertBlue)
                }
                .modifier(RoundedModifier())
                .foregroundColor(.neoCyan)
        }
    }
    
    private var birthdayPicker: some View {
        HStack {
            Image(systemName: "calendar")
                .font(.system(size: 20))
                .padding(.trailing, 3)
            
            HStack {
                Text("Birthday")
                Spacer()
                DatePicker(selection: $model.user.birthday, in: ...Date(), displayedComponents: .date) {}
                    
                    .padding(.vertical, 6)
                    .labelsHidden()
            }
            .padding(.horizontal)
            .padding(.vertical, 3)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.inertBlue, lineWidth: 2)
            )
        }
        .foregroundColor(.inertBlue)
        .accentColor(.inertBlue)
    }
    
    private var genderSelector: some View {
        DropdownSelector(
            placeholder: "Gender",
            options: options,
            onOptionSelected: { option in
                model.user.gender = Gender(rawValue: option.value)
            })
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
