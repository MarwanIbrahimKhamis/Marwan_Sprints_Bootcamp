resource "aws_eks_cluster" "my_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  tags = var.tags
}

resource "aws_iam_role" "eks_cluster" {
  name = "${var.cluster_name}-eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_iam_instance_profile" "eks_node" {
  name = "${var.cluster_name}-eks-profile"

  role = aws_iam_role.eks_node.name
}

resource "aws_iam_role" "eks_node" {
  name = "${var.cluster_name}-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_node" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node.name
}

resource "aws_iam_role_policy_attachment" "eks_cni" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node.name
}

module "eks_worker_nodes" {
  source = "terraform-aws-modules/eks/aws//modules/worker_nodes"

  cluster_name = var.cluster_name
  subnets      = var.subnet_ids
  instance_type = var.instance_type
  desired_capacity = 2

  # Use the same IAM instance profile and security group for all worker nodes
  iam_instance_profile_name = aws_iam_instance_profile.eks_node.name
  additional_security_group_ids = [var.worker_security_group_id]

  # Use the same key pair for all worker nodes
  key_name = var.key_name

  # Add additional tags to worker nodes
  tags = var.tags
}