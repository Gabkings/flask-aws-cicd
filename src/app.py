from flask import Flask, jsonify


application = Flask(__name__)

ids = ['i-0ed3e619a2a32601a']

conn = boto.ec2.connect_to_region('us-west-2')


@application.route("/tags")
def show_tags():
    # Find a specific instance, returns a list of Reservation objects
    reservations = conn.get_all_instances(instance_ids= ids)
    # Find the Instance object inside the reservation
    instance = reservations[0].instances[0]
    return jsonify({"tags":instance.tags})


@application.route("/shutdown")
def shutdown_ec2():
    # Find a specific instance, returns a list of Reservation objects
    reservations = conn.stop_instances(instance_ids= ids)
    instances = con.get_all_reservations(filters={'instance-state-name': 'running'})
    instance_status = []
    for instance in instances:
        instance_status.append({instance.id: instance.instance_type})
    return jsonify({"instances_status": instance_status})
    

@application.route("/start")
def shutdown_ec2():
    # Find a specific instance, returns a list of Reservation objects
    reservations = conn.start_instances(instance_ids= ids)
    instances = con.get_all_reservations(filters={'instance-state-name': 'running'})
    instance_status = []
    for instance in instances:
        instance_status.append({instance.id: instance.instance_type})
    return jsonify({"instances_status": instance_status})

@application.route("/")
def index():
    return "Hello World from Flask Hello Page.<b> v1.0"

#--------Main------------------
if __name__ == "__main__":
    application.debug = True
    application.run()