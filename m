Message-ID: <4922E328.40608@navigue.com>
Date: Tue, 18 Nov 2008 10:45:44 -0500
From: Jonathan Thibault <jonathan@navigue.com>
MIME-Version: 1.0
References: <BLU149-W269664F47AF1AC405130E48B120@phx.gbl>
In-Reply-To: <BLU149-W269664F47AF1AC405130E48B120@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] All Packets Dropped if IPtables are enabled!
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.osdl.org

You probably have DROP has a default policy for the FORWARD table.

Add rules to FORWARD that lets the traffic you need through the bridge.

For example:
iptables -A FORWARD -s <host1> -d <host2> -j ACCEPT
iptables -A FORWARD -s <host2> -d <host1> -j ACCEPT

Jonthan

Fahim Akhter wrote:
> Hi,
>  
> I have a single bridge, working between two PC's for testing purposes. 
> In rc.local if I stop "service iptables stop", the bridge works fine 
> and both sides are getting pinged.
>  
> But when I enable the IPtables it stops working, I need the iptables 
> for filtering and to use with ebtables, any Ideas ?
>  
> Thanks,
> Fahim Akhter
>
> ------------------------------------------------------------------------
> Invite your mail contacts to join your friends list with Windows Live 
> Spaces. It's easy! Try it! 
> <http://spaces.live.com/spacesapi.aspx?wx_action=create&wx_url=/friends.aspx&mkt=en-us> 
>
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge

