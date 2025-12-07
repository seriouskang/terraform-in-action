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

resource "aws_iam_group_policy_attachment" "admin-attach" {
  group      = "${aws_iam_group.admin.name}"
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

resource "aws_iam_role_policy" "s3-test-bucket-role-policy" {
  name = "s3-test-bucket-role-policy"
  role = aws_iam_role.s3-test-bucket-role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
          "arn:aws:s3:::test-bucket-251207",
          "arn:aws:s3:::test-bucket-251207/*"
      ]
    }
  ]
}
EOF

}

resource "aws_iam_instance_profile" "s3-test-bucket-role-instanceprofile" {
  name = "s3-test-bucket-role"
  role = aws_iam_role.s3-test-bucket-role.name
}