import { createVanillaExtractPlugin } from '@vanilla-extract/next-plugin'

const withVanillaExtract = createVanillaExtractPlugin()

const nextConfig = {
  /* config options here */
  reactStrictMode: true,
  images: {
    // other domain images here
    // remotePatterns: [
    //   {
    //     hostname: 'cdn.dummyjson.com',
    //   },
    // ],
  },
}

export default withVanillaExtract(nextConfig)
