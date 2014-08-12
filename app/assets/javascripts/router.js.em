# For more information see: http://emberjs.com/guides/routing/

Prioritime.Router.map ->
  @route("index", path: "/")

  @route("playground")

  @route("dashboard", path: "/dashboard")
  
  @resource("employees", path: '/employees', ->
    @route('index', path: '/')
    @route('new', path: '/new')
    @route('show', path: '/')
    @route('edit', path: '/:slug/edit')
  )

Prioritime.Router.reopen
  location: 'history'


  # For future use when we scale up
  # @resource 'companies', path: '/companies/:slug', ->
  #   @route('dashboard', path: '/dashboard')
    
  #   @resource 'companies.employees', path: 'employees', ->
  #     @route('index', path: '/')
  #     @route('new', path: '/new')
  #     @route('show', path: '/')
  #     @route('edit', path: '/:slug/edit')

