class AdminController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @current_time_in_nairobi = Time.current.in_time_zone('Nairobi')

    @orders = Order.where(fulfilled: false).order(created_at: :desc).take(5)
    @quick_stats = {
      sales: Order.where(created_at: Time.current.beginning_of_day..Time.current.end_of_day).count,
      revenue: Order.where(created_at: Time.current.beginning_of_day..Time.current.end_of_day).sum(:total)&.round,
      avg_sale: Order.where(created_at: Time.current.beginning_of_day..Time.current.end_of_day).average(:total)&.round,
      per_sale: OrderProduct.joins(:order).where(orders: { created_at: Time.current.beginning_of_day..Time.current.end_of_day }).average(:quantity)
    }

    @orders_by_day = Order.where('created_at > ?', 7.days.ago).order(:created_at)
    @orders_by_day = @orders_by_day.group_by { |order| order.created_at.to_date }
    @revenue_by_day = @orders_by_day.map { |day, orders| [day.strftime("%A"), orders.sum(&:total)] }

    if @revenue_by_day.count < 7
      days_of_week = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

      data_hash = @revenue_by_day.to_h
      current_day = Date.today.strftime("%A")
      current_day_index = days_of_week.index(current_day)
      next_day_index = (current_day_index + 1) % days_of_week.length

      ordered_days_with_current_last = days_of_week[next_day_index..-1] + days_of_week[0...next_day_index]

      complete_ordered_array_with_current_last = ordered_days_with_current_last.map { |day| [day, data_hash.fetch(day, 0)] }

      @revenue_by_day = complete_ordered_array_with_current_last
    end
  end
end
