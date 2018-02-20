_Essential wheres and whens_

# _streamline.vim_

streamline.vim is a concise, minimal read of window data.

streamline.vim is **designed for multi-window tabs** when editing routinely traverses more than three windows.  

**Scenarios** include 
* _**Research into established libraries** which are accessed via sets of predefined, many-windowed tabs_ 
* _**Multi-terminal tabs** where the developer both edits and interacts with multiple network terminals_

In these contexts, the developer regularly scans entire tabs, looking for identifying data -- **signs**, i.e. _window number, buffer number,  & window id_, that enable navigation to the next window.  Every window has key data best displayed on its own status line, and the feasible maximum information per window-statusline is reduced compared to a statusline that spans the horizontal of a tab. Concision becomes more important.

Independent of these use cases, streamline.vim is designed for the developer who simply wants a _succinct statusline of quickly-ascertainable window-state_.


##### Terminal Modes TN & TJ
_streamline.vim_ brings Vim terminals into the familiar Vim representation of modal state -- **N & I**, Normal and Insert modes.

_This means:_
 
* term_getstatus() "running,normal" => "**TN**" i.e. TERMINAL-Normal mode
* term_getstatus() "running"        => "**TJ**" i.e. TERMINAL-Job mode

##### More ?
As described in the Global Vars section, if your definition of minimal can sustain just a little bit more, you can configure streamline.vim to add git branch and Tlist information, as well as anything else that remains within your own sense of maximal minimal.
___

## CONFIGURATION
#### GLOBAL VARS

| Global | Default |  Description | 
| :--- |  :--- | :--- | 
|g:streamline_external_components_are_wanted_default |'N' | If 'Y', statusline includes Tlist_Get_Tagname_By_Line() & fugitive#statusline() |
|g:streamline_external_components_are_wanted| per associated _default var ||
|g:streamline_timestamp_is_wanted_default|'Y' | 'Y' for timestamp display  |
|g:streamline_timestamp_is_wanted|  per associaed _default var |||

Statusline components external to _streamline.vim_  are called from function *Statusline_end_editwin()*.  Update this (or other plugin functions) to add more statusline components.

The 2 external statuslines available with _streamline.vim_ require Vim plugins _taglist_ and _fugitive_, respectively.


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
*  _**textwins.vim** A text space that encompasses terminal & editing windows_.  The navigational emphasis of _streamline.vim_ facilitates the \[N\], window #/id navigation in _textwins.vim_

*  _**tabwins.vim** 1 Command for custom window structures that persist._  This plugin produce the kinds of multi-window structures for which _streamline.vim_ is optimal.

## DISTRIBUTION
* http://www.vim.org/scripts/script.php?script_id=4767

## DOCUMENTATION
Documentation is at the below URL, and is not packaged with plugin code.

## DEPLOYMENT
_streamline.vim_ has no dependencies and should load for any established Vim package manager, provided the package manager does not require special hooks in plugin code.  
