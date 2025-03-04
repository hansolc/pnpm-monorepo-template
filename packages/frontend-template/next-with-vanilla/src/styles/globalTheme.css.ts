import { globalStyle } from '@vanilla-extract/css'
export const vars = {
  fontSize: {
    base: '16px',
  },
  media: {
    desktop: `(min-width: 1280px)`,
    tablet: `(min-width: 750px) and (max-width: 1279px)`,
    mobile: `(max-width: 749px)`,
  },
}

globalStyle('*', {
  boxSizing: 'border-box',
})

globalStyle('html', {
  height: '100%',
})

globalStyle('body', {
  fontSize: vars.fontSize.base,
  height: '100%',
})
