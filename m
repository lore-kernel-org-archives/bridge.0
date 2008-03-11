Message-ID: <47D6A8D3.1030201@navigue.com>
Date: Tue, 11 Mar 2008 11:44:19 -0400
From: Jonathan Thibault <jonathan@navigue.com>
MIME-Version: 1.0
References: <96CF49BD8B56384395D698BA99007FA32FA169@exchange.pacwire.local>
In-Reply-To: <96CF49BD8B56384395D698BA99007FA32FA169@exchange.pacwire.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge, vlan and *no* stp/bpdu
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello Leigh,

This was one of the first things I looked at when I noticed that it 
didn't reach the client.  As far as I can tell, no, the mac isn't on the 
wrong port.  Come to think of it, I think the problem might have to do 
with the bridge not learning the affected machine's MAC at all until I 
removed in.3 from the bridge completely.  I'll do further tests and 
confirm this shortly, especially if you think there is something to it.

Also of note, since I monitor the trunk itself (and I only filter by mac 
when I do), I would have seen the reply if it went to the wrong vlan 
anyway, or is that logic wrong?

Anyway, if the problem is that the bridge stops learning a specific 
machine's MAC, is there a way for me to manually add the MAC to the 
bridge table and see if it solves the problem?  If such is the case, 
it's not really a solution, but it would certainly narrow down the scope 
of the problem.

Jonathan


Leigh Sharpe wrote:
> Can you do a brctl showmacs br0, and see if the machines which are not
> receiving an ARP response are being seen by the bridge as being on the
> wrong VLAN?
>
>
> Ie, I'm wondering if the bridge sees their MAC address on an interface
> other than the one they are really connected to. If that's the case, the
> bridge would send their response out of the wrong interface, which may
> result in the symptoms you are describing. I think there may be some
> ebtables rules which could help here, but my memory fails me at this
> point.
>
> Regards,
>              Leigh
>  
> Leigh Sharpe
> Network Systems Engineer
> Pacific Wireless
> Ph +61 3 9584 8966
> Mob 0408 009 502
> Helpdesk 1300 300 616
> email lsharpe@pacificwireless.com.au
> web www.pacificwireless.com.au
>  
>   

