From: <yu.sheng@emc.com>
Date: Fri, 31 Dec 2010 16:13:35 -0500
Message-ID: <AB0AEA841E791C4DA825E2FDA43B788A0DFF57063A@MX24A.corp.emc.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge]  DHCP problem on bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,
  Have you solved this problem? I have a similar one. I bind three eth inte=
rfaces to a bridge. I connect eth0 to the dhcp server, and two subnets to e=
th1 and eth2. The clients in the two subnets try to get IP from the dhcp se=
rver.

  My problem is that sometimes the dhcp offer or dhcp pack packets will be =
delayed in the bridge for such a long time, that the dhcpcd on the client w=
ill timeout and thus fail to configure the IP.=20

Yu=
