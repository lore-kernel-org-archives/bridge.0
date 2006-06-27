Message-ID: <44A142D8.5010301@uku.co.uk>
Date: Tue, 27 Jun 2006 15:38:16 +0100
From: Robert Stannard <robert.stannard@uku.co.uk>
MIME-Version: 1.0
References: <00a201c699f1$380e7f00$20ed150c@SunShine>
In-Reply-To: <00a201c699f1$380e7f00$20ed150c@SunShine>
Content-Type: multipart/alternative;
	boundary="------------040309090603070507080300"
Subject: Re: [Bridge] Bridge does not stay UP!!!
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Kirti S. Bajwa" <kbajwa@tibonline.net>
Cc: bridge@lists.osdl.org

This is a multi-part message in MIME format...

--------------040309090603070507080300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Kirt,

The bridge needs to be setup each time you reboot the system. It is not 
remembered or setup in the boot sequence as standard.
You need to include a small script in the bootup sequence to initialise 
the bridge automatically.

I hope this helps a little?

Best Regards
Robert Stannard

PS
There are some previous posts about this.
See http://lists.osdl.org/mailman/htdig/bridge/2004-March/000215.html 
for one example.

Kirti S. Bajwa wrote:

> Hello German:
>
>  
>
> Thank you for your response. I have read & re-read the documents you 
> have suggested. Why the Bridge would not stay ACTIVE is not discussed 
> in any of these documents.
>
>  
>
> Anybody else has a suggestion?
>
>  
>
> Kirt
>
>  
>
>  
>
> -----Original Message-----
> *From:* bridge-bounces@lists.osdl.org 
> [mailto:bridge-bounces@lists.osdl.org] *On Behalf Of *German Jimenez Leal
> *Sent:* Monday, June 26, 2006 7:00 PM
> *To:* bridge@lists.osdl.org
> *Subject:* Re: [Bridge] Bridge does not stay UP!!!
>
>  
>
> Hello Kirti:
>
> http://linux-net.osdl.org/index.php/Bridge
>
> http://www.shorewall.net/   shorewall 3.x documentacion 
> ---- 7.-Bridging------ Bridge/Firewall (control traffic through the 
> bridge) <http://www.shorewall.net/bridge.html>
>
>  
>
>  
>
>  
>
> ------------------------------------------------------------------------
>
> *De:* bridge-bounces@lists.osdl.org 
> [mailto:bridge-bounces@lists.osdl.org] *En nombre de *Kirti S. Bajwa
> *Enviado el:* Lunes, 26 de Junio de 2006 03:54 p.m.
> *Para:* bridge@lists.osdl.org
> *Asunto:* [Bridge] Bridge does not stay UP!!!
>
> Hello List:
>
>  
>
> I am trying to setup a bridge & Shorewall on a CentOS 4.3 (fresh 
> Install) server. I successfully setup the bridge. However when I 
> reboot the system, the bridge does not remain ACTIVE.
>
>  
>
> Am I missing a setting?
>
>  
>
> Thanks.
>
>  
>
> Kirti
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Bridge mailing list
>Bridge@lists.osdl.org
>https://lists.osdl.org/mailman/listinfo/bridge
>  
>


--------------040309090603070507080300
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Dear Kirt,<br>
<br>
The bridge needs to be setup each time you reboot the system. It is not
remembered or setup in the boot sequence as standard.<br>
You need to include a small script in the bootup sequence to initialise
the bridge automatically.<br>
<br>
I hope this helps a little?<br>
<br>
Best Regards<br>
Robert Stannard<br>
<br>
PS<br>
There are some previous posts about this.<br>
See <a class="moz-txt-link-freetext" href="http://lists.osdl.org/mailman/htdig/bridge/2004-March/000215.html">http://lists.osdl.org/mailman/htdig/bridge/2004-March/000215.html</a>
for one example.<br>
<br>
Kirti S. Bajwa wrote:
<blockquote cite="mid00a201c699f1$380e7f00$20ed150c@SunShine"
 type="cite">
  <meta http-equiv="Content-Type" content="text/html; ">
  <meta name="Generator" content="Microsoft Word 10 (filtered)">
  <DEFANGED_style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
--></DEFANGED_style>
  <DEFANGED_STYLE><!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p.MsoAutoSig, li.MsoAutoSig, div.MsoAutoSig
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
span.EmailStyle17
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
--></DEFANGED_STYLE>
  <div class="Section1">
  <p class="MsoNormal"><font color="navy" face="Arial" size="2"><span
 DEFANGED_defanged_style="font-size:
