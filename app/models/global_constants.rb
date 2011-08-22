module GlobalConstants
  INCOME   = 0
  EXPENSE  = 1
  TRANSFER = 2

  TYPES = {
    INCOME   => "income",
    EXPENSE  => "expense",
    TRANSFER => "transfer"
  }.freeze

  NORMAL_TYPES = TYPES.reject { |key, value| key == TRANSFER }.freeze

  MENU_ITEMS = [
    :dashboard,
    :transactions,
    :categories,
    :accounts
  ].freeze

  APP_MENU = {
    :dashboard    => "app/dashboard",
    :transactions => "app/transactions",
    :categories   => "app/categories",
    :accounts     => "app/accounts"
  }.freeze

  # Position of columns in transactions table
  KIND          = 0
  DATE          = 1
  CATEGORY_NAME = 2
  AMOUNT        = 3
  DESCRIPTION   = 4

  #class Position
    #KIND          = 0
    #DATE          = 1
    #CATEGORY_NAME = 2
    #AMOUNT        = 3
    #DESCRIPTION   = 4
  #end
end

