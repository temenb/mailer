import dotenv from 'dotenv';

dotenv.config();

export  const kafkaConfig = {
    brokers: process.env.KAFKA_BROKERS || 'kafka:9092',
    topicUserCreated: process.env.KAFKA_TOPIC_USER_CREATED || 'user.created',
    clientId: process.env.KAFKA_CLIENT_ID || 'user-producer',
};

export default kafkaConfig;
