data "aws_vpc" "default_vpc" {
  cidr_block = var.cidr_block
}

data "aws_subnet_ids" "default_subnet" {
  vpc_id = var.vpc_id
}
data "aws_subnet" "example" {
  for_each = data.aws_subnet_ids.default_subnet.ids
  id       = each.value
}

data "aws_iam_role" "cluster_role" {
  name = var.name
}

resource "aws_eks_cluster" "cluster_project1" {
  name     = "cluster_project1"
  role_arn = var.role_arn

  vpc_config {
    subnet_ids = [data.aws_subnet.default_subnet.id]
  }
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.cluster_project1.name
  node_group_name = "eks_node_group"
  node_role_arn   = var.role_arn
  subnet_ids      = data.aws_subnet.default_subnet.id

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }
  instance_types = var.instance_types

  update_config {
    max_unavailable = 2
  }
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = var.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = var.name
}