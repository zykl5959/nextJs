import Prompt from "@models/prompt";
import { Prisma, PrismaClient } from "@prisma/client";
import { connectToDB } from "@utils/database";

export const GET = async (request) => {
    try {
        let prisma = new PrismaClient()

        const prompts = await prisma.prompt.findMany();
        // const prompts = await Prompt.find({}).populate('creator')

        return new Response(JSON.stringify(prompts), { status: 200 })
    } catch (error) {
        return new Response("Failed to fetch all prompts", { status: 500 })
    }
} 