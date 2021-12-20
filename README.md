#### What does this PR do?

1. Create Terraform code to create an S3 bucket and an EC2 instance. Both resources must be tagged with Name=Flugel, Owner=InfraTeam.
2. Using Terratest, create the test automation for the Terraform code, validating that both resources are tagged properly.
3. In the EC2 instance, run a simple HTTP service written in Python with two endpoints:
   1. /tags: must display EC2 instance tags.
   2. /shutdown: must shutdown the instance.
4. Setup Github Actions to run a pipeline to validate this code.
5. Publish your code in a public GitHub repository, and share a Pull Request with your code. Do not merge into master until the PR is approved.
6. Include documentation describing the steps to run and test the automation.

#### Description of Task to be completed?

1. Created S3 bucket and EC2 instances using terraform. Also created the deployment rule and group using terraform.
2. Created a flask rest application which has two endpoints: one for fetching instance tags via instance id and the send one for shutdown the server and starting the server as well.
3. Setting up Github actions for automating the deployment of the flask app to ec2 instance via the help of the code deploy tool
4. Created sample documentation on how to test the code on the readme file.

## How should this be manually tested?

#### Setup VirtualEnvironment

- Setup Python virtual environment by running `python3 -m venv venv`
- Activate the virtual environment by running (linux users)  `source venv/bin/activate`
- - Activate the virtual environment by running (windows users)  `source venv/Scripts/activate`

### Install Application Dependencies

- Run the following command to install application dependencies `pip install -r requirements.txt`
- After installing the dependencies, add the necessary environmental variables required by the application to authenticate to the AWS console. Sample environmental varials are:

  ```bash
     AWS configure
     AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
     AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
     Default region name [None]: us-west-2
  ```

### To create access keys for an IAM user

1. [Sign in to the AWS Management Console and open the IAM console](https://console.aws.amazon.com/iam/.)
2. In the navigation pane, choose Users.
3. Choose the name of the user whose access keys you want to create, and then choose the Security credentials tab.
4. In the Access keys section, choose Create access key.
5. To view the new access key pair, choose Show. You will not have access to the secret access key again after this dialog box closes. Your credentials will look something like this:
6. Access key ID: AKIAIOSFODNN7EXAMPLE
7. Secret access key: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
8. To download the key pair, choose Download .csv file. Store the keys in a secure location. You will not have access to the secret access key again after this dialog box closes.
9. Keep the keys confidential in order to protect your AWS account and never email them. Do not share them outside your organization, even if an inquiry appears to come from AWS or Amazon.com. No one who legitimately represents Amazon will ever ask you for your secret key.
10. After you download the .csv file, choose Close. When you create an access key, the key pair is active by default, and you can use the pair right away.
11. Instead of using aws configure to enter in a key pair, you can import the .csv file you downloaded after you created your key pair. To do this, use the aws configure import command with the --csv option as follows:`aws configure import --csv file://credentials.csv`

### Start the Server

- After successfully performing migrations, the server can be started by running `python src/app.py` at the root of the project

### Running Tests

- To run unit test, [pytest](https://docs.pytest.org/en/latest/) is used. Run `pytest` at the root of the project

#### Any background context you want to provide?

To run the app you must have python installed and also aws cli installed and configured correctly.

#### Screenshots (if appropriate)

![Screenshot (116)](https://user-images.githubusercontent.com/33205781/146787426-ef0b7b9b-b8d9-4f65-9a8d-91824711e58c.png)
![Screenshot (117)](https://user-images.githubusercontent.com/33205781/146787453-54d6ae47-6ce4-419a-abc1-fdf0d87565cb.png)
![Screenshot (118)](https://user-images.githubusercontent.com/33205781/146787462-a4bf8463-4803-4934-914e-afe29f4364ab.png)
![Screenshot (119)](https://user-images.githubusercontent.com/33205781/146787474-4727e630-7e8c-41fc-bc42-aa60d7239b3d.png)
![Screenshot (120)](https://user-images.githubusercontent.com/33205781/146788010-bfe4a508-8e0b-4ebd-bbff-3088a4df8b00.png)
![Screenshot (121)](https://user-images.githubusercontent.com/33205781/146788017-b2159044-0bab-40ef-b1fe-661d68a719d9.png)
![Screenshot (122)](https://user-images.githubusercontent.com/33205781/146788022-4f5cd5d1-e6a8-4eca-8a60-3117eb205306.png)
![Screenshot (123)](https://user-images.githubusercontent.com/33205781/146788028-5694e76a-2dc5-4f16-a3c0-e525bfecac1e.png)
![Screenshot (124)](https://user-images.githubusercontent.com/33205781/146788034-c2e08dff-c7c0-4abd-8f6c-ba8711693a89.png)

#### Questions:
