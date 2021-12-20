from flask import Flask, jsonify
import boto3

application = Flask(__name__)

ids = 'i-02ce26d23ed3ca2c8'

AWS_REGION = "us-west-2"

EC2_RESOURCE = boto3.resource('ec2', region_name=AWS_REGION)


@application.route("/tags")
def show_tags():
    instances = EC2_RESOURCE.instances.filter(InstanceIds=[ids,],)
    instance_tags = []
    for instance in instances:
        print(f'EC2 instance {instance.id} tags:')
    if len(instance.tags) > 0:
        for tag in instance.tags:
            instance_tags.append({tag["Key"]: tag["Value"]})
        return jsonify({"tags": instance_tags})
    else:
        return jsonify({"tags" : " No Tags"})


@application.route("/shutdown")
def shutdown_ec2():
    instance = EC2_RESOURCE.Instance(ids)
    instance.stop()
    print(f'Stopping EC2 instance: {instance.id}')  
    instance.wait_until_stopped()
    print(f"EC2 instance {instance.id} has been stopped")
    return jsonify({"message": f"EC2 instance with id {instance.id} has been stopped"})

    

@application.route("/start")
def start_ec2():
    instance = EC2_RESOURCE.Instance(ids)

    instance.start()

    print(f'Starting EC2 instance: {instance.id}')
        
    instance.wait_until_running()

    print(f" EC2 instance {instance.id} has been started")

    return jsonify({"message ": f" EC2 instance with id {instance.id} has been started"})

@application.route("/")
def index():
    return "Hello World from Flask Hello Page.<b> v1.0"

#--------Main------------------
if __name__ == "__main__":
    application.debug = True
    application.run(host='0.0.0.0')