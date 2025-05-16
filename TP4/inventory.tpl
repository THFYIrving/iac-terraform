[web]
%{ for ip in ips ~}
${ip}
%{ endfor ~}