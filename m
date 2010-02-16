From: Martin Andersson Z <martin.z.andersson@ericsson.com>
Date: Tue, 16 Feb 2010 11:58:26 +0100
Message-ID: <3A71C16B9E0D7240ABBDF087E5353BCB0CB2D35BFC@ESESSCMS0354.eemea.ericsson.se>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_3A71C16B9E0D7240ABBDF087E5353BCB0CB2D35BFCESESSCMS0354e_"
MIME-Version: 1.0
Subject: [Bridge] NTP packets not passing the bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "'bridge@lists.linux-foundation.org'" <bridge@lists.linux-foundation.org>

--_000_3A71C16B9E0D7240ABBDF087E5353BCB0CB2D35BFCESESSCMS0354e_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello.

I have a simple testsetup, where <node> --- | bridge | --- <node> is connec=
ted.

Every packets seems to traverse the bridge, except for the NTP packets.

When capturing on the in-port, what differes for this NTP packets is that t=
here src-mac address is 00:00:00:00:00:00.
Where any other packets has valid src address.

Is there a check/validation in the bridge so that it will not pass eth-pack=
ets that has a src with all 0.

The kernel used is "2.6.31.5-0.1"

brg/Martin



--_000_3A71C16B9E0D7240ABBDF087E5353BCB0CB2D35BFCESESSCMS0354e_
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
<font face=3D"Arial, sans-serif" size=3D"2">
<div>Hello.</div>
<div>&nbsp;</div>
<div>I have a simple testsetup, where &lt;node&gt; --- | bridge | --- &lt;n=
ode&gt; is connected.</div>
<div>&nbsp;</div>
<div>Every packets seems to traverse the bridge, except for the NTP packets=
.</div>
<div>&nbsp;</div>
<div>When capturing on the in-port, what differes for this NTP packets is t=
hat there src-mac address is 00:00:00:00:00:00.</div>
<div>Where any other packets has valid src address.</div>
<div>&nbsp;</div>
<div>Is there a check/validation in the bridge so that it will not pass eth=
-packets that has a src with all 0.</div>
<div>&nbsp;</div>
<div>The kernel used is &quot;2.6.31.5-0.1&quot;</div>
<div>&nbsp;</div>
<div>brg/Martin</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
</font>
</body>
</html>

--_000_3A71C16B9E0D7240ABBDF087E5353BCB0CB2D35BFCESESSCMS0354e_--
