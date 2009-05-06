Message-ID: <4A01BF38.4080704@gmail.com>
Date: Wed, 06 May 2009 18:47:52 +0200
From: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
MIME-Version: 1.0
References: <20090428124009.GA26387@kallisti.us>	<2e59e6970904281200u44e3ebbfga0f074dfaa78c1ab@mail.gmail.com>	<49F77248.1050800@gmail.com>	<2e59e6970904281600u42142392vb8e0eb45c4ede15c@mail.gmail.com>	<49F87D4E.4060705@gmail.com>
	<20090429162651.GA9455@kallisti.us>	<49F882F9.4010100@gmail.com>
	<20090429165329.GA9893@kallisti.us>	<49F8C4C3.9020504@gmail.com>	<2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>
	<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>
	<49FA1E28.5020604@free.fr> <49FC4764.3030707@gmail.com>
	<49FDD890.1090302@free.fr> <49FF41C4.4090404@gmail.com>
	<49FF4AF8.1050801@free.fr> <49FF58EC.2090902@gmail.com>
	<49FFDABF.4030500@free.fr> <4A007103.4010501@gmail.com>
	<4A00B327.6080705@free.fr>
In-Reply-To: <4A00B327.6080705@free.fr>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Ubuntu: network bridging between wireless and wired
 connection fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
Cc: bridge@lists.linux-foundation.org

Nicolas de Peslo=FCan schreef:
>
> When you setup the bridge at the beginning, the br0 interface takes=20
> the MAC address of eth1. Then you add eth0 and the bridge takes the=20
> MAC address of eth0, because it is lower.
>
> Can you try to use the bridge-hw option of /etc/network/interfaces, to=20
> force the bridge MAC address to the MAC address of the wireless=20
> interface ? This might solve the communication problem for UBUNTU=20
> SERVER... but unfortunately probably not for the bridging function.
>
Now the bridge comes up perfectly, and ubuntu server can ping the=20
internet. But nobody on the eth0 of ubuntu server can access the network=20
:-( ... so no bridging indeed
