# frozen_string_literal: true

# DashboardHelper
module DashboardHelper
  def number_to_currency_br(value)
    number_to_currency(value, unit: 'R$ ', separator: ',', delimiter: '.')
  end

  def date_to_br_date(date)
    Date.parse(date).strftime('%d/%m/%Y') unless date.nil?
  end

  def most_spent_supplier
    supplier_name, biggest_spent = search_supplier

    {
      name: supplier_name,
      biggest_spent: biggest_spent
    }
  end

  def search_supplier
    @deputy.spents
           .group('LOWER(txt_fornecedor)')
           .order('SUM(vlr_liquido) DESC')
           .pluck('LOWER(txt_fornecedor)', 'SUM(vlr_liquido)')
           .first
  end
end
