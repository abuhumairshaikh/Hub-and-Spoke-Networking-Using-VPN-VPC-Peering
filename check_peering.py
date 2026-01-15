import boto3

ec2 = boto3.client('ec2')

response = ec2.describe_vpc_peering_connections()

print("\n=== VPC PEERING CONNECTIONS ===\n")

for pcx in response['VpcPeeringConnections']:
    pcx_id = pcx['VpcPeeringConnectionId']
    status = pcx['Status']['Code']

    requester_vpc = pcx['RequesterVpcInfo']['VpcId']
    requester_cidr = pcx['RequesterVpcInfo']['CidrBlock']

    accepter_vpc = pcx['AccepterVpcInfo']['VpcId']
    accepter_cidr = pcx['AccepterVpcInfo']['CidrBlock']

    print(f"Peering ID: {pcx_id}")
    print(f"Status   : {status}")
    print(f"From VPC : {requester_vpc} ({requester_cidr})")
    print(f"To VPC   : {accepter_vpc} ({accepter_cidr})")
    print("-" * 40)
