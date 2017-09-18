Return-Path: <andres.pozom@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to
	:content-transfer-encoding;
	bh=5rXIJqUGRqUgPRc81Q5I29loMA51rcGr3doRbGq3dJA=;
	b=E1LsoBVQOsCxU1kwMllLRuDcdhfVHJ+bJ0duaNCVmOg/a/F/9hnqm+NivIhMMguFPn
	Brjux0AB+ASOoWPzoEZh60m5csyXxOjS259kmVJS5xcJacNaOZ4gqFvJmGx2FwjzVMnF
	j37iWzVCzY7Im+19roP2/dahiHuSI7n4xeBNn+Syvb1nMxI9O2shIz/zMYMgZFg/tz2I
	8GVRyKLIaL9RXD74ocZSm0ugM22hkE94u4AjCRAlNGqwcxg0Sl+GZrFMDVy9hjxOJQLy
	KjzZdnFCukx4mQ9lb2UWEGu6/+Hr2fKCTekk+LimO1QeIxHNR/TEEoWidh2fFXOHtpSJ
	N9tA==
MIME-Version: 1.0
From: =?UTF-8?Q?Andr=C3=A9s_Pozo_Mu=C3=B1oz?= <andres.pozom@gmail.com>
Message-ID: <CAPfKRs4GmA4568nt4a2kaHkmm3WmMETL1sXcT8xyByCvVGgFkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Problem with syslog in bridge(?) with ethernet broadcast
	packets with QinQ
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Mon, 18 Sep 2017 15:21:33 -0000
To: bridge@lists.linux-foundation.org

Hi all,

I'm facing some problem with ethernet multicast traffic and QinQ
(802.3q in both tags) in -apparently- a bridge in Ubuntu 16.04
(4.12.0-041200-generic).

My set up is the following:
+-----------+
|     VM    |
+-----+-----+
      |
      | tag 55
+---------+------------+
|        OVS           |
+-----------+----------+
                | veth3.9
veth3   +  |
     +--+
     | veth2
+-------+----------+
|       BRIDGE     |
+-------+----------+
     |
     |
+-------+----------+
|      ens11f1     |
+------------------+


I am setting the inner tag with OVS and the outer tag with a vlan type veth=
.
The problem I have is that every packet sent from the VM to Ethernet
broadcast addresses (33:33:xx:xx:xx:xx) generates a "IPv6 header not
found" entry in syslog.

If I generate a 'ens11f1.9' interface and remove the BRIDGE, the log
entry dissapears.

Some questions:
* Is there any problem with these packets (ethernet multicast with
QinQ) in bridges?
* Is there any configuration I should change for the problem to dissapear?

Thanks in advance for your help! Any hint about what could be
generating those logs is appreciated.

Regards,
Andr=C3=A9s Pozo
