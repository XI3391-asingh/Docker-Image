# `awssudo`

`awssudo` let's you run `aws cli` commands assuming a role:

```bash
$ awsudo [-h|--help] [-v|--verbose] [-d|--duration-seconds] <role-arn> <sub command>
```

The script requires:

* [`jq`](https://stedolan.github.io/jq/)
* [`aws cli`](https://aws.amazon.com/cli/)
