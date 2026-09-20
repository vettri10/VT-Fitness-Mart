package com.vt.vtmart.model;

import java.math.BigDecimal;

public class CartItem {
    private Long id;
    private Long userId;
    private Long cartId;
    private Long productId;
    private String productName;
    private BigDecimal productPrice;
    private BigDecimal price;
    private Integer quantity;
    private BigDecimal subtotal;
    private String imageUrl;

    public CartItem() {}

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getCartId() {
        return cartId;
    }

    public void setCartId(Long cartId) {
        this.cartId = cartId;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public BigDecimal getProductPrice() {
        return (productPrice != null) ? productPrice : price;
    }

    public void setProductPrice(BigDecimal productPrice) {
        this.productPrice = productPrice;
        this.price = productPrice;
    }

    public BigDecimal getPrice() {
        return (price != null) ? price : productPrice;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
        this.productPrice = price;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getSubtotal() {
        if (subtotal != null) return subtotal;
        BigDecimal p = getProductPrice();
        if (p != null && quantity != null) {
            return p.multiply(BigDecimal.valueOf(quantity));
        }
        return BigDecimal.ZERO;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}