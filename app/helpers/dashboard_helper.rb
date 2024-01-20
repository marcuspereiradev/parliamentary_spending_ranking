module DashboardHelper
  def number_to_currency_br(value)
    number_to_currency(value, unit: 'R$ ', separator: ',', delimiter: '.')
  end

  def date_to_br_date(date)
    Date.parse(date).strftime('%d/%m/%Y') unless date.nil?
  end

  def most_spent_supplier
    supplier_name = search_supplier_name
    biggest_spent = search_biggest_spent(supplier_name)

    {
      name: supplier_name,
      biggest_spent: biggest_spent
    }
  end

  def search_supplier_name
    @deputy.spents
           .select('txt_fornecedor, SUM(vlr_liquido) as total_spent')
           .group(:txt_fornecedor)
           .order('total_spent DESC')
           .first
           .txt_fornecedor
  end

  def search_biggest_spent(supplier_name)
    @deputy.spents.where('txt_fornecedor LIKE ?', "%#{supplier_name}%").pluck(:vlr_liquido).sum
  end
end
