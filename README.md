# Dockerfile: jjaros/hugo-pipeline-base

## Introduction
Dockerfile for build Docker image that may be used for CI pipeline. 
Because of that, they are installed some tools that may be useful during your CI process. 
E.g. `yuicompressor` for compression of static web page resources 
or `lftp` for transfer built web page to shared hosting.  

## Usage examples

### Usage in Bitbucket pipeline

```yaml
image: jjaros/hugo-pipeline-base:<required_tag>

pipelines:
  custom:
    build-and-deploy:
      - step:
          script:
            # build web page
            - hugo
            # compress/minify static resources (CSS and JS)
            - yuicompressor public/css/custom.css > public/css/custom.min.css
            - yuicompressor public/js/custom.js > public/js/custom.min.js
            # don't transfer non-minify files
            - find public/css/* ! -name '*min*' -delete
            - find public/js/* ! -name '*min*' -delete
            # display tree of files that will be transfered to shared hosting (only for informational purpose)
            - tree -a public/
            # deploy files to shared hosting (from ./public to $FTP_BASE_DIRECTORY/target-dir)
            - lftp -e "mirror -v --delete-first -R public $FTP_BASE_DIRECTORY/target-dir" -u $FTP_USERNAME,$FTP_PASSWORD $FTP_HOST
```

### Pull image from Docker Hub
```
docker pull jjaros/hugo-pipeline-base
```

### Build Dockerfile locally
```
docker build -t <img_name>:<tag_name> --no-cache .
```

## References
* Hugo framework - [gohugo.io/](https://gohugo.io/)
* built image on Docker hub - [jjaros/hugo-pipeline-base](https://hub.docker.com/r/jjaros/hugo-pipeline-base)
