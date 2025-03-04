import styled from 'styled-components'

const Page = () => {
  return <Container>This is from styled-components</Container>
}

const Container = styled.div`
  width: 100%;
  ${({ theme }) => theme.colors.black}
`

export default Page
