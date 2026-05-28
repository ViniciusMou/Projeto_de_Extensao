<%-- 
    Document   : cadastro
    Created on : 4 de mai. de 2026, 15:07:01
    Author     : Fernando Caue
--%>

<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

<%
request.setCharacterEncoding("UTF-8");

String nome = request.getParameter("name");
String email = request.getParameter("email");
String cpf = request.getParameter("cpf");
String telefone = request.getParameter("phone");
String senha = request.getParameter("password");

Connection conn = null;
PreparedStatement stmt = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/lifestyle?useSSL=false&serverTimezone=UTC",
        "root",
        "admin"
    );

    // 🔍 Verifica se já existe usuário com mesmo email ou CPF
    String verificaSql = "SELECT id FROM usuario WHERE email = ? OR cpf = ?";
    PreparedStatement verificaStmt = conn.prepareStatement(verificaSql);
    verificaStmt.setString(1, email);
    verificaStmt.setString(2, cpf);

    ResultSet rs = verificaStmt.executeQuery();

    if (rs.next()) {
%>
        <h3 style="color:red;">Usuário já cadastrado com esse e-mail ou CPF!</h3>
<%
    } else {

        String sql = "INSERT INTO usuario (nome, email, cpf, telefone, senha) VALUES (?, ?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);

        stmt.setString(1, nome);
        stmt.setString(2, email);
        stmt.setString(3, cpf);
        stmt.setString(4, telefone);
        stmt.setString(5, senha);

        stmt.executeUpdate();

        response.sendRedirect("pagamento.html");
    }

} catch(Exception e) {
%>
    <h2 style="color:red;">Erro ao cadastrar:</h2>
    <p><%= e.getMessage() %></p>
<%
} finally {
    try {
        if(stmt != null) stmt.close();
        if(conn != null) conn.close();
    } catch(Exception e) {
        out.println("Erro ao fechar conexão");
    }
}
%>