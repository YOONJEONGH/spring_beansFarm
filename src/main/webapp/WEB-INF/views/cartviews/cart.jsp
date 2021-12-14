<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<link rel="stylesheet" href="../../../resources/css/cart/cart.css">

<script src="../../../../resources/js/jquery-3.6.0.min.js" ></script>
<script src="../../../../resources/js/cart/Cart.js" ></script>


    <div id="content">
        <h1>장바구니</h1>

        <br>
        
        <p>주문하실 제품의 제품명과 수량을 정확히 확인해 주세요.</p>

        <h3>제품 정보</h3>
        <table id="infoTbl">
            <tr>
                <td width="5%"><input type="checkbox" name='cartAll' id='cartAll' checked></td>
                <td width="10%"><b>전체선택</b></td>
                <td width="45%" colspan="2"><b>제품정보</b>
                <td width="10%"><b>판매가</b></td>
                <td width="10%"><b>수량</b></td>
                <td width="10%"><b>제품금액</b></td>
            </tr>

            <!-- 로그인이 되어있지 않을시 -->
            <c:choose>
            	<c:when test="${userID eq null}">
		            <tr>
		                <td colspan="7" height="350px">
		                    <h3>로그인을 해주세요 :(</h3><br>
		                    <button id="basket" onClick="location.href='/memberloginviews/memberLogin_view'">로그인 하러 가기</button>
		                </td>
		            </tr>
            	</c:when>
            	
            	<c:when test="${empty cartAllList}">
		            <tr>
		                <td colspan="7" height="350px">
		                    <h3>장바구니에 담긴 제품이 없습니다 :(</h3><br>
		                    <button id="basket" onClick="location.href='/product/product_view?keyword='">제품 담으러 가기</button>
		                </td>
		            </tr>
            	</c:when>
            	
            	<c:when test="${!empty cartAllList}">
            	<c:forEach var="cartAllList" items="${cartAllList}"> 
		            <tr>
		                <td><input type="checkbox" name='cartChk' class='cartChk' checked value="${cartAllList.cart_no}"></td>
		                <td></td>
		                <td> <img src="/upload/product/${cartAllList.p_thumbnail}"></td>
		                <td>
			                <ul>
								<li><b>${cartAllList.p_name}</b></li>		
								<c:forEach var="opList" items="${opList}">                 
									<c:if test="${cartAllList.op_no1 == opList.op_no}"><li>용량 : ${opList.op_name} </li></c:if>
								</c:forEach>
										
								<c:forEach var="opList" items="${opList}">                 
									<c:if test="${cartAllList.op_no2 == opList.op_no}"><li>분쇄 선택 : ${opList.op_name} </li></c:if>
								</c:forEach>		                
			                </ul>
		               
		                </td>
		                <td><fmt:formatNumber value="${cartAllList.p_price}" pattern="#,###" /></td>
		                <td>${cartAllList.option_quantity1}</td>
		                
		                <td><fmt:formatNumber value="${cartAllList.order_price}" pattern="#,###" />
		                	<input type="hidden" name="order_price" class="order_price" id="order_price" value="${cartAllList.order_price}">
		                </td>
		            </tr>
		         </c:forEach>
		         </c:when> 
            </c:choose>
            
            <tr>
                <td align="left" colspan="2">
                    <input type="button" name="choiceBtn" id="choiceBtn" value="선택삭제">
                    <input type="button" name="allBtn" id="allBtn" value="전체삭제">
                    
                </td>
                
                <td>
                	
                </td>
                
                <td align="right" colspan="5">
                	<h3>
                		<input type="text" name="total_price" id="total_price">원
                	</h3>
                </td>
            
            </tr>
        </table>
        
        <br><br><br>
        
		<c:choose>
            	<c:when test="${userID ne null}">
			        <div id="order">
			            <button id="orderBtn">주문하기</button>
			        </div>
        		</c:when>
        </c:choose>
    </div>
    
    <form method="post" action="/orderviews/orderCon_view" id="goToOrder">
    	<input type="hidden" id="cart_list" name="cartNoList">
    </form>