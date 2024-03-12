module "module1" {
  source = "./modules/1-EC2"
}

module "module2" {
  source = "./modules/2-SNS"
}
