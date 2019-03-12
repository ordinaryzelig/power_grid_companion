module EnumResourceKind

  def self.extended(model)
    model.enum :kind => {
      :coal    => 1,
      :oil     => 2,
      :uranium => 3,
      :trash   => 4,
    }
  end

end
