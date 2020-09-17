data "template_file" "script" {
  template = file("${path.module}/add-more-tags.sh")
  vars = {
    region = var.region
    tags = var.additional_tags
  }
}