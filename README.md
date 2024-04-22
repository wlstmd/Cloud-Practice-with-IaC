# 클라우드 기능경기대회 선발전
클라우드 기능경기대회 선발전 대비 및 선발전 정리

1. 이미 있는 기본 VPC delete 및 VPC 생성

2. EC2 Instance 생성 및 조건이름에 맞는 key pair 생성
- Name: test-i-bastion(예시)
- OS: Amazon Linux 2023 AMI
- Architecture: x86
- Instance Type: t3a.micro

- VPC: test-vpc(예시본)
- Subnet: test-subnet-public-a
- Public IP: Enable
- Security group name: test-sg-bastion
- Security rules: ssh, anywhere
- Storage 8GiB gp3
- Advanced Details -> IAM 생성 (EC2 -> AdministratorAccess)
  역할 생성 (test-role-bastion)


3. 재부팅 하더라도 public ip가 달라지지 않게 eip 생성 및 연결


4. Launch Template 생성
- test-lt-webapp (예시본)
- Auto Scailing guidance 부여
- Quick Start -> Amazon Linux 2023 AMI x86
- 어플리케이션 서버로 t3a.micro를 사용하고 SSH로 접속할 것이 아니기 때문에 Key pair X
- Subnet 자동설정 -> 지정 X
- test-sg-webapp SG이름 (예시)
- Security Group은 80번 포트로 0.0.0.0/0
- Advanced Details
  시작 시 실행할 명렁어 작성


5. Auto Scaling Group 생성
- test-asg-webapp (예시본)
- Network > vpc 선택 및 private subnet a, b 선택


6. Load Balancer 생성
- HTTP를 위한 Application load balancer
- 이름 지정 (test-alb-webapp)
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
- s3링크 입력
- 권한 생성 동의 후 Submit

<hr></hr>
서버 테스트

```
#!/bin/bash

  for ((i=0; i<1000; i++)); do
      # 서버 시작 명령어
      ./start_server.sh
  done
  
  scp script.sh ec2-user@your_instance_ip:/path/to/destination
  
  ssh ec2-user@your_instance_ip
  cd /path/to/destination
  chmod +x script.sh
  ./script.sh
```
포트번호 변경하기
```
sudo vim /etc/ssh/sshd_config
sudo systemctl restart sshd
sudo systemctl status sshd
```
ec2화면
```
#!/bin/bash

# Apache HTTP Server 설치
yum install -y httpd

# Apache 서비스 시작
service httpd start

# /ip.html 파일 생성 및 IP 주소 쓰기
echo $(hostname -I) > /var/www/html/ip.html

# /date.html 파일 생성 및 현재 시간 쓰기
date=$(TZ=Asia/Seoul date +"%Y-%m-%d:%H:%M")
echo $date > /var/www/html/date.html
```
  
# html
```
    <script>
      document.write(window.location.hostname);
      document.write(new Date().toString());
    </script>
```
