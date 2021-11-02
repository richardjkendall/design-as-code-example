solution_name    = "Testapp4"
solution_number  = "APM00004"

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
  dialect  = "PL/SQL"
  virtual  = false
  ha       = true
  role     = "primary"

  availability = "5nines"

  sla {
    availability = "5nines"
    RTO          = "1hr"
    RPO          = "5mins"
  }
}