10.0pt;font-family:Arial;color:navy">Hello
German:</span></font></p>
  <p class="MsoNormal"><font color="navy" face="Arial" size="2"><span
 DEFANGED_defanged_style="font-size:
10.0pt;font-family:Arial;color:navy">&nbsp;</span></font></p>
  <p class="MsoNormal"><font color="navy" face="Arial" size="2"><span
 DEFANGED_defanged_style="font-size:
10.0pt;font-family:Arial;color:navy">Thank
you for your response. I have read
&amp; re-read the documents you have suggested. Why the Bridge would
not stay
ACTIVE is not discussed in any of these documents.</span></font></p>
  <p class="MsoNormal"><font color="navy" face="Arial" size="2"><span
 DEFANGED_defanged_style="font-size:
10.0pt;font-family:Arial;color:navy">&nbsp;</span></font></p>
  <p class="MsoNormal"><font color="navy" face="Arial" size="2"><span
 DEFANGED_defanged_style="font-size:
10.0pt;font-family:Arial;color:navy">Anybody
else has a suggestion?</span></font></p>
  <p class="MsoNormal"><font color="navy" face="Arial" size="2"><span
 DEFANGED_defanged_style="font-size:
10.0pt;font-family:Arial;color:navy">&nbsp;</span></font></p>
  <p class="MsoNormal"><font color="navy" face="Arial" size="2"><span
 DEFANGED_defanged_style="font-size:
 10.0pt;font-family:Arial;color:navy">Kirt</span></font></p>
  <p class="MsoNormal"><font color="navy" face="Arial" size="2"><span
 DEFANGED_defanged_style="font-size:
10.0pt;font-family:Arial;color:navy">&nbsp;</span></font></p>
  <p class="MsoNormal"><font color="navy" face="Arial" size="2"><span
 DEFANGED_defanged_style="font-size:
10.0pt;font-family:Arial;color:navy">&nbsp;</span></font></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><font
 face="Tahoma" size="2"><span
 DEFANGED_defanged_style="font-size:10.0pt;font-family:Tahoma">-----Original
Message-----<br>
  <b><span DEFANGED_defanged_style="font-weight:bold">From:</span></b>
<a class="moz-txt-link-abbreviated" href="mailto:bridge-bounces@lists.osdl.org">bridge-bounces@lists.osdl.org</a> [<a class="moz-txt-link-freetext" href="mailto:bridge-bounces@lists.osdl.org">mailto:bridge-bounces@lists.osdl.org</a>] <b><span
 DEFANGED_defanged_style="font-weight:bold">On Behalf Of </span></b>German
Jimenez Leal<br>
  <b><span DEFANGED_defanged_style="font-weight:bold">Sent:</span></b> </span></font><font
 face="Tahoma" size="2"><span
 DEFANGED_defanged_style="font-size:10.0pt;font-family:Tahoma">Monday, June 26,
2006</span></font><font face="Tahoma" size="2"><span
 DEFANGED_defanged_style="font-size:10.0pt;
font-family:Tahoma"> </span></font><font
 face="Tahoma" size="2"><span
 DEFANGED_defanged_style="font-size:10.0pt;font-family:Tahoma">7:00 PM</span></font><font
 face="Tahoma" size="2"><span
 DEFANGED_defanged_style="font-size:10.0pt;font-family:Tahoma"><br>
  <b><span DEFANGED_defanged_style="font-weight:bold">To:</span></b>
<a class="moz-txt-link-abbreviated" href="mailto:bridge@lists.osdl.org">bridge@lists.osdl.org</a><br>
  <b><span DEFANGED_defanged_style="font-weight:bold">Subject:</span></b> Re:
[Bridge] Bridge does
not stay UP!!!</span></font></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt">&nbsp;</span></font></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><font
 color="blue" face="Arial" size="2"><span
 DEFANGED_defanged_style="font-size:10.0pt;font-family:Arial;color:blue">Hello
Kirti:</span></font></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><font
 color="blue" face="Arial" size="2"><span
 DEFANGED_defanged_style="font-size:10.0pt;font-family:Arial;color:blue"><a
 href="http://linux-net.osdl.org/index.php/Bridge">http://linux-net.osdl.org/index.php/Bridge</a></span></font></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><font
 color="blue" face="Arial" size="2"><span
 DEFANGED_defanged_style="font-size:10.0pt;font-family:Arial;color:blue"><a
 href="http://www.shorewall.net/">http://www.shorewall.net/</a>&nbsp;&nbsp;
