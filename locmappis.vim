set spell spelllang=de

imap ,a &auml;
imap ,o &ouml;
imap ,u &uuml;
imap ,s &szlig;

imap ,eq \begin{equation*}<CR>\end{equation*}<esc>O
imap ,bbm \begin{bmatrix}<CR>\end{bmatrix}<esc>O
imap ,rr \mathbb R^{}

imap mbx \mathbb x
imap mby \mathbb y
imap smn \sum_{i=1}^N

map ,m <esc>:w<CR>:!./mkdc.sh<CR>
imap xin (x_1, x_2, \dotsc, x_n)
imap dfdx \frac{\partial f}{\partial x_i}
