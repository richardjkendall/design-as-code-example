solution_name    = "Testapp3"
solution_number  = "APM00003"

resource "server" "app_server" {
  os         = "Solaris"
  virtual    = false
  arch       = "sparc"
  cores      = 8
  memory     = 256
  role       = "active"
  count      = 2

  depends_on = [ 
    database.db
  ]
}

resource "database" "db" {
  type     = "Oracle"
  platform = "Solaris"
  arch     = "sparc"
  virtual  = false
  ha       = true
  role     = "primary"

  sla {
    availability = "5nines"
    RTO          = "1hr"
    RPO          = "5mins"
  }
}
