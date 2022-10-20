# simple TODO List



### **ADD Command :**
this command add new task to task list

use **-t | --title** for Set TASK Title

use **-p | --priority** for Set TASK Priority (default: L)

```bash
 ./todo.sh add -t "TASK Title" -p "TASK Priority (H|M|L)"
 ```
<hr>

### **List Command :**
this command show task list
```bash
 ./todo.sh list
 ```
<hr>

### **Clear Command :**
this command clear task list
```bash
 ./todo.sh clear
 ```
 <hr>

### **Find command :**
This command lists tasks that have "search Title" in their title
```bash
./todo.sh find "search Title"
```
<hr>

### **Done command :**
This command done task by task ID
```bash
./todo.sh done [Task ID]
```