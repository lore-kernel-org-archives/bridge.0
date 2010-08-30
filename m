MIME-Version: 1.0
Date: Mon, 30 Aug 2010 16:29:43 +0530
Message-ID: <AANLkTi=h888Pn9qtK7SuF-xbEY3KDynMjKXm38wEEbiw@mail.gmail.com>
From: debasis das <fordebasis@gmail.com>
Content-Type: multipart/alternative; boundary=00151750eb3eaae231048f085cc6
Subject: [Bridge] help needed regarding crash while adding interface to a
 bridge using brctl utility
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--00151750eb3eaae231048f085cc6
Content-Type: text/plain; charset=ISO-8859-1

Hi,
    I am getting a crash while adding an interface to a bridge using the
"brctl" utility.
    The crash dump is as below:

#vconfig add eth0 5
#brctl addbr br0
#brctl addif br0 eth0.5
Oops: sig: 11 [#1]

a00: 908240ed d47c9bd0 ffffffa1 d47c9bf0 000000c0 d4a5db40 00000003 0000000c
a08: 00000000 d47c9db0 d4b36000 000089a2 3fff0d58 d47c9e40 0000000e 3fff0f64
pc: d082d300, ps: 00060f10, depc: 00000018, excvaddr: 00000000
lbeg: d082fc4c, lend: d082fc57 lcount: 00000000, sar: 00000014

Stack: 00060600 03938702 d063c73c d0638c78 90824a19 d47c9c40 fffffff4
d4649000
       00000001 00000000 00000000 00000000 00000000 00000000 00000000
00000000
       00000000 00000000 00000000 d078a510 00000000 fffffffe 00060d00
d4a5da80
Call Trace:
 [<d082460e>] br_add_if+0xfa/0x23c
 [<d0824a19>] add_del_if+0x31/0x5c
 [<d0824f52>] br_dev_ioctl+0x50e/0x514
 [<d0780eac>] dev_ifsioc+0x31c/0x330
 [<d0781902>] dev_ioctl+0x616/0x6b4
 [<d0774676>] sock_ioctl+0x1b6/0x1c0
 [<d065aa64>] vfs_ioctl+0x14/0x3c
 [<d065b284>] do_vfs_ioctl+0x4a4/0x4c4
 [<d065b2c4>] sys_ioctl+0x20/0x34
 [<d0612470>] system_call+0x40/0x50
 [<d0611b65>] _user_exception+0x10f/0x130

Please do let me know whether this is a known issue and whether there is any
official patch available for the same.
Thanking in advance.

Regards.
Debasis

--00151750eb3eaae231048f085cc6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br>=A0=A0=A0 I am getting a crash while adding an interface to a bridge=
 using the &quot;brctl&quot; utility.<br>=A0=A0=A0 The crash dump is as bel=
ow:<br><br>#vconfig add eth0 5<br>#brctl addbr br0 <br>#brctl addif br0 eth=
0.5<br>Oops: sig: 11 [#1]<br>
<br>a00: 908240ed d47c9bd0 ffffffa1 d47c9bf0 000000c0 d4a5db40 00000003 000=
0000c<br>a08: 00000000 d47c9db0 d4b36000 000089a2 3fff0d58 d47c9e40 0000000=
e 3fff0f64<br>pc: d082d300, ps: 00060f10, depc: 00000018, excvaddr: 0000000=
0<br>
lbeg: d082fc4c, lend: d082fc57 lcount: 00000000, sar: 00000014<br><br>Stack=
: 00060600 03938702 d063c73c d0638c78 90824a19 d47c9c40 fffffff4 d4649000<b=
r>=A0=A0=A0=A0=A0=A0 00000001 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000<br>
=A0=A0=A0=A0=A0=A0 00000000 00000000 00000000 d078a510 00000000 fffffffe 00=
060d00 d4a5da80<br>Call Trace:<br>=A0[&lt;d082460e&gt;] br_add_if+0xfa/0x23=
c<br>=A0[&lt;d0824a19&gt;] add_del_if+0x31/0x5c<br>=A0[&lt;d0824f52&gt;] br=
_dev_ioctl+0x50e/0x514<br>
=A0[&lt;d0780eac&gt;] dev_ifsioc+0x31c/0x330<br>=A0[&lt;d0781902&gt;] dev_i=
octl+0x616/0x6b4<br>=A0[&lt;d0774676&gt;] sock_ioctl+0x1b6/0x1c0<br>=A0[&lt=
;d065aa64&gt;] vfs_ioctl+0x14/0x3c<br>=A0[&lt;d065b284&gt;] do_vfs_ioctl+0x=
4a4/0x4c4<br>
=A0[&lt;d065b2c4&gt;] sys_ioctl+0x20/0x34<br>=A0[&lt;d0612470&gt;] system_c=
all+0x40/0x50<br>=A0[&lt;d0611b65&gt;] _user_exception+0x10f/0x130<br><br>P=
lease do let me know whether this is a known issue and whether there is any=
 official patch available for the same.<br>
Thanking in advance.<br><br>Regards.<br>Debasis<br><br>

--00151750eb3eaae231048f085cc6--
