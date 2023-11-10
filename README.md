# Cloud-Practice-with-IaC
클라우드 기능경기대회 선발전 대비

1. 이미 있는 기본 VPC delete 및 VPC 생성

2. EC2 Instance 생성 및 조건이름에 맞는 key pair 생성
- Name: test(예시)
- OS: Amazon Linux 2023 AMI
- Architecture: x86
- Instance Type: t3a.micro

- VPC: test-vpc(예시본)
- Subnet: test-subnet-public-a
- Public IP: Enable
- Security group name: test-sg-bastion
- Security rules: ssh, anywhere
- Storage 8GiB gp3
- Advanced Details -> IAM 생성
  역할 생성 (test-role-bastion)


3. 재부팅 하더라도 public ip가 달라지지 않게 eip 생성 및 연결


4. Launch Template 생성
- test-lt-webapp (예시본)
- Auto Scailing guidance 부여
- Quick Start -> Amazon Linux 2023 AMI x86
- 어플리케이션 서버로 t3a.micro를 사용하고 SSH로 접속할 것이 아니기 때문에 Key pair X
- Subnet 자동설정 -> 지정 X
- Security Group은 80번 포트로 0.0.0.0/0
- Advanced Details
  시작 시 실행할 명렁어 작성


5. Auto Scaling Group 생성
- test-asg-webapp (예시본)
- Network > vpc 선택 및 private subnet a, b 선택


6. Load Balancer 생성
- HTTP를 위한 Application load balancer
- 인터넷 공개용 (internet-facing)으로 선택
- 로드 벨런서는 외부에서 접속이 가능해야 함으로 둘다 public 서브넷으로 선택
- Target group 설정 포트 : 80 | Create target group -> test-tg-webapp (예시본)
- Health Check grace period -> 0 second 설정
- Desired capacity | Minimum capacity | Maximum capacity 설정
- Scaling policies -> Target tracking으로 하고 적절한 이름을 입력 test-policy-alb (예시본) | networkout bytes 1K == 1024 설정 (예시) | 0 seconds 설정


7. ALB 접근 제한 설정
- Load Balancer -> Security - > Security ID 인바운드 권한 설정 : HTTP Ipv4 0.0.0.0/0 설정


8. ASG Scaling policy 설정
- Auto Scaling Groups -> Automatic scaling -> Edit을 눌러 수정 : Metric type 설정 | Target Group and Target Value 등 설정 (예시 1000, 0 seconds) -> 몇분 후 서버 개수 Down
- 로드 밸런서 DNS 접속


9. 리소스 삭제
- IAM Account alias 생성
- Cloud Formation -> Create Stack
``` bash
https://nukeme.s3.amazonaws.com/run
```
- 권한 생성 동의 후 Submit
