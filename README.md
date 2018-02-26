_Essential wares, to get there_ / Charles Sheridan

# _streamline.vim_

_streamline.vim_ is a concise, minimal read of window data, and a set of maps to help you navigate.

_streamline.vim_ is **designed for multi-window tabs** when editing routinely traverses more than three windows.  

When, for example, Vim is in the lower left of a 9 window tab, and you want to go to a window in the middle far-right of the tab, _relative jkl; etc navigation may offer no direct route_, because the origin-destination windows are not adjacent.  

Here, the fastest route is to navigate by the window number of the destination, its address.  

Alternative approaches are just _too much thinking, or are cumbersome, if one elects to chase a mouse_.

**Use Cases** include 
* **Research into established libraries**, viewed from galleries of carefully-arranged, many-windowed tabs
* **Multiple-terminal sessons** where the developer both edits and interacts with static or varying sets of network terminals
* **File system scans** for quick assessment of what is and is not present in the core directories of an OS instance

The developer repeatedly scans entire tabs, looking for identifying data -- **signs**, mainly window number, that enable navigation to a window of interest.  Every window has its own key data, best displayed on its own status line, and the feasible maximum information per window-statusline is reduced compared to a statusline that spans the horizontal of a tab. _Concision gains importance._

Independent of these use cases, _streamline.vim_ is designed for the developer who simply wants a _succinct and visually-quiet statusline of quickly-ascertainable window-state_.

##### TERMINAL MODES TN & TJ
_streamline.vim_ brings Vim terminals into the familiar Vim representation of modal state -- **N & I**, Normal and Insert modes.

_This means:_

| term_getstatus()  | Mode | statusline.vim|
| :--- | :--- | :---: | 
|running,normal | TERMINAL-Normal |**TN**|
|running | TERMINAL-Job |**TJ**|

##### MOTION MAPS
Navigation relies on both signs and maps.  So _streamline.vim_ also provides maps.

| Default nmap Name |  Description | 
| :--- | :--- | 
|< Leader >< Leader >1 |Go to the specified window number|
|< Leader >< Leader >2 |[same]|
|< Leader >< Leader >3 |[same]|
|< Leader >< Leader >4  | [same] |
|...|...|
|< Leader >< Leader >100|[same]|

< Leader >< Leader ># is **default** form rather than `gwN` on the premiss that it's ergonomically faster.  The developer may of course disagree, and redraw the maps.  The default uses 3 chars to (likely) avoid trampling over existing maps -- **,N** is suggested for when that is not an issue.

See 'GLOBAL VARS' re map configs.

##### More ?
As described in 'GLOBAL VARS,' if your definition of minimal can sustain just a little bit more, you can configure _streamline.vim_ to add git branch and Tlist information, as well as anything else that remains within your own sense of maximal minimal.
___

## CONFIGURATION
#### GLOBAL VARS

| Global | Default |  Description | 
| :--- |  :--- | :--- | 
|g:streamline_highest_window_map_number| 100| Navigation map w/ highest window number  |
|g:streamline_map_name_prefix|< Leader>< Leader> | per var name  |
|g:streamline_external_components_are_wanted_default |'N' | If 'Y', statusline includes Tlist_Get_Tagname_By_Line() & fugitive#statusline() |
|g:streamline_external_components_are_wanted| per associated _default var ||
|g:streamline_timestamp_is_wanted_default|'Y' | 'Y' for timestamp display  |
|g:streamline_timestamp_is_wanted|  per associated _default var |||

Statusline components external to _streamline.vim_  are called from function **Statusline_end_editwin()**.  Update this (or other plugin functions) to add more statusline components.

The 2 external statuslines available with _streamline.vim_ **require Vim plugins _taglist_ and _fugitive_**, respectively.


## SCREENSHOTS

[n]: ./doc/images/streamline.n.jpg?raw=true  "n"
![alt text][n]

[tn]: ./doc/images/streamline.tn.jpg?raw=true  "tn"
![alt text][tn]

_**Statusline left to right:**_ Window#-Buffer# Mode Line#/Total_Lines #Columns WindowID FileName TimeStamp

TimeStamps are omitted from terminal windows.

[8windows]: ./doc/images/streamline.8windows.jpg?raw=true  "8windows"
![alt text][8windows]
___

## RELATED PLUGINS
*  _**tabwins.vim** 1 Command for custom window structures that persist._  Produces the kinds of multi-window structures for which _streamline.vim_ is optimal.
  https://raw.githubusercontent.com/cesheridan/tabwins.vim/master/README.md

*  _**textwins.vim** Windows that text_.  The navigational signage in _streamline.vim_ facilitates the \[N\], window #/id navigation in _textwins.vim._ 
  https://raw.githubusercontent.com/cesheridan/textwins.vim/master/README.md

## DISTRIBUTION
* https://vim.sourceforge.io/scripts/script.php?script_id=5660

## DOCUMENTATION
At the below URL, and not packaged with plugin code.
* https://raw.githubusercontent.com/cesheridan/streamline.vim/master/README.md

Also see frequent in-line comments re design rationale.

## DEPLOYMENT
* This plugin, in its default configuration, has no dependencies on other plugins and should load for any established Vim package manager, provided the package manager does not require special hooks in plugin code.  

## LICENSE 
License: GPL (Gnu Public License) version 3
Copyright (c) 2018 Charles E. Sheridan
