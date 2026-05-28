function checkLogin() {
    const emailSalvo = localStorage.getItem("usuario_email");
    const loginLink = document.getElementById("login-link");
    const userLoggedDiv = document.getElementById("user-logged");
    const userNameSpan = document.getElementById("user-name");

    if (emailSalvo) {
        if (loginLink) loginLink.style.display = "none";
        if (userLoggedDiv) userLoggedDiv.style.display = "block";
        if (userNameSpan) userNameSpan.textContent = emailSalvo;
    } else {
        if (loginLink) loginLink.style.display = "block";
        if (userLoggedDiv) userLoggedDiv.style.display = "none";
    }
}

function logout() {
    localStorage.removeItem("usuario_email");
    localStorage.removeItem("usuario_nome");
    // Redireciona para a index ao sair para limpar o estado da aplicação
    window.location.href = "index.html";
}