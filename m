Return-Path: <lambert.laurent91@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=o9ny48zMxIMf64XWGwBFgH+QmKPqzmcNVZlK4505pzE=;
	b=Dv4BI+1AVXWly0uMks+xihIIrXb868i5ObRJSuTpVJTqGkAmR1N/P1VRC5D9/BeehM
	z0lfrcBK+gu1r6dEAKeec+zzkNp4CaCrcya2xp49iEbzvUbtFtF7A5SI22S+nHk0V5zI
	FV95ZmBwZ5MXHuPmjjtyNirQTrjzZL3mTl+pDLbr1AbqFOYD8DEFQYkaVHJsMGnRyTiv
	As+LKOufnL/tas6PVOSe5jL+cg1e6q1lT9xLfW/7VZQ8d5wAPnCblbHxF86fpSksVvHq
	i6PvocRaZP3WY0qhrsNiI61uwzdjJFokx7tD6/GmTA/C7aE/PDl7dpH47LtPEc1ARSkT
	zmSg==
MIME-Version: 1.0
Date: Sat, 6 Jul 2013 17:22:40 +0200
Message-ID: <CAGZVhE1nOXBO_QiDX58xR3mu_sd6v2p3tiZPe+hKsJ3mS+UWEQ@mail.gmail.com>
From: Lambert Laurent <lambert.laurent91@gmail.com>
Content-Type: multipart/alternative; boundary=001a11c29996cd008604e0d96101
Subject: [Bridge] Tap and Bridge problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--001a11c29996cd008604e0d96101
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I'm currently trying to use bridge and tap for my work. In my setup I use
two programs communicating though tap interface. I connect the two tap
interface with a bridge.

Now comes the problem, currently only broadcast or multicast frames goes
through the bridge. Every unicast frame get drop (or stuck) between the
bridge and the input of the tap device. I traced this with tcpdump. The
message is seen on the sender tap if, on the bridge and disapears on the
receiver tap if.
Also the frame seems to be well formated (tcpdump identifies it properly).

to instanciate a bridge i use :
brctl addbr br0
brctl addif br0 tap0
brctl addif br0 tap1

i then ifconfig up the bridge and the two tap interface.

I also noticed in linux log that the bridge puts tap port in disabled
state.

Did anyone this behavior in the past time ?

Thank you.

-- 
Lambert Laurent

--001a11c29996cd008604e0d96101
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I&#39;m currently trying to use bri=
dge and tap for my work. In my setup I use two programs communicating thoug=
h tap interface. I connect the two tap interface with a bridge.=A0</div><di=
v>
<br></div><div>Now comes the problem, currently only broadcast or multicast=
 frames goes through the bridge. Every unicast frame get drop (or stuck) be=
tween the bridge and the input of the tap device. I traced this with tcpdum=
p. The message is seen on the sender tap if, on the bridge and disapears on=
 the receiver tap if.</div>
<div>Also the frame seems to be well formated (tcpdump identifies it proper=
ly).</div><div><div><br></div><div>to instanciate a bridge i use :</div><di=
v>brctl addbr br0</div><div>brctl addif br0 tap0</div><div>brctl addif br0 =
tap1<br>
</div><div><br></div><div>i then ifconfig up the bridge and the two tap int=
erface.</div><div><br></div><div>I also noticed in linux log that the bridg=
e puts tap port in disabled state.=A0</div><div><br></div><div>Did anyone t=
his behavior in the past time ?</div>
<div><br></div><div>Thank you.</div><div><br></div>-- <br>Lambert Laurent
</div></div>

--001a11c29996cd008604e0d96101--
