resource "aws_security_group" "application_lb" {
  name        = "alb-ECS"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "ingress_tcp_alb" {
  type              = "ingress"
  from_port         = 8000
  to_port           = 8000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.application_lb.id
}

resource "aws_security_group_rule" "egress_tcp_alb" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.application_lb.id
}

resource "aws_security_group" "private_net" {
  name        = "private-ECS"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "ingress_ECS" {
  type              = "ingress"
  from_port         = 0 # these ports will come from load balancer
  to_port           = 0
  protocol          = "-1"
  source_security_group_id = aws_security_group.application_lb.id
  security_group_id = aws_security_group.private_net.id
}

resource "aws_security_group_rule" "egress_ECS" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.private_net.id
}