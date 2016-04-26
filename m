Return-Path: <ser@man.szczecin.pl>
From: Seweryn Niemiec <ser@man.szczecin.pl>
Message-ID: <571F6F45.7070000@man.szczecin.pl>
Date: Tue, 26 Apr 2016 15:38:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PROBLEM] mac address learned on wrong port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

On one of my servers, the most basic thing doesn't work and after 2 days of 
unsuccessful digging in my severs and the Internet, I'm desperate enough to 
write to this list :)

Ubuntu server with kernel 3.19.0-33-generic #38~14.04.1-Ubuntu has p2p1.17 
physical interface attached to bri17 bridge. When I start some LXC container, it 
creates for ex. vethPQORXD interface and adds it to bri17 bridge. It looks like 
this:

# brctl show bri17
bridge name     bridge id               STP enabled     interfaces
bri17           8000.00163eaaaa30       no              p2p1.17
                                                         vethPQORXD

LXC container's eth0 interface (linked to vethPQORXD) has mac 00:16:3e:aa:aa:66. 
When I add IP do this eth0 and ping something to generate eth frame, that mac is 
learned on p2p1.17 port instead of vethPQORXD:

# brctl showmacs bri17
port no mac addr                is local?       ageing timer
   1     00:16:3e:aa:aa:66       no               112.50
[... some other macs ...]
   1     3c:fd:fe:01:ee:e0       yes                0.00
   1     3c:fd:fe:01:ee:e0       yes                0.00
   2     fe:56:74:59:a4:9e       yes                0.00
   2     fe:56:74:59:a4:9e       yes                0.00

Of course it makes communication of outside world with that container impossible 
(host<->container works).

Any ideas why this happens?

-- 
Best regards,
Seweryn Niemiec

