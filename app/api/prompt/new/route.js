import { PrismaClient } from "@prisma/client";

export const POST = async (request) => {
    const { userId, prompt, tag } = await request.json();

    console.log(prompt);
    console.log(userId);

    try {
        // await connectToDB();
        // const newPrompt = new Prompt({ creator: userId, prompt, tag });
        // console.log(newPrompt)
        // await newPrompt.save();
        // return new Response(JSON.stringify(newPrompt), { status: 201 })

        let prisma = new PrismaClient()

        const prompt2 = await prisma.prompt.create({
            data: {
              creatorId: userId,
              prompt: prompt,
              tag: tag
            },
          })
          return new Response(JSON.stringify(prompt2), { status: 201 })
    } catch (error) {
        console.warn(error)
        return new Response("Failed to create a new prompt", { status: 500 });
    }
}
