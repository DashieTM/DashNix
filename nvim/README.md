# List of keymaps

## Space as leader

## Debugging
| key | Description               |
| --- | ------------------------- |
| F5  | toggle breakpoint         |
| F6  | step over breakpoint      |
| F7  | step into breakpoint      |
| F8  | start debugging           |
| F9  | continue from breakpoint  |
| F10 | close debug UI            |

## Nerd Tree
| key | Description               |
| --- | ------------------------- |
| f   |toggle open                |
| a   |create new file            |
| d   |remove file                |
| r   |rename file                |
| y   |copy name                  |
| Y   |copy path                  |
| x   |cut file                   |
| c   |copy file                  |
| p   |paste file                 |
| f   |filter (inside nvim tree)  |
| E   |expand all folders         |
| W   |collapse all folders       |

## buffer switching
| key | Description               |
| --- | ------------------------- |
| F1  | next buffer (cycles)      |
| F2  | previous buffer (cycles)  |

## formatting
| key | Description               |
| --- | ------------------------- |
| F4  | format this file          |

## telescope
| key | Description               |
| --- | ------------------------- |
| ff  | find files                |
| fg  | live ripgrep              |
| fb  | find buffers              |
| fh  | help for functions etc    |
| fp  | find projects             |
| fb  | file browser              |

### telescope git
| key        | Description               |
| ---------- | ------------------------- |
| <leader>gq | show commits              |
| <leader>gw | show commits with diff    |
| <leader>ge | show branches             | 
| <leader>gr | show git status           |
| <leader>ga | show git stash            | 

### project telescope
<table> <tr> <th> normal mode </th> <th> insert mode </th></tr>
<tr> <td>

| key | Description                       |
| --- | --------------------------------- |
|  d  | delete project                    |
|  r  | rename project                    |
|  c  | create project                    |
|  s  | search files in project           |
|  b  | browse files in project           |
|  w  | change directory to project       |
|  R  | recently opened files in project  |
|  f  | find file within project          |
</td> <td>

| key      | Description                       |
| -------- | --------------------------------- |
| Ctrl + d | delete project                    |
| Ctrl + v | rename project                    |
| Ctrl + a | create project                    |
| Ctrl + s | search files in project           |
| Ctrl + b | browse files in project           |
| Ctrl + l | change directory to project       |
| Ctrl + r | recently opened files in project  |
| Ctrl + f | find file within project          |

</td> </tr> </table>


## toggletrouble
| key      | Description               |
| -------- | ------------------------- |
| Ctrl + f | show errors and warnings  |

## cmp
Note, these require the cmp list view to be open to do anything!
| key         | Description                                               |
| ----------- | --------------------------------------------------------- |
| Ctrl + b    | scroll docs up                                            |
| Ctrl + f    | scroll docs down                                          |
| Ctrl + e    | cancel cmp                                                |
| Enter       | write selected suggestion (does nothing if not selected)  |
| Tab         |scroll down through suggestion list                        |
| Shift + Tab | scroll up through suggestion list                         |

## LSP 
| key         |  Description           |
| ----------- | ---------------------- |
|  Leader + a | go to declaration      |
|  Leader + s | go to definition       |
|  Leader + d | go to type definitions |
|  Leader + f | go to references       |
|  Leader + q | execute code actions   |
|  Leader + w | signature help         |
|  Leader + e | hover                  |
|  Leader + r | rename                 |

## snippets
These require you to be inside a snippet!
| key      | Description               |
| -------- | ------------------------- |
| Ctrl + j | jump to next entry        |
| Ctrl + k | jump to previous entry    |

## Leap
| key      | Description                                            |
| -------- | ------------------------------------------------------ |
| s        | followed by 2 other characters and the marker to jump  |

## Dashboard
only available on dashboard
| key | Description               |
| --- | ------------------------- |
|  f  | file                      |
|  e  | new file                  |
|  p  | find project              |
|  r  | recently used files       |
|  t  | find text                 |
|  c  | open config               |
|  q  | quit                      |
