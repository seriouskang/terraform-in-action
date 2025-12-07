resource "aws_iam_group" "admin" {
  name = "admin"
}

resource "aws_iam_user" "admin1" {
  name = "admin1"
}

resource "aws_iam_user" "admin2" {
  name = "admin2"
}

resource "aws_iam_group_membership" "admin-users" {
  name = "admin-users"
  users = [
    "${aws_iam_user.admin1.name}",
    "${aws_iam_user.admin2.name}"
  ]
  group = "${aws_iam_group.admin.name}"
}

resource "aws_iam_policy_attachment" "admin-attach" {
  name = "admin-attach"
  groups = [
    "${aws_iam_group.admin.name}"
  ]
  users = [
    "admin",
    "tf-user"
  ]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role" "s3-test-bucket-role" {
  name               = "s3-test-bucket-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}