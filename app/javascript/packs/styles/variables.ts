// Breakpoints from https://bulma.io/documentation/overview/responsiveness/
const mobile = 768;
const tablet = 769;
const desktop = 1024;

export const media = {
  mobile: `@media (max-width: ${mobile}px)`,
  tablet: `@media (min-width: ${tablet}px)`,
  desktop: `@media (min-width: ${desktop}px)`,
};
