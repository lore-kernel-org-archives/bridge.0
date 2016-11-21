Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 21 Nov 2016 22:44:52 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161121214452.GA10227@otheros>
Reply-To: bridge@lists.linux-foundation.org
References: <E5B11A06AD89DB429345609918715652FBF2FF58@XMB121CNC.rim.net>
	<20161112115213.GG3151@otheros>
	<E5B11A06AD89DB429345609918715652FBF54303@XMB121CNC.rim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E5B11A06AD89DB429345609918715652FBF54303@XMB121CNC.rim.net>
Subject: Re: [Bridge] Force IGMP membership
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Corey Melanson <cmelanson@blackberry.com>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

On Wed, Nov 16, 2016 at 05:24:36PM +0000, Corey Melanson wrote:
> Please let me know if there is any other information that would be helpful.
> 
> Thank you,
> Corey

Hi Corey,

I tried to reproduce your issue in a similar VM setup, but was
unsuccessful so far. For me things seem to work with 4.9-rc3
kernels.


What I tried:
            
    [vm-s] -- [vm-br] == [vm-r]

vm-s and vm-br are connected via one interface pair. vm-br and
vm-r share two interfaces.

On vm-r's 1st interface there is socat running which joins
239.236.15.150 [1]. On vm-r's 2nd interface there is a tcpdump
listening for UDP packets.
-> vm-br with a "bridge mdb show dev br0" shows one entry for
   239.236.15.150 for the 1st interface towards vm-r

vm-s sends multicast traffic to 239.236.15.150 via socat [2].
-> Is received successfully in socat on vm-r,
   tcpdump on 2nd interface stays empty


Then I did not do the full interface hotplugging, but instead
typed your "bridge mdb add..." command on vm-br for the 2nd
interface towards vm-r.

Finally I redid the socat transmission on vm-s. And vm-r received
this packet successfully both in socat running on its 1st
interface and in tcpdump running on its 2nd one.


Could you retry with a recent kernel, too, Corey?

Regards, Linus


[1]: $ socat -u UDP4-RECV:1234,reuseaddr,ip-add-membership="239.236.15.150:ens3" -
[2]: $ socat - UDP4-DATAGRAM:"239.236.15.150:1234"
