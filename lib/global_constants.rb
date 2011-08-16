module GlobalConstants
  INCOME   = 0
  EXPENSE  = 1
  TRANSFER = 2

  TYPES = {
    INCOME   => "income",
    EXPENSE  => "expense",
    TRANSFER => "transfer"
  }

  NORMAL_TYPES = TYPES.reject { |key, value| key == TRANSFER }

  MENU_ITEMS = [
    :dashboard,
    :transactions,
    :finance,
    :statistics,
    :reports,
    :categories,
    :accounts,
    :settings
  ]

  APP_MENU = {
    :dashboard    => "app/dashboard",
    :transactions => "app/transactions",
    :finance      => "app/finances",
    :statistics   => "app/statistics",
    :reports      => "app/reports",
    :categories   => "app/categories",
    :accounts     => "app/accounts",
    :settings     => "app/settings"
  }

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

