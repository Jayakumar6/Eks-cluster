data "aws_vpc" "default_vpc" {
  cidr_block = var.cidr_block
}
/*
data "aws_iam_role" "cluster_role" {
  name = var.name
}*/

resource "aws_eks_cluster" "cluster_project1" {
  name     = "cluster_project1"
  role_arn = var.role_arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.cluster_project1.name
  node_group_name = "eks_node_group"
  node_role_arn   = var.role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }
  instance_types = var.instance_types

  update_config {
    max_unavailable = 1
  }
}

