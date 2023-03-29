class CombineItemsInCart < ActiveRecord::Migration[6.0]
  def up
    # multiple line items for a single product -> one line item with multiple products of the same type
    Cart.all.each do |cart|
      # group line items by product, sum quantities of each -> Hash?
      sums = cart.line_items.group(:product_id).sum(:quantity)

      sums.each do |product_id, quantity|
        if quantity > 1
          # remove individual items
          cart.line_items.where(product_id: product_id).delete_all

          item = cart.line_items.build(product_id: product_id)
          item.quantity = quantity
          item.save!
        end
      end
    end
  end
end
