Message-ID: <2354.158.39.79.251.1075131361.squirrel@thaumaturge.org>
In-Reply-To: <1074770372.9625.146.camel@lotte.street-vision.com>
References: <3438.158.39.79.251.1074767243.squirrel@thaumaturge.org> 
	<1074770372.9625.146.camel@lotte.street-vision.com>
Date: Mon, 26 Jan 2004 16:36:01 +0100 (CET)
From: "Dante" <dante@thaumaturge.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: [Bridge] Re: [VLAN] newbie problems
Reply-To: dante@thaumaturge.org
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Justin Cormack <justin@street-vision.com>
Cc: vlan@wanfear.com, bridge@osdl.org

Thanks for the reply.

You are quite right about the routing, and i've advanced to the bridging
part.
But it will not work. I've finaly gotten access to the switch it's
connected to and from the logs i've got this output:

Jan 26 16:49:56: %SPANTREE-2-RECV_PVID_ERR: Received BPDU with
inconsistent peer vlan id 4 on GigabitEthernet0/1 VLAN40.
Jan 26 16:49:56: %SPANTREE-2-BLOCK_PVID_PEER: Blocking GigabitEthernet0/1
on VLAN0004. Inconsistent peer vlan.
Jan 26 16:49:56: %SPANTREE-2-BLOCK_PVID_LOCAL: Blocking GigabitEthernet0/1
on VLAN0040. Inconsistent local vlan.

As the logs show, it's getting blocked.
It happens when i add the second vlan interface to the bridge (br0)
interface. The physical interface is still connected to the cisco switch
with a single cable to a trunked port.

I'm pasting the configuration of this port:
interface GigabitEthernet0/1
 switchport trunk native vlan 10
 switchport mode trunk
 no ip address
 duplex full

Pasting bridgeinfo:
root@testbridge:~# brctl show
bridge name     bridge id               STP enabled     interfaces
br0             8000.000103bdb23b       no              eth0.4
                                                        eth0.40

(stp on/off have no diff)

Anyone got any good ideas? (design flaws?)
Posting this also to the bridging list

-Dante

> If you look at the output of route you will see that your default route
> for x.x.x.x.0/24 is eth0.4 as you set it up first. You can see hosts on
> eth0.40 if you set manual routes for them say. But just turn on bridging
> and it should work.
>
>
> On Thu, 2004-01-22 at 10:27, Dante wrote:
>> Hi.
>> I'm trying to get VLAN to work in a system i've already set up running
>> on
>> several NIC's.
>> It's basicly a bridge between two VLAN's. One is the "external" part,
>> and
>> one for "internal". The bridge is designed to make the the internal
>> clients log into it, authenticating the users, before leting them reach
>> the Internet. Its running "fine" with several NIC's and it's bridging
>> between two VLAN's, although it doesnt see them. (Non-trunked ports).
>>
>>      |---------|        |-------------|        |-----------|
>> Inet |    gw   | VLAN 4 |   bridge    | vlan40 |  clients  |
>> <----| x.x.x.1 |--------| interface1  |--------| x.x.x.13+ |
>>      |         |  ext   | interface2  |  int   |           |
>>      |---------|        |-------------|        |-----------|
>>
>> interface1 = eth0 = x.x.x.11/24
>> interface2 = eth1 = x.x.x.12/24
>>
>> However, I'm trying to get it running on VLAN's, on trunked ports, and
>> bridge between those.
>> So far I'm having problem with the VLAN setup. (Not yet reached the
>> bridging part)
>>
>> I set the host running with one NIC, add it, add first virtual interface
>> (eth0.4), give it ip. And it's running smoothly. It's reaching the gw
>> and
>> hosts on the VLAN 4.
>> BUT, as I add second virtual interface (eth0.40), give it ip. It cannot
>> reach any of the hosts on VLAN 40.
>> I see with tcpdump and similar tools that it is sending it's packets
>> over
>> the first interface/VLAN 4 (eth0.4).
>>
>>      |---------|        |-------------|        |-----------|
>> Inet |    gw   | VLAN 4 |   bridge    | vlan40 |  clients  |
>> <----| x.x.x.1 |--------| interface1  |--------| x.x.x.13+ |
>>      |         |  ext   | interface2  |  int   |           |
>>      |---------|        |-------------|        |-----------|
>>
>> interface1 = eth0.4 = x.x.x.11/24
>> interface2 = eth0.40 = x.x.x.12/24
>>
>> The bridge-host is a Slackware 9.1, with 2.4.24 kernel, vlan.1.8 (and
>> bridge-utils-0.9.6)
>>
>> I'm then wondering if i've got a design flaw in this setup? (I really
>> dont
>> want to subnet it. Since it's already working with 2 physical
>> interfaces)
>> I think it's probably a fairly easy solution here.. somewhere. But i'm
>> getting blind on this now.
>>
>> Cheers,
>> Dante
>> --
>> Not even the sun can banish the phantoms of our land.
>> Nevertheless, we huddle in the darkness and pray for dawn...
>>
>>
>> _______________________________________________
>> VLAN mailing list  -  VLAN@wanfear.com
>> http://www.WANfear.com/mailman/listinfo/vlan
>> VLAN Page:  http://scry.wanfear.com/~greear/vlan.html
>
>
>

