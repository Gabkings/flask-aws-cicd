resource "aws_iam_role" "test_role" {
  name = "test_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action":"sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com",
         "codedeploy.us-east-2.amazonaws.com",
         "codedeploy.amazonaws.com",
            "codedeploy.us-east-1.amazonaws.com",
            "codedeploy.us-west-1.amazonaws.com",
            "codedeploy.us-west-2.amazonaws.com",
            "codedeploy.eu-west-3.amazonaws.com",
            "codedeploy.ca-central-1.amazonaws.com",
            "codedeploy.eu-west-1.amazonaws.com",
            "codedeploy.eu-west-2.amazonaws.com",
            "codedeploy.eu-central-1.amazonaws.com",
            "codedeploy.ap-east-1.amazonaws.com",
            "codedeploy.ap-northeast-1.amazonaws.com",
            "codedeploy.ap-northeast-2.amazonaws.com",
            "codedeploy.ap-southeast-1.amazonaws.com",
            "codedeploy.ap-southeast-2.amazonaws.com",
            "codedeploy.ap-south-1.amazonaws.com",
            "codedeploy.sa-east-1.amazonaws.com"
        ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      tag-key = "tag-value"
  }
}

resource "aws_codedeploy_app" "example" {
  name = "flask-app"
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.test_role.name
}

resource "aws_sns_topic" "example" {
  name = "flask-topic"
}


resource "aws_codedeploy_deployment_group" "example" {
  app_name              = aws_codedeploy_app.example.name
  deployment_group_name = "flask-group"
  service_role_arn      = aws_iam_role.test_role.arn

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = "Flugel"
    }

    ec2_tag_filter {
      key   = "Owner"
      type  = "KEY_AND_VALUE"
      value = "InfraTeam"
    }
  }

  trigger_configuration {
    trigger_events     = ["DeploymentFailure"]
    trigger_name       = "example-trigger"
    trigger_target_arn = aws_sns_topic.example.arn
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  alarm_configuration {
    alarms  = ["my-alarm-name"]
    enabled = true
  }
}


resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = "${aws_iam_role.test_role.name}"
}

resource "aws_iam_role_policy" "test_policy" {
  name = "test_policy"
  role = "${aws_iam_role.test_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
    "Sid": "CodeDeployAccessPolicy",
      "Action": [
        "autoscaling:*",
        "codedeploy:*",
        "cloudformation:*",
        "ec2:*",
        "lambda:*",
        "ecs:*",
        "elasticloadbalancing:*",
        "iam:AddRoleToInstanceProfile",
        "iam:AttachRolePolicy",
        "iam:CreateInstanceProfile",
        "iam:CreateRole",
        "iam:DeleteInstanceProfile",
        "iam:DeleteRole",
        "iam:DeleteRolePolicy",
        "iam:GetInstanceProfile",
        "iam:GetRole",
        "iam:GetRolePolicy",
        "iam:ListInstanceProfilesForRole",
        "iam:ListRolePolicies",
        "iam:ListRoles",
        "iam:PutRolePolicy",
        "iam:RemoveRoleFromInstanceProfile",
        "s3:*",
        "ssm:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::gabkings/*",
        "arn:aws:s3:::aws-codedeploy-us-east-2/*",
        "arn:aws:s3:::aws-codedeploy-us-east-1/*",
        "arn:aws:s3:::aws-codedeploy-us-west-1/*",
        "arn:aws:s3:::aws-codedeploy-us-west-2/*",
        "arn:aws:s3:::aws-codedeploy-ca-central-1/*",
        "arn:aws:s3:::aws-codedeploy-eu-west-1/*",
        "arn:aws:s3:::aws-codedeploy-eu-west-2/*",
        "arn:aws:s3:::aws-codedeploy-eu-west-3/*",
        "arn:aws:s3:::aws-codedeploy-eu-central-1/*",
        "arn:aws:s3:::aws-codedeploy-ap-east-1/*",
        "arn:aws:s3:::aws-codedeploy-ap-northeast-1/*",
        "arn:aws:s3:::aws-codedeploy-ap-northeast-2/*",
        "arn:aws:s3:::aws-codedeploy-ap-southeast-1/*",        
        "arn:aws:s3:::aws-codedeploy-ap-southeast-2/*",
        "arn:aws:s3:::aws-codedeploy-ap-south-1/*",
        "arn:aws:s3:::aws-codedeploy-sa-east-1/*"
      ]
    }
  ]
}
EOF
}