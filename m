Message-Id: <200403120517.i2C5Hj5q006074@fire-2.osdl.org>
From: "=?GB2312?Q?=C9=EA=EF=BF=EE=F8?=" <skkwish@huadun.com.cn>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1079068672-17740-810"
Date: Fri, 12 Mar 2004 13:17:47 +0800
Subject: [Bridge] (no subject)
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "bridge@osdl.org" <bridge@osdl.org>

This is a multi-part message in MIME format...

------------=_1079068672-17740-810
Content-Type: multipart/alternative;
	boundary="=====002_Dragon738264534364_====="
Content-Transfer-Encoding: binary

This is a multi-part message in MIME format...

--=====002_Dragon738264534364_=====
Content-Type: text/plain;
      charset="GB2312"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

 hi!
 My linux is 2.4.20, I have two Interl netcard, driver is e100.o, when I add eth0 and eth1 to br0, all is right, then I remove eth0 or eth1 from br0, then add, remove,add. repeat some times, my kernel panic, screen show dev.c: call skb_checksum_help(): 947 conduce this problem.

    skb_checksum_help() as follows:

struct sk_buff * skb_checksum_help(struct sk_buff *skb)
{
 int offset;
 unsigned int csum;
 offset = skb->h.raw - skb->data;
 if (offset > (int)skb->len)
  BUG();
 csum = skb_checksum(skb, offset, skb->len-offset, 0);
 offset = skb->tail - skb->h.raw;
 if (offset <= 0)
  BUG();
 if (skb->csum+2 > offset)
  BUG();    // this is the 947 line in dev.c    
 *(u16*)(skb->h.raw + skb->csum) = csum_fold(csum);
 skb->ip_summed = CHECKSUM_NONE;
 return skb;
} 

 
     before kernel panic,somtimes, when I use ifconfig config eth1 ip address,appear a error: Multicast setup failed, then my compute can't ping any other host. I find "Multicast setup failed" in e100's src(e100_main.c).
     while I replace eepro100.o with e100.o, all is right, no panic, and no "Multicast setup failed".
    but I want use e100.o, Could you tell me how to resolve this problem?
    
    thanks!

                    Kunkai Shen

                   E-Mail: skkwish@263.net

--=====002_Dragon738264534364_=====
Content-Type: text/html;
      charset="GB2312"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dgb2312">
<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR></HEAD>
<BODY>
<TABLE height=3D"100%" cellSpacing=3D0 cellPadding=3D0 width=3D"90%" border=
=3D0>
  <TBODY>
  <TR>
    <TD vAlign=3Dtop align=3Dleft>
      <DIV>
      <DIV>
      <TABLE height=3D"96%" cellSpacing=3D0 cellPadding=3D0 width=3D"96%" b=
order=3D0>
        <TBODY>
        <TR>
          <TD vAlign=3Dtop align=3Dleft height=3D30><FONT DEFANGED_face=3D"=
=CB=CE=CC=E5">
            <TABLE DEFANGED_style=3D"WIDTH: 458px; HEIGHT: 389px" height=3D=
"100%"
            cellSpacing=3D0 cellPadding=3D0 width=3D"90%" border=3D0>
              <TBODY>
              <TR>
                <TD vAlign=3Dtop align=3Dleft>
                  <DIV><FONT size=3D2><FONT DEFANGED_face=3D"=CB=CE=CC=E5">=
<SPAN
                  id=3D_FoxToName>&nbsp;hi!</SPAN></FONT></FONT></DIV>
                  <DIV><FONT size=3D2><FONT DEFANGED_face=3D"=CB=CE=CC=E5">=
<SPAN>&nbsp;My linux is
                  2.4.20, I have two&nbsp;Interl netcard, driver is
                  e100.o,&nbsp;when I add eth0 and eth1 to br0, all is righ=
t,
                  then I remove eth0 or eth1 from br0, then add, remove,add.
                  repeat some times, my kernel panic, screen show dev.c: ca=
ll
                  skb_checksum_help(): 947&nbsp;conduce this
                  problem.</SPAN></FONT></FONT></DIV>
                  <DIV><FONT size=3D2><FONT
                  DEFANGED_face=3D"=CB=CE=CC=E5"><SPAN></SPAN></FONT></FONT=
>&nbsp;</DIV>
                  <DIV><FONT size=3D2><FONT DEFANGED_face=3D"=CB=CE=CC=E5">=
<SPAN>&nbsp;&nbsp;&nbsp;
                  skb_checksum_help() as follows:</SPAN></FONT></FONT></DIV>
                  <DIV><FONT size=3D2><FONT
                  DEFANGED_face=3D"=CB=CE=CC=E5"><SPAN></SPAN></FONT></FONT=
>&nbsp;</DIV>
                  <DIV><FONT size=3D2><FONT DEFANGED_face=3D"=CB=CE=CC=E5">=
