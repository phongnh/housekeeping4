module GlobalConstants
  INCOME   = 0
  EXPENSE  = 1
  TRANSFER = 2

  TYPES = {
    INCOME   => "income",
    EXPENSE  => "expense",
    TRANSFER => "transfer"
  }


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
end

