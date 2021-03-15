import './public-path';
import ready from '../mastodon/ready';

ready(() => {
  const image = document.querySelector('img');

  // This is how it is animated which I am disabling for now
  // image.addEventListener('mouseenter', () => {
  //   image.src = '/oops.gif';
  // });
  //
  // image.addEventListener('mouseleave', () => {
  //   image.src = '/corgi_error_final.png';
  // });
});
