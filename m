Message-ID: <20070928134115.z8bvj5ws0oc00k0g@webapps>
Date: Fri, 28 Sep 2007 13:41:15 -0400
From: "Mark S. Mathews" <mark@linux-wlan.com>
Subject: Re: [Bridge] Flushing MAC-tables(?)
References: <46FCB3F4.4080802@googlemail.com>
	<2e59e6970709281007g7cc3dd95gddca21e540ea886a@mail.gmail.com>
In-Reply-To: <2e59e6970709281007g7cc3dd95gddca21e540ea886a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Good catch Richard, I forgot about the stale association problem.

Actually, my note about having the 'new AP' wlan stack generate a  
bcast frame in reponse to the association event should take care of  
this problem as well.  When the old AP's wlan stack sees a frame  
coming in from above (i.e. off the wire) with a source address equal  
to one of its associated stations, it _should_ immediately disassoc  
that station thus breaking the mac-level STA-to-STA frame path.

I think this 'send a bcast to the wire upon assoc' behavior is listed  
in a recommended-practices somewhere (been a long time).  It's  
basically a trick to enforce the 'STA shall be associated to  
one-and-only-one BSS within an ESS' rule.

-Mark

Quoting "richardvoigt@gmail.com" <richardvoigt@gmail.com>:

> On 9/28/07, Dennis Borgmann <dennis.borgmann@googlemail.com> wrote:
>>
>> Dear list-members!
>>
>> I am using OpenWRT (www.openwrt.org) on two accesspoints. Within
>> OpenWRT, the wireless interface and the ethernet interface are bridged
>> to one interface (br0).
>>
>> Those two accesspoints are standing quite far from one another. Their
>> WLAN-cells do not cross each other, meaning I have an area in between
>> the two accesspoints, where there is no accesspoint of the two
>> accessible: a dead spot.
>>
>> Now I use two WLAN-telephones (Cisco 7920). I start calling one of the
>> phones inside the same radio cell and I answer this call. Now I start
>> moving away to the other accesspoint. As soon as I see myself assiciated
>> to the "new" accesspoint, I am able to hear my mate on the other phone
>> in the "old" cell, but he cannot hear me. This stays this way, until a
>
> This seems not to be a bridging problem then, since your pal didn't move to
> a new access point, his information should be correct in all bridges (either
> correct interface or no entry).  Therefore packets sent to him should be
> correctly delivered.  OTOH his outgoing packets could be blocked by his
> access point as long as it thinks you are locally attached (the first packet
> coming in via the other access point should disillusion it without need for
> a timer).
>
> The behavior you are seeing is opposite, therefore I think you have
> misidentified the cause.  Can you use VOIP software on a real computer, and
> run packet capture software?  It might be very informative to have a
> connection phone <-> computer and also computer <-> computer in order to see
> if any packets are actually being missed, and in which direction.
>
> Most likely your phone clears the routing table when you dissociate from the
> other access point, and  the routing table isn't rebuilt until dhcp runs at
> the new location.  This affects outgoing packets more than incoming, since
> your adapter still may honor packets destined to your MAC address and
> broadcast within its range.  Of course it may not be the routing table
> either.
>
>
> certain point of time is reached. In our tests, he has been able to hear
>> my voice recurring at :30 each minute. Take these examples:
>>
>> 05:40:20 I roamed to the "new" AP
>> 05:40:30 my mate could hear me
>>
>> 05:43:35 I roamed to the "new" AP
>> 05:44:30 my mate could hear me
>>
>> 05:47:03 I roamed to the "new" AP
>> 05:47:30 my mate could hear me
>>
>> ...and so on.
>>
>> So at a certain point of time, there seems to be a flushing of some
>> bridge-tables, but I don't know, how I could influence this behaviour.
>> Is this "flushing" somehow to be done manually? Or is there a timer,
>> which sets this behaviour?
>>
>> I sniffed the WLAN a little while my tests have been done and the result
>> is, that the "old" accesspoint seems to still believe me in his radio
>> cell. So he sends out data for me all of the time, but since my
>> telephone has moved away, there is no more client to ACK these packages.
>> After the time mentioned before has passed, these packet are away and
>> the communication goes on the way it should. So I assume, there is a
>> timeout, that tells the AP to flush its old bridge-MAC tables of
>> clients, that he did not hear of since XX seconds...
>>
>> Any help would be appreciated. Thanks a lot in advance,
>>
>> Dennis
>> _______________________________________________
>> Bridge mailing list
>> Bridge@lists.linux-foundation.org
>> https://lists.linux-foundation.org/mailman/listinfo/bridge
>>
>



Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.linux-wlan.com
721-D North Drive          e-mail: mark@linux-wlan.com
Melbourne, FL 32934        Phone:  321.259.0737
USA                        Fax:    321.259.0286


