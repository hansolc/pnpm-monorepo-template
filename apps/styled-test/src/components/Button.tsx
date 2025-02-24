import styled from 'styled-components'

const Button = () => {
  return <StyledButton>this is Styled components button</StyledButton>
}

export default Button

const StyledButton = styled.button`
  width: 100px;
  height: 100px;
  color: white;
  background-color: ${({ theme }) => theme.colors.black};
`
