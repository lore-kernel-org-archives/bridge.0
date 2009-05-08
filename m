MIME-Version: 1.0
In-Reply-To: <20090508090226.70d23727@nehalam>
References: <OF6C9DD85E.5F51CD2D-ONC12575B0.002E85F9-C12575B0.002F0604@transmode.se>
	<20090508090226.70d23727@nehalam>
Date: Fri, 8 May 2009 11:43:59 -0500
Message-ID: <2e59e6970905080943n38f258cfo3754ffde92660d43@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] brigde does not relay BPDU multicast pkgs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: bridge@lists.linux-foundation.org, Joakim Tjernlund <joakim.tjernlund@transmode.se>

On Fri, May 8, 2009 at 11:02 AM, Stephen Hemminger
<shemminger@vyatta.com> wrote:
> On Fri, 8 May 2009 10:33:37 +0200
> Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
>
>>
>> Hi List
>>
>> We have noticed that when STP is off in the linux bridge, it won't
>> relay STP pkts received from other bridges.
>> This feels like a bug(a bad one too). I hope this isn't
>> intentional behaviour?
>>
>> =A0Jocke
>>
>> _______________________________________________
>> Bridge mailing list
>> Bridge@lists.linux-foundation.org
>> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
> It is a debatable whether this is correct behaviour.
> My current opinion is that it needs to forward STP packets if
> STP is off. This would allow for loop detection by other bridges
> doing STP.

Also, if the bridge code forwards them, it's trivially easy to block
these packets with ebtables if that's the desired behavior.  It's not
so easy to forward them if the bridge code drops them.

>
> Longer term, RSTP needs to be fully integrated and default to on.
> That way the average user will be safe from loops.
>
> --
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
