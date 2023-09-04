import Prompt from "@models/prompt";
import prisma from "@app/prismaClient";
import { connectToDB } from "@utils/database";

export const GET = async (request) => {
    try {
        const prompts = await prisma.prompt.findMany();
        // const prompts = await Prompt.find({}).populate('creator')

        return new Response(JSON.stringify(prompts), { status: 200 })
    } catch (error) {
        return new Response("Failed to fetch all prompts", { status: 500 })
    }
} 