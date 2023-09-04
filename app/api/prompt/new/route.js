import prisma from "@app/prismaClient";

export const POST = async (request) => {
    const { userId, prompt, tag } = await request.json();

    console.log(prompt);
    console.log(userId);

    try {

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