shorewall 3.x documentacion ----&nbsp;7.-Bridging------ <a
 href="http://www.shorewall.net/bridge.html" target="_self"><font
 face="Times New Roman" size="3"><span
 DEFANGED_defanged_style="font-size:12.0pt;font-family:&quot;Times New Roman&quot;">Bridge/Firewall
(control traffic through the bridge)</span></font></a></span></font></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt">&nbsp;</span></font></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt">&nbsp;</span></font></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt">&nbsp;</span></font></p>
  <div class="MsoNormal"
 DEFANGED_defanged_style="margin-left:.5in;text-align:center" align="center"><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt"
 lang="ES">
  <hr align="center" size="2" width="100%"></span></font></div>
  <p class="MsoNormal"
 DEFANGED_defanged_style="margin-right:0in;margin-bottom:12.0pt;margin-left:
.5in"><b><font
 face="Tahoma" size="2"><span
 DEFANGED_defanged_style="font-size:10.0pt;
font-family:Tahoma;font-weight:bold"
 lang="ES">De:</span></font></b><font face="Tahoma" size="2"><span
 DEFANGED_defanged_style="font-size:10.0pt;font-family:Tahoma" lang="ES">
<a class="moz-txt-link-abbreviated" href="mailto:bridge-bounces@lists.osdl.org">bridge-bounces@lists.osdl.org</a> [<a class="moz-txt-link-freetext" href="mailto:bridge-bounces@lists.osdl.org">mailto:bridge-bounces@lists.osdl.org</a>] <b><span
 DEFANGED_defanged_style="font-weight:bold">En nombre de </span></b>Kirti S.
Bajwa<br>
  <b><span DEFANGED_defanged_style="font-weight:bold">Enviado el:</span></b>
Lunes, 26 de Junio de
2006 03:54 p.m.<br>
  <b><span DEFANGED_defanged_style="font-weight:bold">Para:</span></b>
<a class="moz-txt-link-abbreviated" href="mailto:bridge@lists.osdl.org">bridge@lists.osdl.org</a><br>
  <b><span DEFANGED_defanged_style="font-weight:bold">Asunto:</span></b>
[Bridge] Bridge does not
stay UP!!!</span></font></p>
  <div>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><font
 face="Courier New" size="2"><span
 DEFANGED_defanged_style="font-size:10.0pt;font-family:&quot;Courier New&quot;"><span
 DEFANGED_defanged_style="font-size:10.0pt;font-family:&quot;Courier New&quot;">Hello List:</span></span></font></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt">&nbsp;</span></font></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><font
 face="Courier New" size="2"><span
 DEFANGED_defanged_style="font-size:10.0pt;font-family:&quot;Courier New&quot;"><span
 DEFANGED_defanged_style="font-size:10.0pt;font-family:&quot;Courier New&quot;">I am
trying to setup a
bridge &amp; Shorewall on a CentOS 4.3 (fresh Install) server. I
successfully
setup the bridge. However when I reboot the system, the bridge does not
remain
ACTIVE. </span></span></font></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt">&nbsp;</span></font></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><font
 face="Courier New" size="2"><span
 DEFANGED_defanged_style="font-size:10.0pt;font-family:&quot;Courier New&quot;"><span
 DEFANGED_defanged_style="font-size:10.0pt;font-family:&quot;Courier New&quot;">Am I
missing a setting?</span></span></font></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt">&nbsp;</span></font></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><font
 face="Courier New" size="2"><span
 DEFANGED_defanged_style="font-size:10.0pt;font-family:&quot;Courier New&quot;"><span
 DEFANGED_defanged_style="font-size:10.0pt;font-family:&quot;Courier New&quot;">Thanks.</span></span></font></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><font
 face="Times New Roman" size="3"><span DEFANGED_defanged_style="font-size:12.0pt">&nbsp;</span></font></p>
  <p class="MsoNormal" DEFANGED_defanged_style="margin-left:.5in"><font
 face="Courier New" size="2"><span
 DEFANGED_defanged_style="font-size:10.0pt;
 font-family:&quot;Courier New&quot;"><span
 DEFANGED_defanged_style="font-size:10.0pt;font-family:&quot;Courier New&quot;">Kirt</span><span
 DEFANGED_defanged_style="font-size:10.0pt;font-family:&quot;Courier New&quot;">i</span></span></font></p>
  </div>
  </div>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Bridge mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Bridge@lists.osdl.org">Bridge@lists.osdl.org</a>
<a class="moz-txt-link-freetext" href="https://lists.osdl.org/mailman/listinfo/bridge">https://lists.osdl.org/mailman/listinfo/bridge</a>
  </pre>
</blockquote>
<br>
</body>
</html>

--------------040309090603070507080300--
