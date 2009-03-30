From: Abhishek Mathur <abhishek_mathur@hcl.in>
Date: Mon, 30 Mar 2009 10:39:38 +0530
Message-ID: <45F3FDEC759D21468F1F910D2B1CC43B691EF41B82@NDA-HCLT-EVS04.HCLT.CORP.HCL.IN>
References: <200903281536.48296.denys@visp.net.lb>
In-Reply-To: <200903281536.48296.denys@visp.net.lb>
Content-Language: en-US
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH] rstp compiling under gcc 4.3.3 fixes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Denys Fedoryschenko <denys@visp.net.lb>, Stephen Hemminger <shemminger@vyatta.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>


Can anybody just send me any diagrammatic representation of the code flow=
 of "rstpd" source code which is an updated version of "rstplib"=2E It will=
 help me a lot to get into the depth of understanding the code  ??
Kindly also list some imporatnt differences/updations in "rstpd" as=
 compared to "rstplib"??=20


-----Original Message-----
From: bridge-bounces@lists=2Elinux-foundation=2Eorg=
 [mailto:bridge-bounces@lists=2Elinux-foundation=2Eorg] On Behalf Of Denys=
 Fedoryschenko
Sent: Saturday, March 28, 2009 7:07 PM
To: Stephen Hemminger; bridge@lists=2Elinux-foundation=2Eorg
Subject: [Bridge] [PATCH] rstp compiling under gcc 4=2E3=2E3 fixes

After fetching current git code and compiling with gcc 4=2E3=2E3 got errors
Here is fix, so rstp compile fine with gcc 4=2E3=2E3

bridge_track=2Ec and main=2Ec have functions where is return value not=
 checked=2E
 Because of -Werror it won't compile=2E
Example:
gcc -Wall -Werror -O2 -g -D_REENTRANT -D__LINUX__ -DVERSION=3D0=2E16=
 -DBUILD=3D1 -I=2E -I=2E/include -I=2E/rstplib   -c -o=20
main=2Eo main=2Ec
cc1: warnings being treated as errors
main=2Ec: In function 'main':
main=2Ec:81: error: ignoring return value of 'daemon', declared with=
 attribute=20
warn_unused_result


Other fix is missing header file
gcc -Wall -O2 -g -D_REENTRANT -D__LINUX__ -DVERSION=3D0=2E16 -DBUILD=3D1 -I=
=2E -I=2E/include -I=2E/rstplib   -c -o=20
netif_utils=2Eo netif_utils=2Ec
netif_utils=2Ec: In function 'get_bridge_portno':
netif_utils=2Ec:130: error: 'INT_MAX' undeclared (first use in this=
 function)
netif_utils=2Ec:130: error: (Each undeclared identifier is reported only=
 once
netif_utils=2Ec:130: error: for each function it appears in=2E)

DISCLAIMER:
---------------------------------------------------------------------------=
--------------------------------------------
The contents of this e-mail and any attachment(s) are confidential and=
 intended for the named recipient(s) only=2E=20
It shall not attach any liability on the originator or HCL or its=
 affiliates=2E Any views or opinions presented in=20
this email are solely those of the author and may not necessarily reflect=
 the opinions of HCL or its affiliates=2E=20
Any form of reproduction, dissemination, copying, disclosure, modification,=
 distribution and / or publication of=20
this message without the prior written consent of the author of this e-mail=
 is strictly prohibited=2E If you have=20
received this email in error please delete it and notify the sender=
 immediately=2E Before opening any mail and=20
attachments please check them for viruses and defect=2E
---------------------------------------------------------------------------=
--------------------------------------------
