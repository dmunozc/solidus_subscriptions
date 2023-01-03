# frozen_string_literal: true

Deface::Override.new(
  virtual_path: "cart_line_items/_product_submit",
  name: "subscription_line_item_fields",
  insert_after: "[class='product-submit']",
  partial: "spree/frontend/products/subscription_line_item_fields"
)
