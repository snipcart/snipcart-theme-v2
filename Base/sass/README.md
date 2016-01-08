# SASS guide

- Important: use BEM methodology
	- Prefix all classes with *snip-* as we shall avoid conflict with the user's stylesheet
	- For *Elements* use __
	- For *Modifiers* use --
	- Try to prevent nested *Elements* or *Modifiers* (e.g `.snip-blockName__elementName__nestedElementName`)

- Alphabetize declarations (it's not the smarter way, but it's the easier way)
- Indent all block content
- Use a semicolon after every declaration
- Use a space after a property name’s colon
- Use a space between the last selector and the declaration block
- Separate selectors and declarations by new lines
- Separate rules by new lines
- Use double quotation marks for attribute selectors and property values
- Do not use quotation marks in URI values (url())

- Use shorthand properties where possible
- Omit unit specification after *0* values
- Omit leading *0*s in values
- Use 3 character hexadecimal notation where possible