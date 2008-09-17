Message-ID: <2ced936d0809162304o5ab63f10x623771fa88174f53@mail.gmail.com>
Date: Wed, 17 Sep 2008 03:04:03 -0300
From: "Breno Jacinto" <breno@freeunix.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Bridge] Bridging heterogeneous networks
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello, this is my first post here, I'm glad I found out this great
piece of work, congratulations to everyone involved.

    I'm working on a project where we intend to integrate different
link-layer technologies, specifically, Bluetooth, 802.11 networks and
Ethernet. Since we want to escape IP routing and stay layer 3
independent, we are studing solutions at a level like MPLS's layer
2.5.

    After reading some documentation on the page about the Linux
Ethernet Bridge, I'm wondering if someone has had a similar experience
and can tell me if there's a possibility of this being achieved. If
not, what are the challenges? Is there any driver-specific issues
involving any of the technologies?

   My feeling is that this is possible since Bluetooth supports BNEP
(Ethernet emulation), 802.11 is supposed to be ethernet-like and
Ethernet is already supported.

thanks in advance,

--=20
--=20
:: Breno Jacinto ::
:: breno - at - gprt.ufpe.br ::
:: FingerPrint ::
 2F15 8A61 F566 E442 8581
 E3C0 EFF4 E202 74B7 7484
:: Persistir no dif=EDcil =E9 a =FAnica maneira de torn=E1-lo f=E1cil algum=
 dia. ::
