Return-Path: <jogesh.panda@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=cXjOi9UGnc7JsRY8Wh/LG14G7LFOat0h6f39m3To38I=;
	b=YBo2HZS0RPKPaoF5S46N//IgyyCiu6XO4XHVOgmhqPXB9dBsOdTHpbK1Qu/EOIVbps
	bjD/I9UiJPboA5r7pEQV+8+FvLJHBPctwm/7wLrySxSqWW2N73kmq/Lq+itS1wguSKJa
	nLum+a5VtA72eC2B9h32LcaKOtg0cVPrxDnrjnVmta+5yjAi00T2q6vVM2H6BHZaqEhy
	/DCKpaq3AHHga/PA+AMEJyZMeU/ukJ2KlG6Fu3SqoLJ5pHfWTtGNI1dlFySARXGQj+Cf
	kwqeacT4rO7JXDruL3ynq/kP00wcVhEQ8jy1oBNVLkwpLutOIADmlPcigxlLHBbu9ObT
	dnDg==
MIME-Version: 1.0
Date: Tue, 25 Nov 2014 10:12:02 -0800
Message-ID: <CAHD0KLkXTH5fOMuxc7r6RQQ5f6J4vEOiGqjj1NsOSANq0=p0ZQ@mail.gmail.com>
From: jogesh panda <jogesh.panda@gmail.com>
Content-Type: multipart/alternative; boundary=089e01493964163af20508b2d90c
Subject: [Bridge] Bridge Consuming LACP PDUs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--089e01493964163af20508b2d90c
Content-Type: text/plain; charset=ISO-8859-1

Hi

I have two virtual machine. In side each VM, there is a Switch emulation.
Two create connection between emulated switches, I have create Tutap
Interfaces in the host which are seen as Virtual Interfaces inside the VMs.
The tuntap Interfaces are connected by brctl bridge.

I am having problem with the LACP PDUs, which needs to be forwarded by the
bridge.  Stp is disabled on the bridge. Bridge is consuming the LACP PDUs

I have programmed the ebtables as following


$ sudo ebtables -L
Bridge table: filter

Bridge chain: INPUT, entries: 2, policy: ACCEPT
-p 0x8809 -j ACCEPT
-p 0x8809 -j ACCEPT

Bridge chain: FORWARD, entries: 2, policy: ACCEPT
-p 0x8809 -j ACCEPT
-p 0x8809 -j ACCEPT

Bridge chain: OUTPUT, entries: 1, policy: ACCEPT
-p 0x8809 -j ACCEPT

I am using Linux
 uname -a
Linux Nile 3.5.0-45-generic #68~precise1-Ubuntu SMP Wed Dec 4 16:18:46 UTC
2013 x86_64 x86_64 x86_64 GNU/Linux

Any help is much appreciated.

Thanks in advance.
Jogesh

--089e01493964163af20508b2d90c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=A0<div><br></div><div>I have two virtual machine. In si=
de each VM, there is a Switch emulation. Two create connection between emul=
ated switches, I have create Tutap Interfaces in the host which are seen as=
 Virtual Interfaces inside the VMs. The tuntap Interfaces are connected by =
brctl bridge.=A0</div><div><br></div><div>I am having problem with the LACP=
 PDUs, which needs to be forwarded by the bridge.=A0 Stp is disabled on the=
 bridge. Bridge is consuming the LACP PDUs</div><div><br></div><div>I have =
programmed the ebtables as following=A0</div><div><br></div><div><div><br><=
/div><div>$ sudo ebtables -L=A0</div><div>Bridge table: filter</div><div><b=
r></div><div>Bridge chain: INPUT, entries: 2, policy: ACCEPT</div><div>-p 0=
x8809 -j ACCEPT=A0</div><div>-p 0x8809 -j ACCEPT=A0</div><div><br></div><di=
v>Bridge chain: FORWARD, entries: 2, policy: ACCEPT</div><div>-p 0x8809 -j =
ACCEPT=A0</div><div>-p 0x8809 -j ACCEPT=A0</div><div><br></div><div>Bridge =
chain: OUTPUT, entries: 1, policy: ACCEPT</div><div>-p 0x8809 -j ACCEPT=A0<=
/div></div><div><br></div><div>I am using Linux=A0</div><div><div>=A0uname =
-a</div><div>Linux Nile 3.5.0-45-generic #68~precise1-Ubuntu SMP Wed Dec 4 =
16:18:46 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux</div></div><div><br></div>=
<div>Any help is much appreciated. =A0</div><div><br></div><div>Thanks in a=
dvance.</div><div>Jogesh</div></div>

--089e01493964163af20508b2d90c--
