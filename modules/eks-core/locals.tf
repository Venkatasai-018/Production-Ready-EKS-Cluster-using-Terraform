# common tags applied to all resources


locals {
  tags=merge(
  {
    Enviornment=var.env
    Terraform=true
    component="eks-core"
  },
  var.tags
  )
}