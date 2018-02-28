## Adding condavision to sudoers to allow certains groups to execute hidden files

If you create the file manually (sudovim), something like the following, anyone in the group everyone can run 'sudo condavision' without bother.

```sh
Defaults secure_path = /opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
Defaults env_keep += "PYTHONPATH"
%everyone ALL=(ALL) NOPASSWD: /usr/bin/condavision
%everyone ALL=(ALL) NOPASSWD: /usr/bin/condavision3
```


If you are running inside docker, use this command:

```docker
RUN echo "Defaults secure_path = /opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
    >> /etc/sudoers.d/secureConda \
    && echo 'Defaults env_keep += "PYTHONPATH"' >> /etc/sudoers.d/secureConda \
    && echo '%everyone ALL=(ALL) NOPASSWD: /usr/bin/condavision' >> /etc/sudoers.d/secureConda \
    && echo '%everyone ALL=(ALL) NOPASSWD: /usr/bin/condavision3' >> /etc/sudoers.d/secureConda \
    && chmod 440 /etc/sudoers.d/secureConda
```
