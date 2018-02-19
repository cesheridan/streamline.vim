_Essential wheres and whens_

# _streamline.vim_

streamline.vim is a concise, minimal read of window data.

streamline.vim is **designed for multi-window tabs** when editing routinely traverses three or more windows.  

Typical **scenarios** include **research into establshed libraries** which are accessed via sets of predefined, many-windowed tabs. Scenarios also include multi-terminal tabs where the developer both edits and interacts with **multiple network terminals**.

In these contexts, the developer regularly scans entire tabs, looking for identifying data -- **signs**, i.e. _window number, buffer number,  & window id_, that enable navigation to the next window.  Every window has key data best displayed on its own status line, and the feasible maximum information per window-statusline is reduced compared to a statusline that spans the horizontal of a tab. Concision becomes more important.

Independent of these use cases, streamline.vim is designed for the developer who simply wants a _succinct statusline of quickly-acertainable window-state_.


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
|g:streamline_external_components_are_wanted| per associated _default var |||

Statusline components external to _streamline.vim_  are called from function *Statusline_end_editwin()*.  Update this (or other streamline functions) to add more statusline components.

The 2 external statuslines delivered with streamline.vim respectively require Vim plugins taglist and fugitive.


## RECOMMENDED PLUGIN
*  _**textwins.vim** A text space that encompasses terminal & editing windows_.  The navigational emphasis of _streamline.vim_ facilitates the [N], window #/id navigation in _textwins.vim_


## DISTRIBUTIONS

* http://www.vim.org/scripts/script.php?script_id=4767

* https://github.com/cesheridan/streamline.vim
