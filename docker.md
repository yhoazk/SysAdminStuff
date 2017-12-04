# Docker 


### Test samples:

Run a Docker instance named ubuntu and add the windows workspace under `/src` dir.
```
docker run --name ubuntu -e HOST_IP=192.168.1.166 -v //%HOMEPATH%/workspace/:/src  -t -i ubuntu /bin/bash
```

