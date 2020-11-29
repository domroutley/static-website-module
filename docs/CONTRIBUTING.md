# Contributing

## Doc generation

To generate the wiki markdown file manually I use [Terraform Docs](https://github.com/terraform-docs/terraform-docs).</br>
```bash
docker run -v $(pwd):$(pwd) -w $(pwd) quay.io/terraform-docs/terraform-docs markdown document . > wiki.md
```
