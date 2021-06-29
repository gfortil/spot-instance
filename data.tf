data "external" "get_region" {
  
  program = ["python", "${path.module}/query.py"]
  query = {
    size = var.vm_size
    rank = var.rank
  }
}