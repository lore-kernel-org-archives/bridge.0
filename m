Return-Path: <grindelwaldus@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=6puvgznxO5TuA/4L3MG+X2/Fz/YRVjlTVq417ztL3vg=;
	b=tMt6Jtq1amQv7FsM9pPpp9/snyaK5CXCJn+JzKwFO/dI+LWmWdLpZipZN4zrWJHal2
	l9AYALQNlg4El9p243Au+Ry88WCvWzCw++uuQPWOf+jVqRGPAO5fxyy2VzB5zEwWuuLk
	4dohsgL6r3jLJ5zkFJckKSxFL8otFOS/MrPVkn5A+JiqIrNTtWFVn/iYjhm6nbpfblcx
	iHCkYR+MkReWHlZqCL7hfiLqv1DIEzcoQlGz0DCjOpN2/dIJjSH+/G321vB0bYKOVQhp
	ZMF6+k/SC4czO7od2mXLstf/OLhUUFzfsPlNuWfh3bPcm+kPOzs6G8ZWWxcoU864+kpr
	hpeg==
MIME-Version: 1.0
From: gellert grindelwald <grindelwaldus@gmail.com>
Date: Fri, 6 Jan 2017 18:15:24 +0300
Message-ID: <CAJiguwoUWDOYoeU9UPm9FoXhO3h9ZOhjrpW_ijyyG+9eBYMm0g@mail.gmail.com>
Content-Type: multipart/alternative; boundary=001a113ac0f0bd886305456e7c3a
Subject: [Bridge] RSTP, vlans and bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--001a113ac0f0bd886305456e7c3a
Content-Type: text/plain; charset=UTF-8

I tried to figure out how to setup RSTP on Linux with VLANs and bridges
involved and now am completely confused.

I am trying to bridge three interfaces, two of which are supposed to act as
trunk (hdlc0 and hdlc1) and one is supposed to act as access port (eth0). I
also need to enable RSTP on each interface included in bridge, but with the
configuration listed below RSTP packets are sent via hdlc0 and hdlc1 tagged
(!) so other devices (like Cisco switches) reject them.

Here's my configuration:

ifconfig eth0 up


ifconfig hdlc0 up
ifconfig hdlc1 up

vconfig add hdlc0 42
vconfig add hdlc1 42
ifconfig hdlc0.42 up
ifconfig hdlc1.42 up


brctl addbr br1
brctl addif br1 eth0
brctl addif br1 hdlc0.42
brctl addif br1 hdlc1.42

ifconfig br1 up
brctl stp br1 on


Another question: I also wonder how to configure RSTP in scenarios where I
have multiple bridges: say eth0 is trunk with vlan 42-42 allowed, vlan 42
is supposed to pass via hdlc0 and vlan 43 is supposed to go via hdlc1, so I
have two bridges. If i enable RSTP on both bridges it will (probably) run
independently on each bridge so I'll face problems soon?

--001a113ac0f0bd886305456e7c3a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p style=3D"margin:0px 0px 1em;padding:0px;border:0px;font=
-size:15px;clear:both;color:rgb(36,39,41);font-family:arial,&quot;helvetica=
 neue&quot;,helvetica,sans-serif">I tried to figure out how to setup RSTP o=
n Linux with VLANs and bridges involved and now am completely confused.</p>=
<p style=3D"margin:0px 0px 1em;padding:0px;border:0px;font-size:15px;clear:=
both;color:rgb(36,39,41);font-family:arial,&quot;helvetica neue&quot;,helve=
tica,sans-serif">I am trying to bridge three interfaces, two of which are s=
upposed to act as trunk (hdlc0 and hdlc1) and one is supposed to act as acc=
ess port (eth0). I also need to enable RSTP on each interface included in b=
ridge, but with the configuration listed below RSTP packets are sent via hd=
lc0 and hdlc1 tagged (!) so other devices (like Cisco switches) reject them=
.=C2=A0</p><p style=3D"margin:0px 0px 1em;padding:0px;border:0px;font-size:=
15px;clear:both;color:rgb(36,39,41);font-family:arial,&quot;helvetica neue&=
quot;,helvetica,sans-serif">Here&#39;s my configuration:</p><pre style=3D"m=
argin-top:0px;margin-bottom:1em;padding:5px;border:0px;font-size:13px;width=
:auto;max-height:600px;overflow:auto;font-family:consolas,menlo,monaco,&quo=
t;lucida console&quot;,&quot;liberation mono&quot;,&quot;dejavu sans mono&q=
uot;,&quot;bitstream vera sans mono&quot;,&quot;courier new&quot;,monospace=
,sans-serif;background-color:rgb(239,240,241);word-wrap:normal;color:rgb(36=
,39,41)"><code style=3D"margin:0px;padding:0px;border:0px;font-family:conso=
las,menlo,monaco,&quot;lucida console&quot;,&quot;liberation mono&quot;,&qu=
ot;dejavu sans mono&quot;,&quot;bitstream vera sans mono&quot;,&quot;courie=
r new&quot;,monospace,sans-serif;white-space:inherit">ifconfig eth0 up


ifconfig hdlc0 up
ifconfig hdlc1 up

vconfig add hdlc0 42
vconfig add hdlc1 42
ifconfig hdlc0.42 up
ifconfig hdlc1.42 up


brctl addbr br1
brctl addif br1 eth0
brctl addif br1 hdlc0.42
brctl addif br1 hdlc1.42

ifconfig br1 up
brctl stp br1 on
</code></pre><p style=3D"margin:0px 0px 1em;padding:0px;border:0px;font-siz=
e:15px;clear:both;color:rgb(36,39,41);font-family:arial,&quot;helvetica neu=
e&quot;,helvetica,sans-serif"><br></p><p style=3D"margin:0px 0px 1em;paddin=
g:0px;border:0px;font-size:15px;clear:both;color:rgb(36,39,41);font-family:=
arial,&quot;helvetica neue&quot;,helvetica,sans-serif">Another question: I =
also wonder how to configure RSTP in scenarios where I have multiple bridge=
s: say eth0 is trunk with vlan 42-42 allowed, vlan 42 is supposed to pass v=
ia hdlc0 and vlan 43 is supposed to go via hdlc1, so I have two bridges. If=
 i enable RSTP on both bridges it will (probably) run independently on each=
 bridge so I&#39;ll face problems soon?</p></div>

--001a113ac0f0bd886305456e7c3a--
