<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome Complaint
        Management System .</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT"
            crossorigin="anonymous"
    />
    <style>
        .signup-container {
            max-width: 500px;
            margin: 2rem auto;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        .form-control:focus {
            border-color: #86b7fe;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
        .btn-action {
            min-width: 120px;
        }
        .password-toggle {
            cursor: pointer;
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
        }
        .form-text{
            display: none;
        }
        .
    </style>
</head>
<body class="bg-light">
<div class="container">
    <div class="signup-container bg-white">
        <h1 class="text-center mb-4">Create an Account</h1>
        <form id="signupForm" method="POST" action="<%=request.getContextPath()%>/signup">
            <div class="mb-3">
                <label for="email" class="form-label">Email address</label>
                <input
                        type="email"
                        class="form-control"
                        id="email"
                        name="email"
                        placeholder="name@example.com"
                        required
                />
                <div class="form-text" id="emailError">
                    Please provide a valid email address.
                </div>
            </div>

            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input
                        type="text"
                        class="form-control"
                        id="username"
                        name="username"
                        placeholder="Jiribiris"
                        required
                />
                <div class="form-text" id="usernameError">
                    Please choose a username.
                </div>
            </div>

            <div class="mb-3 position-relative">
                <label for="password" class="form-label">Password</label>
                <input
                        type="password"
                        class="form-control"
                        id="password"
                        name="password"
                        placeholder="**********"
                        required
                />
                <div class="form-text" id="passError" >
                    Password must be at least 8 characters.
                </div>
                <div >Use 8 or more characters with a mix of letters, numbers & symbols</div>
            </div>

            <div class="d-flex justify-content-between mt-4">
                <a href="/MunicipalITDivision_war_exploded/signin.jsp" class="btn btn-outline-secondary btn-action">
                    Sign In
                </a>
                <button type="submit" id="signup_btn" class="btn btn-primary btn-action">
                    Sign Up
                </button>

            </div>




        </form>
        <%Object obj=request.getAttribute("error");
        if(obj!=null){
        String msg=obj.toString();
        %>

<%--        <div class="alert alert-danger" role="alert">--%>

                <%if (msg.equals("Ealready_taken")){ %>

            <div class="alert alert-danger" role="alert">Email has already taken.</div>

            <%}
                if (msg.equals("UNalready_taken")){%>
            <div class="alert alert-danger" role="alert">User has already taken.</div>

            <%}%>

<%--        </div>--%>
        <%}%>
    </div>
</div>

<!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO"
        crossorigin="anonymous"
></script>
<script
        src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
        crossorigin="anonymous"
></script>
<script>
    $(document).ready(function () {
        const emailRegex = /^[\w.-]+@[\w.-]+\.[a-z]{2,6}$/i;

        $('#email').on('input', function() {
            const email = $(this).val().trim();
            const $error = $('#emailError');

            if (!email) {
                $(this).removeClass('is-invalid is-valid');
                $error.hide();
            } else if (emailRegex.test(email)) {
                $(this).removeClass('is-invalid').addClass('is-valid');
                $error.hide();
            } else {
                $(this).removeClass('is-valid').addClass('is-invalid');
                $error.text('Please enter a valid email address').show();
            }
        });

        $('#confirmPassword').on('input', function() {
            const matches = $('#password').val() === $(this).val();
            $(this).toggleClass('is-valid', matches).toggleClass('is-invalid', !matches);
            $('#confirmPasswordError').toggle(!matches);
        });

        $('.submit-btn').click(function (e) {
            let isValid = true;

            if (!emailRegex.test($('#email').val().trim())) {
                $('#email').addClass('is-invalid');
                $('#emailError').text('Please enter a valid email address').show();
                isValid = false;
            }

            if ($('#password').val() !== $('#confirmPassword').val()) {
                $('#password, #confirmPassword').addClass('is-invalid');
                $('#confirmPasswordError').text('Passwords do not match').show();
                isValid = false;
            }

            if (!isValid) {
                e.preventDefault();
                $('.is-invalid').first().focus();
            }
        });
    });

</script>
</body>
</html>