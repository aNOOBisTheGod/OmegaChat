# Here is the guide for this application how does the theme made.

### Because flutter doesn't allow to extend ThemeData class, we should use standard ThemeData to manage themes. That's why we will use:

## Widget backgrounds:
<ul>
<li>scaffold - scaffoldBackgroundColor
<li>drawer - drawerTheme.backgroundColor
<li>all buttons - accentcolor (may be removed soon)
<li>appbar - appBarTheme.backgroundColor
<li>message sent - primaryColorDark
<li>message received - primaryColorLight
<li>text field - primaryColor
<li>user card - cardColor
</ul>

## Text/Icons colors:
TEXT THEME...
<ul>
<li>scaffold - bodyText1
<li>all buttons - bodyText2
<li>user card - displayMedium
<li>message received - bodyText2
<li>message sent - bodyText2
<li>appbar - bodyText2
<li>drawer - bodyText2
<ul>
