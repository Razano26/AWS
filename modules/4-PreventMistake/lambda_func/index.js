const AWS = require('aws-sdk');
const cloudwatch = new AWS.CloudWatch();

exports.handler = async (event) => {
	// Identifiez l'instance démarrée
	const instanceId = event.detail['instance-id'];
	const eventName = event.detail['state'];

	if (eventName === 'running') {
		// Assurez-vous que l'événement est pour un démarrage d'instance
		// Incrémentez une métrique personnalisée dans CloudWatch
		const params = {
			MetricData: [
				{
					MetricName: 'InstancesLaunched',
					Namespace: 'EC2',
					Timestamp: new Date(),
					Unit: 'Count',
					Value: 1, // Incrément de la métrique
				},
			],
			Namespace: 'EC2',
		};

		try {
			await cloudwatch.putMetricData(params).promise();
			console.log('Metric incremented successfully');
		} catch (error) {
			console.error('Error incrementing metric:', error);
			throw error;
		}
	}
};
