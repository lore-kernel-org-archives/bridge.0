Message-ID: <BAY131-F36EA0C0FFE54BCDC89420BE2C60@phx.gbl>
In-Reply-To: <50F73B338A7FD943B7937BBCF99BFBDE01BF08F8@mail.sofaware.com>
From: "saravanan chanemouganandam" <saravanan_sprt@hotmail.com>
Date: Fri, 29 Dec 2006 14:50:14 +0530
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1167384023-28885-92"
Subject: Re: [Bridge] bridge-utils compilation bug
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: UriS@sofaware.com, bridge@osdl.org

This is a multi-part message in MIME format...

------------=_1167384023-28885-92
Content-Type: text/html; format=flowed
Content-Disposition: inline

<html><div DEFANGED_style="background-color:"><DIV class=RTE>
<P>Hi Uri,</P>
<P>I too fasced the same problem in cross compiling bridge-utils-1.2 for my target Xscale&nbsp;on x86 host development machin&nbsp;. After download and untar , first I couldn't find ./configure file except ./configure.in . Simple make on x86 machine throws error like "No rule to make target" etc and the following error </P>
<P>sara:/schane/bridge-utils-1.2# ./configure.in<BR>./configure.in: line 1: dnl: command not found<BR>./configure.in: line 2: syntax error near unexpected token `bridge-utils,'<BR>./configure.in: line 2: `AC_INIT(bridge-utils, 1.2)'<BR>sara:/schane/bridge-utils-1.2#</P>
<DIV class=RTE>&nbsp;</DIV>
<DIV class=RTE>then I tried to do autoconf and got </DIV>
<DIV class=RTE><BR>sara:/schane/bridge-utils-1.2# autoconf<BR>autoconf: Undefined macros:<BR>configure.in:3:AC_CONFIG_HEADERS(libbridge/config.h)<BR>sara:/schane/bridge-utils-1.2#</DIV>
<P>I couldn't find enough information in the README or /docs for how to compile / cross compile the tools. If you find any information cld you share it. &nbsp;<BR></P>
<P>1. how to compile on native x86 machine.</P>
<P>2. how to cross compile for other target by hand edit in make file.</P>
<P>Thanks</P>
<P>Sara<BR></P></DIV>
<DIV></DIV>
<BLOCKQUOTE DEFANGED_style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #a0c6e5 2px solid; MARGIN-RIGHT: 0px"><FONT DEFANGED_style="FONT-SIZE: 11px; FONT-FAMILY: tahoma,sans-serif">
<HR color=#a0c6e5 SIZE=1>

<DIV></DIV>From:&nbsp;&nbsp;<I>"Uri Simchoni" &lt;UriS@sofaware.com&gt;</I><BR>To:&nbsp;&nbsp;<I>&lt;bridge@osdl.org&gt;</I><BR>Subject:&nbsp;&nbsp;<I>[Bridge] bridge-utils compilation bug</I><BR>Date:&nbsp;&nbsp;<I>Thu, 28 Dec 2006 12:16:17 +0200</I><BR>&gt;Hi,<BR>&gt;<BR>&gt;I tried to cross-compile bridge-utils, and think I have found a bug in<BR>&gt;Makefile.in:<BR>&gt;<BR>&gt;--- /cygdrive/d/sources/bridge-utils-1.1/libbridge/Makefile.in<BR>&gt;2004-06-02 20:38:20.000000000 +0300<BR>&gt;+++ libbridge/Makefile.in&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2006-12-28 11:56:56.576468700 +0200<BR>&gt;@@ -5,7 +5,8 @@<BR>&gt;&nbsp;&nbsp;RANLIB=@RANLIB@<BR>&gt;<BR>&gt;&nbsp;&nbsp;CC=@CC@<BR>&gt;-CFLAGS = -Wall -g $(KERNEL_HEADERS)<BR>&gt;+CFLAGS = -Wall 
@CFLAGS@<BR>&gt;+INCLUDE=$(KERNEL_HEADERS)<BR>&gt;<BR>&gt;&nbsp;&nbsp;prefix=@prefix@<BR>&gt;&nbsp;&nbsp;exec_prefix=@exec_prefix@<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt;Thanks,<BR>&gt;Uri.<BR>&gt;<BR>&gt;_______________________________________________<BR>&gt;Bridge mailing list<BR>&gt;Bridge@lists.osdl.org<BR>&gt;https://lists.osdl.org/mailman/listinfo/bridge<BR></FONT></BLOCKQUOTE></div><br clear=all><hr>Get up-to-date with movies, music and TV. <a href="http://g.msn.com/8HMBENIN/2746??PS=47575" target="_top">Its happening on MSN Entertainment</a> </html>


------------=_1167384023-28885-92--
