Message-ID: <20070928160245.ze2mcs5uogc0w40s@webapps>
Date: Fri, 28 Sep 2007 16:02:45 -0400
From: "Mark S. Mathews" <mark@linux-wlan.com>
Subject: Re: [Bridge] Flushing MAC-tables(?)
References: <46FCB3F4.4080802@googlemail.com>
	<2e59e6970709281007g7cc3dd95gddca21e540ea886a@mail.gmail.com>
	<20070928134115.z8bvj5ws0oc00k0g@webapps>
	<2e59e6970709281151v69915609qf221bb5052fdd6a6@mail.gmail.com>
In-Reply-To: <2e59e6970709281151v69915609qf221bb5052fdd6a6@mail.gmail.com>
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
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Cc: bridge@lists.linux-foundation.org


Quoting "richardvoigt@gmail.com" <richardvoigt@gmail.com>:

> On 9/28/07, Mark S. Mathews <mark@linux-wlan.com> wrote:
>>
>> Good catch Richard, I forgot about the stale association problem.
>>
>> Actually, my note about having the 'new AP' wlan stack generate a
>> bcast frame in reponse to the association event should take care of
>> this problem as well.  When the old AP's wlan stack sees a frame
>> coming in from above (i.e. off the wire) with a source address equal
>> to one of its associated stations, it _should_ immediately disassoc
>> that station thus breaking the mac-level STA-to-STA frame path.
>>
>> I think this 'send a bcast to the wire upon assoc' behavior is listed
>> in a recommended-practices somewhere (been a long time).  It's
>> basically a trick to enforce the 'STA shall be associated to
>> one-and-only-one BSS within an ESS' rule.
>
> Most stations will send a broadcast upon association even without help from
> the AP (DHCP-REQUEST for example).
>
> In this case, the station that moved can still hear the other station, which
> makes me believe there is not a stale association, or stale MAC entries,
> because the stationary node obviously found the new location of the mobile
> node correctly.  It's the mobile node that can't transmit.  That's backwards
> from the breakage you'd get from a stale association/stale bridge learn
> table.

Too true.  I had to reread the problem description and you're quite  
correct, sorry for the confusion.

The 'most stations' note though...;-) we've learned the hard way that  
there are plenty of mac/driver/host combinations that only issue DHCP  
requests on ESS transitions.

-Mark


Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.linux-wlan.com
721-D North Drive          e-mail: mark@linux-wlan.com
Melbourne, FL 32934        Phone:  321.259.0737
USA                        Fax:    321.259.0286


