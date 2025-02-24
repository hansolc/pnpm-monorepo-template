const colors = {
  black: '#000000',
} as const

const theme = {
  colors,
}

export default theme
export type Theme = typeof theme
