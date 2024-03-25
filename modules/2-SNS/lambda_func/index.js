const AWS = require('aws-sdk');
const sns = new AWS.SNS();
const ec2 = new AWS.EC2();

exports.handler = async (event) => {
	
	const instanceId = JSON.parse(event).instance_id;

	const paramsIP = {
		InstanceIds: [instanceId],
	};

	const data = await ec2.describeInstances(paramsIP).promise();
	const instance = data.Reservations[0].Instances[0];
	const ipAddress = instance.PublicIpAddress;

	const message = `L'instance EC2 ${instanceId} a bien démarré sont ip est : ${ipAddress}.`;

	const params = {
		Message: message,
		TopicArn: process.env.SNS_TOPIC_ARN,
	};

	try {
		await sns.publish(params).promise();
		return { statusCode: 200, body: 'Message sent' };
	} catch (error) {
		console.error(error);
		return { statusCode: 500, body: 'Failed to send message' };
	}
};
