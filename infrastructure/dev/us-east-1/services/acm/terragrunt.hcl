terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-acm.git?ref=v4.3.1"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  domain_name = "felipetrindade.com"
  zone_id     = "Z10136172REA3ZXYNMN60"

  subject_alternative_names = [
    "*.felipetrindade.com",
  ]

  wait_for_validation = true
}
