import { createGlobalStyle } from 'styled-components'
import normalize from 'styled-normalize'

const GlobalStyle = createGlobalStyle`
    ${normalize}

    * {
        box-sizing: border-box;
    }

    html {
        height: 100%;
    }

    body {
        font-size: 16px;
        height: 100%
    }
`

export default GlobalStyle
