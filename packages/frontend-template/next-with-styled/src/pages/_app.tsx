import GlobalStyle from '@/styles/theme/GlobalStyle'
import StyledComponentsRegistry from '../lib/registry'
import { ThemeProvider } from 'styled-components'
import { theme } from '@/styles/theme/theme'
import { AppProps } from 'next/app'

export default function MyApp({ Component, pageProps }: AppProps) {
  return (
    <StyledComponentsRegistry>
      <GlobalStyle />
      <ThemeProvider theme={theme}>
        <Component {...pageProps} />
      </ThemeProvider>
    </StyledComponentsRegistry>
  )
}
