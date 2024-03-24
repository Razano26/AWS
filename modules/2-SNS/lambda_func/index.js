const AWS = require('aws-sdk');
const sns = new AWS.SNS();

exports.handler = async (event) => {
	const params = {
		Message: process.env.NOTIFICATION_MESSAGE,
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
