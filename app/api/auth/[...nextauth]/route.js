import NextAuth from 'next-auth';
import AzureADProvider from "next-auth/providers/azure-ad";
const { PrismaClient } = require('@prisma/client') 

const handler = NextAuth({
  providers: [
    AzureADProvider({
      clientId: process.env.AZURE_AD_CLIENT_ID,
      clientSecret: process.env.AZURE_AD_CLIENT_SECRET,
      tenantId: process.env.AZURE_AD_TENANT_ID,
    })
  ],
  callbacks: {
    async signIn({ account, profile, user, credentials }) {
      try {
        let prisma = new PrismaClient()

        // check if user already exists
        const user = await prisma.profile.findUnique({
          where: {
            userId : profile.email
          },
        })

        // if not, create a new document and save user in MongoDB
        if (!user) {
          const user = await prisma.profile.create({
            data: {
              userId: profile.email
            },
          })
        }
        return true
      } catch (error) {
        console.log("Error checking if user exists: ", error.message);
        return false
      }
    }
  }
})

export { handler as GET, handler as POST }
