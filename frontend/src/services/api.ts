// import { AptosClient } from 'aptos';

// const client = new AptosClient("https://fullnode.testnet.aptoslabs.com");

export const getStudent = async (id: number) => {
  // Simulate fetching student from the blockchain
  return {
    id: id,
    name: 'John Doe',
    enrolled: true,
  };
};
