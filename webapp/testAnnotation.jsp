<%@ page import="java.lang.reflect.*" %>
<%@ page import="test.java.TestAnnotationUrl" %>
<%@ page import="com.annotations.HandleUrl" %>

<html>
<head>
    <title>Test Annotation</title>
</head>
<body>
    <h2>Valeurs trouvees dans @HandleUrl :</h2>
    <ul>
    <%
        // Obtenir la classe Test
        Class<?> clazz = TestAnnotationUrl.class;

        // Parcourir les méthodes et chercher les annotations
        for (Method m : clazz.getDeclaredMethods()) {
            if (m.isAnnotationPresent(HandleUrl.class)) {
                HandleUrl ann = m.getAnnotation(HandleUrl.class);
    %>
                <li><%= ann.value() %></li>
    <%
            }
        }
    %>
    </ul>
</body>
</html>
