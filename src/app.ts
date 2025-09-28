import dotenv from 'dotenv';
import * as grpc from '@grpc/grpc-js';

dotenv.config();

const server = new grpc.Server();

export default server;

