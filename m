Message-ID: <37471.84.123.233.184.1175460192.squirrel@www.arcoscom.com>
In-Reply-To: <20070401120519.4a070b95@localhost.localdomain>
References: <59452.84.123.233.184.1175286636.squirrel@www.arcoscom.com>
	<20070401120519.4a070b95@localhost.localdomain>
Date: Sun, 1 Apr 2007 22:43:12 +0200 (CEST)
From: "ArcosCom Linux User" <linux@arcoscom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Why TTL is changing when sending a ping?
Reply-To: linux@arcoscom.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: lartc@mailman.ds9a.nl, bridge@lists.linux-foundation.org

El Dom, 1 de Abril de 2007, 21:05, Stephen Hemminger escribi=F3:
> On Fri, 30 Mar 2007 22:30:36 +0200 (CEST)
> "ArcosCom Linux User" <linux@arcoscom.com> wrote:
>
>> The situation is this:
>>
>> INTERNET -- ROUTER -- ETHERNET+WIFI -- PC's
>>
>> The conection between INTERNET and ROUTER is done with 2 LINKs with
>> static
>> IP's.
>>
>> The conection between ROUTER and PC's is done via ETHERNET lan with many
>> bridges and ACCESSPOINTS.
>>
>> The PC's are in a IP subnet, the BRIDGES in another IP subnet, the AP's
>> in
>> another IP subnet. The ROUTER has 1 bridge interface (2 real ethernets
>> in
>> the bridge) connected to the LAN.
>>
>> In the router exists then br0, br0:1, br0:2, br0:3 (PCs, APs, BRIDGEs IP
>> subnets) to allow IP connection over the ETHERNET+WIFI between ROUTER
>> and
>> clients.
>>
>> The principal purpose of the ROUTER is to allow internet acces to PC's.
>> The BRIDGES and AP's have got implemented STP protocol and appears to be
>> working fine (ap's and bridges are embedded linux boxes).
>>
>> In router I have enabled rp_filter in all interfaces, default and each
>> one.
>> The ip routing is enabled too (obviously).
>>
>> I detected that a normal ping from ROUTER to one PC usually has a
>> TTL=3D64,
>> but many times that TTL changes to 128.
>>
>> What could be the problem? The "routing" enabled in bridge devices?
>> Some TCP/IP parameter I don't configured fine?
>> Any idea?
>>
>
> Are you using some form of connection tracking filtering on the bridge?
> If the packet has to be regenerated as part of filtering it might
> restart the TTL hop count.
>

Yes, but not really into the bridges as is. I'm using tracking between
wan0 an zlan0, not between the bridges interfaces.

As I described below, the TTL changes with pings from ROUTER to any PC, my
question is not about pings from LAN to internet and in this case (local
pings from router to PCs) the tracking I expect has no effect, is ICMP
trafic (echo requests and answers).

Could you explain a bit how connection tracking modules (IP layer) can
interfere with ICMP traffic as you suggest?

Any other suggestions?

