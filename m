Message-ID: <4901CF79.7090100@navigue.com>
Date: Fri, 24 Oct 2008 09:36:57 -0400
From: Jonathan Thibault <jonathan@navigue.com>
MIME-Version: 1.0
References: <5ff1e2470810232052w26e13b74paa61197db397938@mail.gmail.com>
In-Reply-To: <5ff1e2470810232052w26e13b74paa61197db397938@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] ip alias in linux bridge mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sathyan M <sathym@gmail.com>, bridge@lists.osdl.org

Hello Sathy,

You can configure ip aliasing on a bridge interface just as you would on 
a regular interface.  I wouldn't know the specifics involved with tproxy 
however.

The bridge just forwards ethernet frames, so it probably doesn't make a 
distinction between vpn traffic and other traffic.  ebtables and 
iptables decide what would go through or not.

Hope this helps,
Jonathan

Sathyan M wrote:
> Hi,
>
> Is it possible to configure ip alias in bridge interface?
>
> So that i will make squid-tproxy to bind outgoing address with
> different ip address for corresponding LAN.
>
> And also like to know whether bridge will allow VPN traffic with
> default configuration.
>
> Thanks,
> Sathy
>   

