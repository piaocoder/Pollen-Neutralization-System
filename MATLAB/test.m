s = serial('COM1');  %定义串口对象
set(s,'BaudRate',9600);  %设置波特率s
fopen(s);  %打开串口对象s

interval = 10000;  %这里开始的代码很Part1里的代码类似
passo = 1;
t = 1;
x = [];
y = [];
z = [];
flag = 0;
xlabel('Count')
ylabel('Data')
while(t<interval)
    if flag == 0
    a = str2num(fgetl(s))  %用函数fget(s)从缓冲区读取串口数据，当出现终止符（换行符）停止。
    x = [x,a]; %所以在Arduino程序里要使用Serial.println()
    subplot(2,2,1);
    plot(x,'r');
    title('Temperature');
    ylabel('C');
    axis([0 inf 10 50]);
    hold on
    drawnow;
    t = t+passo;
    flag = 1;
    elseif flag == 1
      b = str2num(fgetl(s))  %用函数fget(s)从缓冲区读取串口数据，当出现终止符（换行符）停止。
       y = [y,b];
      subplot(2,2,2);
       
       plot(y,'b');
       title('Humidity');
       ylabel('%');
       axis([0 inf 0 100]);
       
       drawnow;
       flag = 2;
       t = t+passo;
    elseif flag == 2
      c = str2num(fgetl(s))  %用函数fget(s)从缓冲区读取串口数据，当出现终止符（换行符）停止。
       z = [z,c];
       subplot(2,2,3);

       plot(z,'y');
       title('Dust Ratio');
       ylabel('%');
       axis([0 inf 0 100]);
       t = t+passo;
       drawnow;
    flag = 0;
    end    
end
fclose(s);  %关闭串口对象s