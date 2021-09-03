<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/jsp/include/session.jsp"></jsp:include>

<!doctype html>
<html lang="en">

<head>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp"></jsp:include>
</head>

<body>

  <!-- top Menu -->
  <jsp:include page="/WEB-INF/jsp/include/topMenu.jsp"></jsp:include>

    <!-- FULLPAGE
    ================================================== -->
    <section class="section section-full section-top">
        <!-- Content -->
        <div class="container">
            <div class="secret-info" id="event_contents">
              <c:if test="${board_content != '' && board_content != null}">
                ${board_content}
              </c:if>
            </div>
        </div> <!-- / .container -->
    </section>

    <!-- FOOTER
    ================================================== -->
    <jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>

    <script>
      $(document).ready(function() {

        <c:if test="${ref_url != '' && ref_url != null}">
          $('#event_contents').load('${ref_url}');
        </c:if>

      });
    </script>

</body>

</html>