package auth

type fmSignIn struct {
	Email    string `form:"email" valid:"Email;Required"`
	Password string `form:"password" valid:"Required"`
}
