import Feed from "@components/Feed";

const Home = () => (
  <section className='w-full flex-center flex-col'>
    <h1 className='head_text text-center'>
      Discover & Share
      <br className='max-md:hidden' />
      <span className='orange_gradient text-center'> Yi's New Life</span>
    </h1>
    <p className='desc text-center'>
      Here is Yi's personal world (supported by Next.JS)
    </p>

    <Feed />
  </section>
);

export default Home;
