module DashboardHelper
  def number_to_currency_br(value)
    number_to_currency(value, unit: 'R$ ', separator: ',', delimiter: '.')
  end

  def date_to_br_date(date)
    Date.parse(date).strftime('%d/%m/%Y') unless date.nil?
  end

  def most_spent_supplier
    max_value = @deputy.spents.max_by(&:vlr_liquido).vlr_liquido
    suppliers = @deputy.spents.where("vlr_liquido = #{max_value}")

    {
      'suppliers' => suppliers,
      'biggest_spent' => suppliers.count * max_value
    }
  end
end