<SPAN>struct sk_buff *
                  skb_checksum_help(struct sk_buff *skb)<BR>{<BR>&nbsp;int
                  offset;<BR>&nbsp;unsigned int csum;</SPAN></FONT></FONT><=
/DIV>
                  <DIV><FONT size=3D2><FONT DEFANGED_face=3D"=CB=CE=CC=E5">=
<SPAN>&nbsp;offset =3D
                  skb-&gt;h.raw - skb-&gt;data;<BR>&nbsp;if (offset &gt;
                  (int)skb-&gt;len)<BR>&nbsp;&nbsp;BUG();<BR>&nbsp;csum =3D
                  skb_checksum(skb, offset, skb-&gt;len-offset,
                  0);</SPAN></FONT></FONT></DIV>
                  <DIV><FONT size=3D2><FONT DEFANGED_face=3D"=CB=CE=CC=E5">=
<SPAN>&nbsp;offset =3D
                  skb-&gt;tail - skb-&gt;h.raw;<BR>&nbsp;if (offset &lt;=3D
                  0)<BR>&nbsp;&nbsp;BUG();<BR>&nbsp;if (skb-&gt;csum+2 &gt;
                  offset)<BR>&nbsp;&nbsp;BUG();&nbsp;&nbsp;&nbsp; <STRONG><=
FONT
                  size=3D4>// this is the 947 line in
                  dev.c</FONT></STRONG>&nbsp;&nbsp;&nbsp;
                  </SPAN></FONT></FONT></DIV>
                  <DIV><FONT size=3D2><FONT
                  DEFANGED_face=3D"=CB=CE=CC=E5"><SPAN>&nbsp;*(u16*)(skb-&g=
t;h.raw + skb-&gt;csum) =3D
                  csum_fold(csum);<BR>&nbsp;skb-&gt;ip_summed =3D
                  CHECKSUM_NONE;<BR>&nbsp;return
                  skb;<BR>}&nbsp;</SPAN></FONT></FONT></DIV>
                  <DIV><FONT size=3D2><FONT
                  DEFANGED_face=3D"=CB=CE=CC=E5"><SPAN></SPAN></FONT></FONT=
>&nbsp;</DIV>
                  <DIV><FONT size=3D2><FONT
                  DEFANGED_face=3D"=CB=CE=CC=E5"><SPAN>&nbsp;</SPAN></FONT>=
</FONT></DIV>
                  <DIV><FONT size=3D2><FONT DEFANGED_face=3D"=CB=CE=CC=E5">=
<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;
                  before kernel panic,somtimes, when I use ifconfig config =
eth1
                  ip address,</SPAN></FONT></FONT><FONT size=3D2><FONT
                  DEFANGED_face=3D"=CB=CE=CC=E5"><SPAN>appear a error:&nbsp=
;Multicast setup failed,
                  then&nbsp;my&nbsp;compute&nbsp;can't ping any other
                  host.&nbsp;I find "Multicast setup failed" in e100's
                  src(e100_main.c).</SPAN></FONT></FONT></DIV>
                  <DIV><FONT size=3D2><FONT DEFANGED_face=3D"=CB=CE=CC=E5">=
<SPAN>&nbsp;&nbsp;&nbsp;&nbsp;
                  while I replace eepro100.o with e100.o, all is right, no
                  panic, and no "Multicast setup
                  failed".</SPAN></FONT></FONT></DIV>
                  <DIV><FONT size=3D2><FONT DEFANGED_face=3D"=CB=CE=CC=E5">=
<SPAN>&nbsp;&nbsp;&nbsp; but I
                  want use e100.o, Could you tell me how to resolve this
                  problem?</SPAN></FONT></FONT></DIV>
                  <DIV><FONT size=3D2><FONT DEFANGED_face=3D"=CB=CE=CC=E5">=
<SPAN>&nbsp;&nbsp;&nbsp;
                  </SPAN></FONT></FONT></DIV>
                  <DIV><FONT size=3D2><FONT DEFANGED_face=3D"=CB=CE=CC=E5">=
<SPAN>&nbsp;&nbsp;&nbsp;
                  thanks!</SPAN></FONT></FONT></DIV>
                  <DIV><FONT size=3D2><FONT
                  DEFANGED_face=3D"=CB=CE=CC=E5"><SPAN></SPAN></FONT></FONT=
>&nbsp;</DIV>
                  <DIV><FONT size=3D2><FONT
                  DEFANGED_face=3D"=CB=CE=CC=E5"><SPAN>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
                  Kunkai Shen</SPAN></FONT></FONT></DIV></TD></TR></TBODY><=
/TABLE>
            <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E-Mail:
            skkwish@263.net</P>
            <P></FONT>&nbsp;</P></TD></TR></TBODY></TABLE></DIV></DIV></TD>=
</TR></TBODY></TABLE></BODY></HTML>

--=====002_Dragon738264534364_=====--

------------=_1079068672-17740-810
Content-Type: text/plain; name="SpamAssassinReport.txt"
Content-Disposition: inline; filename="SpamAssassinReport.txt"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This mail is probably spam.  The original message has been attached
along with this report, so you can recognize or block similar unwanted
mail in future.  See http://spamassassin.org/tag/ for more details.

Content preview:  --==== 2_Dragon738264534364_====Content-Type:
  text/plain; charset="GB2312" Content-Transfer-Encoding: 7bit hi! My
  linux is 2.4.20, I have two Interl netcard, driver is e100.o, when I
  add eth0 and eth1 to br0, all is right, then I remove eth0 or eth1 from
  br0, then add, remove,add. repeat some times, my kernel panic, screen
  show dev.c: call skb_checksum_help(): 947 conduce this problem. [...] 

Content analysis details:   (5.40 points, 5 required)
HTML_40_50         (1.1 points)  BODY: Message is 40% to 50% HTML
HTML_FONT_FACE_ODD (0.1 points)  BODY: HTML font face is not a commonly used face
HTML_MESSAGE       (0.1 points)  BODY: HTML included in message
HTML_FONT_BIG      (0.2 points)  BODY: FONT Size +2 and up or 3 and up
HTML_TAG_EXISTS_TBODY (0.5 points)  BODY: HTML has "tbody" tag
MIME_LONG_LINE_QP  (0.3 points)  RAW: Quoted-printable line longer than 76 characters
MSG_ID_ADDED_BY_MTA_2 (1.0 points)  'Message-Id' was added by a relay (2)
CHARSET_FARAWAY_HEADERS (2.1 points)  A foreign language charset used in headers



------------=_1079068672-17740-810--
