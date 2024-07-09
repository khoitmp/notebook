```sh
rabbitmqctl shutdown
rabbitmqctl list_connections pid port state user vhost recv_cnt send_cnt send_pend name
rabbitmqctl close_all_connections --vhost <vhost> "Force close"
```