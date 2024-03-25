const AWS = require('aws-sdk');
const sns = new AWS.SNS();

exports.handler = async (event) => {
	const instanceId = JSON.parse(event).instance_id; // Récupération de l'ID de l'instance depuis l'événement
	const ip = JSON.parse(event).ip_address; // Récupération de l'IP de l'instance depuis l'événement
	const message = `L'instance EC2 ${instanceId} a bien démarré sont ip est : ${ip}.`; // Message personnalisé incluant l'ID de l'instance

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
