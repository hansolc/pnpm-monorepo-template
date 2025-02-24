import { Theme } from './theme'
import 'styled-components'

// eslint-disable-next-line @typescript-eslint/no-empty-interface
declare module 'styled-components' {
  export interface DefaultTheme extends Theme {}
}
