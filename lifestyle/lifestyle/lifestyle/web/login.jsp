<%-- 
    Document   : login
    Created on : 4 de mai. de 2026, 15:09:55
    Author     : Fernando Caue
--%>

<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

<%
String email = request.getParameter("email");
String senha = request.getParameter("password");

Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/lifestyle",
        "root",
        "admin"
    );

    // Selecionamos o nome e o email para garantir que temos ambos
    String sql = "SELECT nome, email FROM usuario WHERE email = ? AND senha = ?";
    stmt = conn.prepareStatement(sql);

    stmt.setString(1, email);
    stmt.setString(2, senha);

    rs = stmt.executeQuery();

    if(rs.next()) {
        String nomeUsuario = rs.getString("nome");
        String emailUsuario = rs.getString("email");
        
        // Mantém a sessão no servidor (segurança)
        session.setAttribute("usuario", nomeUsuario);
        session.setAttribute("email", emailUsuario);
%>
        <!-- Script para salvar os dados no navegador do cliente -->
        <script>
            localStorage.setItem("usuario_nome", "<%= nomeUsuario %>");
            localStorage.setItem("usuario_email", "<%= emailUsuario %>");
            
            // Agora redirecionamos via JS para garantir que o localStorage seja gravado
            window.location.href = "index.html"; 
        </script>
<%
    } else {
%>
        <div style="text-align: center; font-family: sans-serif; margin-top: 50px;">
            <h3 style="color:red;">E-mail ou senha inválidos!</h3>
            <a href="identificacao.html">Tentar novamente</a>
        </div>
<%
    }

} catch(Exception e) {
%>
    <h3 style="color:red;">Erro no login: <%= e.getMessage() %></h3>
<%
} finally {
    try {
        if(rs != null) rs.close();
        if(stmt != null) stmt.close();
        if(conn != null) conn.close();
    } catch(Exception e) {
        out.println("Erro ao fechar conexão");
    }
}
%>