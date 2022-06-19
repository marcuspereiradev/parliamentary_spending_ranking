module DashboardHelper
  def number_to_currency_br(value)
    number_to_currency(value, unit: 'R$ ', separator: ',', delimiter: '.')
  end

  def date_to_br_date(date)
    Date.parse(date).strftime('%d/%m/%Y') unless date.nil?
  end

  def most_spent_supplier
    all_suppliers = @deputy.spents.pluck(:txt_fornecedor).uniq
    supplier_that_paid_more = all_suppliers.map do |supplier|
      {
        'supplier' => supplier,
        'total_spent' => @deputy.spents.where(txt_fornecedor: supplier).pluck(:vlr_liquido).sum
      }
    end

    @teste = supplier_that_paid_more.max_by { |supplier| supplier['total_spent'] }
  end
end
