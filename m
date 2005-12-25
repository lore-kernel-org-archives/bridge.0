From: =?ISO-8859-1?Q?KLEIN_St=E9phane?= <stephane@harobed.org>
Date: Sun, 25 Dec 2005 19:31:19 +0100
Message-ID: <43AEE577.60006@harobed.org>
References: <dolu7k$anu$1@sea.gmane.org> <43AEE0D3.9070705@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <43AEE0D3.9070705@osdl.org>
Sender: news <news@sea.gmane.org>
Subject: [Bridge] Re: When I add br0 (brctl addbr br0),
 and I show bridge   list  (brctl
 show) it's eth0 which is in the list. It's a bug ?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Stephen Hemminger a =E9crit :
> What is the hardware address of your eth0?
> It looks like it is 00:00:00:00:00:00 which implies a hardware
> problem?
>=20
> Look at 'ifconfig eth0' output


harobed@harobed:~$ ifconfig eth0
eth0      Lien encap:Ethernet  HWaddr 00:02:3F:18:82:08
           adr inet6: fe80::202:3fff:fe18:8208/64 Scope:Lien
           UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1
           RX packets:56805 errors:3 dropped:0 overruns:0 frame:0
           TX packets:42317 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 lg file transmission:1000
           RX bytes:68476458 (65.3 MiB)  TX bytes:3858839 (3.6 MiB)
           Interruption:10 Adresse de base:0xc000

