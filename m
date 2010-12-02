From: Shawn Delaney <sdelaney@juniper.net>
Date: Thu, 2 Dec 2010 14:19:54 -0800
Message-ID: <DBDEC20E6E29304D8AE5EAA493609B35576467B066@EMBX02-HQ.jnpr.net>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DBDEC20E6E29304D8AE5EAA493609B35576467B066EMBX02HQjnprn_"
MIME-Version: 1.0
Subject: [Bridge] bridge problem with with ICMP fragment reassembly
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

--_000_DBDEC20E6E29304D8AE5EAA493609B35576467B066EMBX02HQjnprn_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I have a bridge (br0) with two enslaved interfaces (int0 and ext0). From th=
e ext0 side, with a windows device, I ping with packet size 1932:

ping -n 1 -l 1932 10.64.160.94

ping request and reply is bridged.

Now if I do the same with packet size 1933:

ping -n 1 -l 1933 10.64.160.94

the request never seems to make it to the bridge interface

If I sniff the ping from the windows device on the ext0 side, I see two fra=
mes sent, request + fragment, as expected.
In the working case, if I sniff ext0 on the bridge device I see the same tw=
o frames received.
In the working case, if I sniff br0 on the bridge I see one frame (I assume=
 the bridge reassembles the request + fragment).
In the non working case,  if I sniff ext0 on the bridge device I see the sa=
me two frames received.
In the non working case, if I sniff br0 I see nothing.

It seems there is a bug with bridging and reassembly of  packets or fragmen=
ts of a certain size, and am wondering If there is a patch.

The MTU of all interfaces is 1500.
I am using connection tracking.
The problem is seen on kernels 2.6.11 and 2.6.24

Any help would be much appreciated.

Regards,
Shawn






--_000_DBDEC20E6E29304D8AE5EAA493609B35576467B066EMBX02HQjnprn_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri, sans-serif" size=3D"2">
<div>Hi,</div>
<div>&nbsp;</div>
<div>I have a bridge (br0) with two enslaved interfaces (int0 and ext0). Fr=
om the ext0 side, with a windows device, I ping with packet size 1932:</div=
>
<div>&nbsp;</div>
<div>ping &#8211;n 1 &#8211;l 1932 10.64.160.94</div>
<div>&nbsp;</div>
<div>ping request and reply is bridged.</div>
<div>&nbsp;</div>
<div>Now if I do the same with packet size 1933:</div>
<div>&nbsp;</div>
<div>ping &#8211;n 1 &#8211;l 1933 10.64.160.94</div>
<div>&nbsp;</div>
<div>the request never seems to make it to the bridge interface</div>
<div>&nbsp;</div>
<div>If I sniff the ping from the windows device on the ext0 side, I see tw=
o frames sent, request &#43; fragment, as expected. </div>
<div>In the working case, if I sniff ext0 on the bridge device I see the sa=
me two frames received. </div>
<div>In the working case, if I sniff br0 on the bridge I see one frame (I a=
ssume the bridge reassembles the request &#43; fragment).</div>
<div>In the non working case,&nbsp; if I sniff ext0 on the bridge device I =
see the same two frames received.</div>
<div>In the non working case, if I sniff br0 I see nothing.</div>
<div>&nbsp;</div>
<div>It seems there is a bug with bridging and reassembly of&nbsp; packets =
or fragments of a certain size, and am wondering If there is a patch.</div>
<div>&nbsp;</div>
<div>The MTU of all interfaces is 1500.</div>
<div>I am using connection tracking.</div>
<div>The problem is seen on kernels 2.6.11 and 2.6.24</div>
<div>&nbsp;</div>
<div>Any help would be much appreciated.</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Shawn</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
</font>
</body>
</html>

--_000_DBDEC20E6E29304D8AE5EAA493609B35576467B066EMBX02HQjnprn_--
