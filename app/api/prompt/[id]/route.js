import prisma from "@app/prismaClient";

export const GET = async (request, { params }) => {
    try {
        console.log(params)

        // const prompt = await Prompt.findById(params.id).populate("creator")
        // By unique identifier
        const myid = +params.id;
        const prompt = await prisma.prompt.findUnique({
            where: {
                id: myid,
            },
        })
        // const prompt = await prisma.prompt.findUnique(params.id)
        if (!prompt) return new Response("Prompt Not Found", { status: 404 });
        console.log(prompt);
        return new Response(JSON.stringify(prompt), { status: 200 })

    } catch (error) {
        console.log(error);
        return new Response("Internal Server Error", { status: 500 });
    }
}

export const PATCH = async (request, { params }) => {
    const { prompt2, tag } = await request.json();
    
    try {
        const existingPrompt = await prisma.prompt.update({
            where:{
                id: +params.id
            },
            data: {
                prompt: prompt2,
                tag: tag
            },
        })
        // console.log(tag2);
        // Find the existing prompt by ID
        // const existingPrompt = await Prompt.findById(params.id);

        if (!existingPrompt) {
            return new Response("Prompt not found", { status: 404 });
        }

        // Update the prompt with new data
        // existingPrompt.prompt = prompt;
        // existingPrompt.tag = tag;

        // await existingPrompt.save();
        console.log(existingPrompt);
        return new Response("Successfully updated the Prompts", { status: 200 });
    } catch (error) {
        console.log(error);
        return new Response("Error Updating Prompt", { status: 500 });
    }
};

export const DELETE = async (request, { params }) => {
    try {
        await connectToDB();

        // Find the prompt by ID and remove it
        await Prompt.findByIdAndRemove(params.id);

        return new Response("Prompt deleted successfully", { status: 200 });
    } catch (error) {
        return new Response("Error deleting prompt", { status: 500 });
    }
};
