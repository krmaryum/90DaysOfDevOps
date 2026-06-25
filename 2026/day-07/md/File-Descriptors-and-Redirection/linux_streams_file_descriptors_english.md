# Linux Standard Streams and File Descriptors

## What is a Stream?
A stream is a flow of data between a Linux command and the terminal or another command.

Linux uses three standard streams:

| Number | Name | Purpose |
|----------|--------|--------|
| 0 | stdin | Standard Input |
| 1 | stdout | Standard Output |
| 2 | stderr | Standard Error |

## What is stdin?
stdin is the input stream.

Example:
```bash
cat
```

## What is stdout?
stdout is the normal output stream.

Example:
```bash
ls
```

## What is stderr?
stderr is the error output stream.

Example:
```bash
ls wrongfile
```

## File Descriptors

Linux identifies streams using numbers:

```text
0 = stdin
1 = stdout
2 = stderr
```

## Redirection Examples

Redirect stdout:

```bash
ls > output.txt
```

Redirect stderr:

```bash
ls wrongfile 2> error.txt
```

Hide stdout:

```bash
command > /dev/null
```

Hide stderr:

```bash
command 2> /dev/null
```

Hide both:

```bash
command > /dev/null 2>&1
```

## Summary

- stdin = FD 0
- stdout = FD 1
- stderr = FD 2

Stream = data flow
File Descriptor = number used to identify the stream
