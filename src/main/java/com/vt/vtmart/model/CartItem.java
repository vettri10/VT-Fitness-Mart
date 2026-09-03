package com.vt.vtmart.model;

import java.math.BigDecimal;

public class CartItem {
    private Long id;
    private Long userId;
    private Long productId;
    private Integer quantity;
    private String productName;
    private BigDecimal productPrice;
    private String imageUrl;

    public CartItem() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }
    public Long getProductId() { return productId; }
    public void setProductId(Long productId) { this.productId = productId; }
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public BigDecimal getProductPrice() { return productPrice; }
    public void setProductPrice(BigDecimal productPrice) { this.productPrice = productPrice; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public BigDecimal getSubtotal() {
        return productPrice != null ? productPrice.multiply(new BigDecimal(quantity)) : BigDecimal.ZERO;
    }
}