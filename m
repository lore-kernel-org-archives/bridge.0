Return-Path: <Koen.Swinters@otnsystems.com>
From: Koen Swinters <Koen.Swinters@otnsystems.com>
Date: Tue, 28 Feb 2012 09:39:21 +0100
Message-ID: <48749811B6A50F4994E931DDE5578FD42C9F7DD488@dca12.dcaad.local>
Content-Language: nl-BE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] can not get STP with VLAN working in linux
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

Hi,

I want to connect two pc`s on a redundant way with each other. On those pc`=
s a 64 bit ubuntu 11.10 is running with kernel version 3.0.0-16-generic.


Setup1:
----------

PC1:                                                                       =
      PC2:


br0                                                                        =
        br1
|                                                                          =
           |
-- eth0.1000  ---------------------------------------------------eth0.1000
|                                                                          =
           |
__eth1.1001 ----------------------------------------------------eth1.1001




When I enable spanning tree on both bridges (brctl stp br0 on). They both s=
tay sending BPDU packages and no port is disabled. So I get a loop. For som=
e reason spanning tree is not working.

Setup2:
---------
When I repeat the following test without the VLANs the spanning tree protoc=
ol is working:

br0                                                                        =
  br1
|                                                                          =
    |
-- eth0  -----------------------------------------------------eth0
|                                                                          =
    |
__eth1 ------ -----------------------------------------------eth1







The problems is that in the final solution I only have vlans, so I need Set=
up1.


Is spanning tree in Linux possible with VLANS?
If so, how do I have to set-up this?

Thanks,

Koen=
