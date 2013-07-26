
  # custom error routes
  match '/404' => 'errors#not_found'
  match '/422' => 'errors#unprocessable_entity'
  match '/500' => 'errors#application_error'
