<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>VT Mart | My Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #0b0f19; color: #f3f4f6; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .order-card { background: #111827; border: 1px solid #1f2937; border-radius: 12px; transition: transform 0.2s; }
        .order-card:hover { border-color: #ef4444; }
        .badge-status { background-color: rgba(16, 185, 129, 0.2); color: #34d399; border: 1px solid #059669; }
        .btn-store { background-color: #ef4444; border: none; font-weight: 600; border-radius: 8px; }
        .btn-store:hover { background-color: #dc2626; }
    </style>
</head>
<body class="py-5">
<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-white mb-0"><span class="text-danger">VT</span>Mart Orders</h3>
            <p class="text-secondary small mb-0">Your past purchases & orders</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary me-2"><i class="fa-solid fa-store me-1"></i> Store</a>
            <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-danger"><i class="fa-solid fa-cart-shopping me-1"></i> Cart</a>
        </div>
    </div>

    <c:choose>
        <c:when test="${empty orders}">
            <div class="text-center py-5">
                <i class="fa-solid fa-box-open text-secondary fa-4x mb-3"></i>
                <h4 class="text-white">No orders placed yet</h4>
                <p class="text-secondary">Start exploring the gym store and place your first order.</p>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-store text-white px-4 py-2 mt-2">Shop Now</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row g-4">
                <c:forEach items="${orders}" var="ord">
                    <div class="col-12">
                        <div class="order-card p-4 d-flex justify-content-between align-items-center flex-wrap gap-3">
                            <div>
                                <div class="d-flex align-items-center gap-2 mb-1">
                                    <span class="text-danger fw-bold fs-5">#ORD-${ord.id}</span>
                                    <span class="badge badge-status px-2 py-1 small rounded-pill">${ord.status}</span>
                                </div>
                                <span class="text-secondary small">
                                    <i class="fa-regular fa-clock me-1"></i>${ord.createdAt}
                                </span>
                            </div>
                            <div class="text-end">
                                <div class="text-secondary small">Total Paid</div>
                                <div class="text-white fw-bold fs-4">Rs. ${ord.totalAmount}</div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
