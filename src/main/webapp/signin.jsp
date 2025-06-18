<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>JSP - Hello World</title>
  <link
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT"
          crossorigin="anonymous"
  />
  <style>
    .login-container {
      max-width: 500px;
      margin: 3rem auto;
      padding: 2rem;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      background-color: white;
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
    .forgot-password {
      text-align: right;
      margin-top: -0.5rem;
      margin-bottom: 1rem;
    }
    .form-text{
      display: none;
    }
  </style>
</head>
<body class="bg-light">
<div class="container">
  <div class="login-container">
    <h1 class="text-center mb-4">Welcome Back</h1>
    <form id="loginForm" action="<%=request.getContextPath()%>/signin" method="post">
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

      <div class="mb-3 position-relative">
        <label for="password" class="form-label">Password</label>
        <input
                type="password"
                class="form-control"
                id="password"
                name="password"
                placeholder="Enter your password"
                required
        />
        <!-- <i class="bi bi-eye-slash password-toggle" id="togglePassword"></i> -->
        <div class="invalid-feedback">
          Please enter your password.
        </div>
        <!-- <div class="forgot-password">
            <a href="/pages/forgot-password.html" class="text-decoration-none">Forgot password?</a>
        </div> -->
      </div>

      <div class="d-flex justify-content-between mt-4">
        <a href="/MunicipalITDivision_war_exploded/signup.jsp" id="signup_btn" class="btn btn-outline-secondary btn-action">
          Sign Up
        </a>
        <button type="submit" id="signin_btn" class="btn btn-primary btn-action">
          Sign In
        </button>
      </div>

    </form>
    <%Object obj=request.getAttribute("error");
      if(obj!=null){
        String msg=obj.toString();
    %>

    <%--        <div class="alert alert-danger" role="alert">--%>

    <%if (msg.equals("Mismatch")){ %>

    <div class="alert alert-danger" role="alert">Email and password missmatch</div>

    <%}
      if (msg.equals("Invalid_e")){%>
    <div class="alert alert-danger" role="alert">Inavlid mail</div>

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
    console.log('jQuery loaded');
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

    // $('#confirmPassword').on('input', function() {
    //   const matches = $('#password').val() === $(this).val();
    //   $(this).toggleClass('is-valid', matches).toggleClass('is-invalid', !matches);
    //   $('#confirmPasswordError').toggle(!matches);
    // });

    $('#signin_btn').click(function (e) {
      let isValid = true;

      if (!emailRegex.test($('#email').val().trim())) {
        $('#email').addClass('is-invalid');
        $('#emailError').text('Please enter a valid email address').show();
        isValid = false;
      }

      // if ($('#password').val() !== $('#confirmPassword').val()) {
      //   $('#password, #confirmPassword').addClass('is-invalid');
      //   $('#confirmPasswordError').text('Passwords do not match').show();
      //   isValid = false;
      // }

      if (!isValid) {
        e.preventDefault();
        $('.is-invalid').first().focus();
      }
    });
  });
</script>
</body>
</html>