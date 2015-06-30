# DuraSpace XML package for the Atom.io editor

Reformats EndNote XML to work with DuraSpace/Fedora digital repository

This is a very simple Atom.io package to remformat XML from EndNote so that
it can be imported and displayed correctly in DuraSpace/Fedora

It performs the following conversions

* `20uu9999` reformated to todays date in YYYYMMDD format
* `&#xA9;` changed to `&amp;#0169;1
* `&#x201C;`,`&#x201D;`,`&#x2019;`,`&#x2018;` changed to `'`
* `&#x2013;`,`&#x2014;` changed to `-`
* `&#xD;`,`&#x2009` changed to a space ` `
* Double spaces removed
* Opening and closing tags >< cleaned up if incrrect spacing is present
