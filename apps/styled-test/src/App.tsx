import { ThemeProvider } from 'styled-components'
import theme from './styles/theme'
import GlobalStyle from './styles/global-style'
import Button from './components/Button'

export default function App() {
  return (
    <ThemeProvider theme={theme}>
      <GlobalStyle />
      <h1>Vite + React + TypeScript</h1>
      <Button></Button>
    </ThemeProvider>
  )
}
