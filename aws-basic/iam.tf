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