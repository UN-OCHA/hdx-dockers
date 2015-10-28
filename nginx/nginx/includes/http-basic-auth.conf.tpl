
auth_basic "HDX site";
auth_basic_user_file ${HDX_TYPE}-datapass;
allow 127.0.0.1;
allow 10.16.0.0/8;
allow 172.16.0.0/12;
allow 192.168.0.0/16;
deny all;

satisfy any;
