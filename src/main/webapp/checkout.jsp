<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>VT Mart | Shipping & Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #0b0f19; color: #f3f4f6; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .checkout-card { background: #111827; border: 1px solid #1f2937; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.5); }
        .form-control, .form-select { background-color: #1f2937; border: 1px solid #374151; color: #f9fafb; }
        .form-control:focus, .form-select:focus { background-color: #1f2937; border-color: #ef4444; color: #fff; box-shadow: 0 0 0 0.25rem rgba(239, 68, 68, 0.25); }
        .btn-pay { background-color: #ef4444; border: none; font-weight: 600; padding: 12px; border-radius: 8px; transition: 0.2s; }
        .btn-pay:hover { background-color: #dc2626; }
        .payment-radio { background: #1f2937; border: 1px solid #374151; border-radius: 8px; padding: 12px; margin-bottom: 10px; cursor: pointer; display: flex; align-items: center; justify-content: space-between; }
    </style>
</head>
<body class="py-5">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="fw-bold text-white"><span class="text-danger">VT</span>Mart Checkout</h3>
                <a href="${pageContext.request.contextPath}/cart" class="text-secondary text-decoration-none"><i class="fa-solid fa-arrow-left"></i> Back to Cart</a>
            </div>

            <div class="checkout-card p-4 p-md-5">
                <form action="${pageContext.request.contextPath}/checkout" method="POST">
                    <h5 class="text-white mb-3"><i class="fa-solid fa-location-dot text-danger me-2"></i>Delivery Address</h5>
                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <label class="form-label text-secondary small">Full Name</label>
                            <input type="text" name="fullName" class="form-control" required placeholder="John Doe">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label text-secondary small">Contact Number</label>
                            <input type="tel" name="phone" class="form-control" required placeholder="+91 98765 43210">
                        </div>
                        <div class="col-12">
                            <label class="form-label text-secondary small">Street Address</label>
                            <input type="text" name="address" class="form-control" required placeholder="Door No, Street Name, Area">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label text-secondary small">City</label>
                            <input type="text" name="city" class="form-control" required placeholder="Chennai">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label text-secondary small">Postal Code</label>
                            <input type="text" name="postalCode" class="form-control" required placeholder="600001">
                        </div>
                    </div>

                    <h5 class="text-white mb-3"><i class="fa-solid fa-credit-card text-danger me-2"></i>Payment Method</h5>
                    <div class="payment-radio">
                        <div>
                            <input class="form-check-input me-2" type="radio" name="paymentMethod" id="upi" value="UPI" checked>
                            <label class="form-check-label text-white" for="upi">UPI / QR Code</label>
                        </div>
                        <span class="badge bg-success">Instant</span>
                    </div>
                    <div class="payment-radio">
                        <div>
                            <input class="form-check-input me-2" type="radio" name="paymentMethod" id="cod" value="COD">
                            <label class="form-check-label text-white" for="cod">Cash on Delivery</label>
                        </div>
                        <span class="badge bg-secondary">Available</span>
                    </div>

                    <div class="mt-4 pt-3 border-top border-secondary">
                        <button type="submit" class="btn btn-pay text-white w-100 fs-5">
                            <i class="fa-solid fa-lock me-2"></i>Confirm & Place Order
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
