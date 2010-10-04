Message-ID: <4CA9A95B.602@tiolive.com>
Date: Mon, 04 Oct 2010 12:15:55 +0200
From: =?ISO-8859-1?Q?Fran=E7ois_Schmidts?= <francois@tiolive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Random MAC address
Reply-To: francois@tiolive.com
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

I wrote a script which generically set a bridge on some machines running=20
OpenSuse. Basically the script copy a bridge configuration file in=20
/etc/sysconfig/network (ifcfg-br0) and delete the eth0 (ifcfg-eth0)=20
config file. After a reboot the computer have an interface br0, a bridge=20
which is accessing the network through eth0.

I'm using IPv6 which calculate the address thanks to the MAC address. At=20
first, right after the machine boot, the address is clearly based on the=20
eth0 MAC address. My problem is that then, it get calculated from the=20
bridge MAC address which is, I believe, pretty random.

How can I fix that ? By declaring a static MAC address to the bridge ?=20
Is that possible / a good way to fix my problem ?

Thanks for your time and answers,
Regards,
Fran=E7ois Schmidts
