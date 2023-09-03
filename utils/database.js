const { PrismaClient } = require('@prisma/client') 

let isConnected = false; // track the connection

export const connectToDB = async () => {

  if(isConnected) {
    console.log('SQL is already connected');
    return;
  }


  try {
    let prisma = new PrismaClient()
    isConnected = true;
    return prisma
  } catch (error) {
    console.log(error);
  }
}

// const { PrismaClient } = require('@prisma/client')


// let prisma

// if(isConnected) {
//     console.log('MongoDB is already connected');
//     return;
//   }
// try {
//   prisma = new PrismaClient()
// } catch (error) {
  
// }

// return prisma