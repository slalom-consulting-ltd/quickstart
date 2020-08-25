data "aws_iam_policy_document" "rancher" {

  statement {
    sid = "1"

    actions = [
      "ec2:Describe*",
      "ec2:CreateSecurityGroup",
      "ec2:CreateTags",
      "ec2:*Volume",
      "ec2:ModifyInstanceAttribute",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:*Route",
      "ec2:DeleteSecurityGroup",
      "ec2:RevokeSecurityGroupIngress"
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = "2"

    actions = [
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:AttachLoadBalancerToSubnets",
      "elasticloadbalancing:ApplySecurityGroupsToLoadBalancer",
      "elasticloadbalancing:CreateLoadBalancer",
      "elasticloadbalancing:CreateLoadBalancerPolicy",
      "elasticloadbalancing:CreateLoadBalancerListeners",
      "elasticloadbalancing:ConfigureHealthCheck",
      "elasticloadbalancing:DeleteLoadBalancer",
      "elasticloadbalancing:DeleteLoadBalancerListeners",
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:DetachLoadBalancerFromSubnets",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:ModifyLoadBalancerAttributes",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "elasticloadbalancing:SetLoadBalancerPoliciesForBackendServer",
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:CreateListener",
      "elasticloadbalancing:CreateTargetGroup",
      "elasticloadbalancing:DeleteListener",
      "elasticloadbalancing:DeleteTargetGroup",
      "elasticloadbalancing:ModifyListener",
      "elasticloadbalancing:ModifyTargetGroup",
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:SetLoadBalancerPoliciesOfListener"
    ]

    resources = [
      "*",
    ]
  }
  statement {
    sid = "3"

    actions = [
      "iam:CreateServiceLinkedRole",
    ]

    resources = [
      "*",
    ]
  }
  statement {
    sid = "4"

    actions = [
      "route53:AssociateVPCWithHostedZone"
    ]

    resources = [
      "*",
    ]
  }
  statement {
    sid = "5"

    actions = [
      "kms:DescribeKey"
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = "6"

    actions = [
      "ecr:Get*",
      "ecr:BatchCheckLayerAvailability",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:BatchGetImage"
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = "7"

    actions = [
      "autoscaling:Describe*"
    ]

    resources = [
      "*",
    ]
  }

}
