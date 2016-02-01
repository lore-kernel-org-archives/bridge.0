Return-Path: <djlogan2.dl@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:content-type:subject:message-id:date:to:mime-version;
	bh=taUPkX6PqoIwfDZx/NsbvdbegfOFD0HLPMCt9YseTZ8=;
	b=Gypu8yBnUSU1LIb96pbU65kTeZsrD6tAHjlu3Tk5bYIbbTPDEQmXmajcMqh79FcxMr
	GFOnG1mn1vjzV+8CvzXtTS0XpwWKtN+WqDqBFAekMK3DODZAGqBpp+dvz0gfuPjHcaEb
	lMPD3/eeb1TFl9O4l3jFQtvqpVDk3OrIb64rapE9OEQc5k0UE2DmXlOkKBpxzaWLFvbb
	mLK710HI44YydkA/URN1p0rWrGcXXvyLDn0JiR5Qi/0a5svaFSbtB2/bctLk0hTphP9O
	7+MRVvzp3VcnlgLiiumsfu/ctJDSV8fAOn0e0V+bWyy2ipAOXOmKN16ONLjyH7kBhVNK
	S9SA==
From: David Logan <djlogan2.dl@gmail.com>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_3063BF53-B99B-4B3E-9075-867988A6F5F4"
Message-Id: <5FA3B72D-03E5-43BD-B635-6A46070C6898@gmail.com>
Date: Mon, 1 Feb 2016 12:51:20 -0700
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: [Bridge] Help with Ubuntu + bridge + tap + qemu + Windows
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


--Apple-Mail=_3063BF53-B99B-4B3E-9075-867988A6F5F4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi guys

I have been researching this problem for weeks, and I have tried =
everything every web page has even remotely suggested, and nothing =
works. I am at my wits end, and I simply *must* get my issue resolved.

Basically, when I bring up one or more VMs using tap# on a br# on an =
eth#, the network interface will work for a random amount of time, but =
inevitably something will die, and the =E2=80=9CTX packets=E2=80=9D =
stops incrementing, and the =E2=80=9CTX packets dropped=E2=80=9D takes =
over. At that point, I can shut down and start up my VM, and go through =
the cycle again with a different random time and packets transmitted.

tap2      Link encap:Ethernet  HWaddr 8a:21:a8:cb:f5:98 =20
          inet6 addr: fe80::8821:a8ff:fecb:f598/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:51870 errors:0 dropped:0 overruns:0 frame:0
          TX packets:741595 errors:0 dropped:5702 overruns:0 carrier:0
          collisions:0 txqueuelen:500=20
          RX bytes:3220139 (3.2 MB)  TX bytes:1113177111 (1.1 GB)

I could obviously post every shred of information I have, ethtool, =
iptables, netstat, brctl, etc. but I hate to create a 10K email with =
mostly unnecessary outputs. If anyone has a specific set of questions =
they need answered, I am more than happy to provide. I=E2=80=99m running =
the latest Ubuntu and get updates daily. The uname -a as of this morning =
is:

Darwin Carolyns-MacBook-Air.local 15.3.0 Darwin Kernel Version 15.3.0: =
Thu Dec 10 18:40:58 PST 2015; root:xnu-3248.30.4~1/RELEASE_X86_64 x86_64

What in the world am I doing wrong, or where is this failing, how do I =
find it, and most importantly, how do I fix it? :)

Thank you,
David Logan


--Apple-Mail=_3063BF53-B99B-4B3E-9075-867988A6F5F4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">Hi guys<div class=3D""><br class=3D""></div><div class=3D"">I =
have been researching this problem for weeks, and I have tried =
everything every web page has even remotely suggested, and nothing =
works. I am at my wits end, and I simply *must* get my issue =
resolved.</div><div class=3D""><br class=3D""></div><div =
class=3D"">Basically, when I bring up one or more VMs using tap# on a =
br# on an eth#, the network interface will work for a random amount of =
time, but inevitably something will die, and the =E2=80=9CTX packets=E2=80=
=9D stops incrementing, and the =E2=80=9CTX packets dropped=E2=80=9D =
takes over. At that point, I can shut down and start up my VM, and go =
through the cycle again with a different random time and packets =
transmitted.</div><div class=3D""><br class=3D""></div><div =
class=3D""><div style=3D"margin: 0px; font-size: 11px; line-height: =
normal; font-family: Menlo;" class=3D"">tap2&nbsp; &nbsp; &nbsp; Link =
encap:Ethernet&nbsp; HWaddr 8a:21:a8:cb:f5:98 &nbsp;</div><div =
style=3D"margin: 0px; font-size: 11px; line-height: normal; font-family: =
Menlo;" class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; inet6 addr: =
fe80::8821:a8ff:fecb:f598/64 Scope:Link</div><div style=3D"margin: 0px; =
font-size: 11px; line-height: normal; font-family: Menlo;" =
class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; UP BROADCAST RUNNING =
MULTICAST&nbsp; MTU:1500&nbsp; Metric:1</div><div style=3D"margin: 0px; =
font-size: 11px; line-height: normal; font-family: Menlo;" =
class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; RX packets:51870 errors:0 =
dropped:0 overruns:0 frame:0</div><div style=3D"margin: 0px; font-size: =
11px; line-height: normal; font-family: Menlo;" class=3D"">&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; TX packets:741595 errors:0 dropped:5702 overruns:0 =
carrier:0</div><div style=3D"margin: 0px; font-size: 11px; line-height: =
normal; font-family: Menlo;" class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; collisions:0 txqueuelen:500&nbsp;</div><div style=3D"margin: 0px; =
font-size: 11px; line-height: normal; font-family: Menlo;" =
class=3D"">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; RX bytes:3220139 (3.2 =
MB)&nbsp; TX bytes:1113177111 (1.1 GB)</div><div style=3D"margin: 0px; =
font-size: 11px; line-height: normal; font-family: Menlo;" class=3D""><br =
class=3D""></div><div class=3D"">I could obviously post every shred of =
information I have, ethtool, iptables, netstat, brctl, etc. but I hate =
to create a 10K email with mostly unnecessary outputs. If anyone has a =
specific set of questions they need answered, I am more than happy to =
provide. I=E2=80=99m running the latest Ubuntu and get updates daily. =
The uname -a as of this morning is:</div><div class=3D""><br =
class=3D""></div><div class=3D""><div style=3D"margin: 0px; font-size: =
11px; line-height: normal; font-family: Menlo;" class=3D"">Darwin =
Carolyns-MacBook-Air.local 15.3.0 Darwin Kernel Version 15.3.0: Thu Dec =
10 18:40:58 PST 2015; root:xnu-3248.30.4~1/RELEASE_X86_64 =
x86_64</div></div><div style=3D"margin: 0px; font-size: 11px; =
line-height: normal; font-family: Menlo;" class=3D""><br =
class=3D""></div><div class=3D"">What in the world am I doing wrong, or =
where is this failing, how do I find it, and most importantly, how do I =
fix it? :)</div><div class=3D""><br class=3D""></div><div class=3D"">Thank=
 you,</div><div class=3D"">
<span class=3D"Apple-style-span" style=3D"border-collapse: separate; =
line-height: normal; border-spacing: 0px;">David Logan<br class=3D""><br =
class=3D""></span></div></div></body></html>=

--Apple-Mail=_3063BF53-B99B-4B3E-9075-867988A6F5F4--
