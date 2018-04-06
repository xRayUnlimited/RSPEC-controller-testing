module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = User.create(
        email: 'test@test.com',
        password: 'password',
        first_name: 'Testy',
        last_name: 'Testerson',
        age: 27,
        gender: 'Female'
      )
      sign_in @user
    end
  end
end
