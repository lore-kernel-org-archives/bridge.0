MIME-Version: 1.0
In-Reply-To: <OF0314F87C.B7A0780D-ONC12575D3.00476B7B-C12575D3.00484E73@transmode.se>
References: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>
	<20090610074542.39f713eb@nehalam>
	<OFF985F65C.FBA8694B-ONC12575D1.00546CBF-C12575D1.0055565C@transmode.se>
	<de7adc5e0906111251h563fe0b1ic28ae7004d8b3e7@mail.gmail.com>
	<m33aa5bykm.fsf@ursa.amorsen.dk>
	<OFEA0D61B2.8B351FDC-ONC12575D3.0034AA26-C12575D3.00354697@transmode.se>
	<20090612125214.GA7461@kallisti.us>
	<OF0314F87C.B7A0780D-ONC12575D3.00476B7B-C12575D3.00484E73@transmode.se>
Date: Fri, 12 Jun 2009 08:19:22 -0500
Message-ID: <2e59e6970906120619u589ed8dfy8bb327efa305b742@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] RFC: Simple Private VLAN impl.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org, Benny Amorsen <benny+usenet@amorsen.dk>

On Fri, Jun 12, 2009 at 8:09 AM, Joakim
Tjernlund<joakim.tjernlund@transmode.se> wrote:
> Ross Vandegrift <ross@kallisti.us> wrote on 12/06/2009 14:52:14:
>>
>> On Fri, Jun 12, 2009 at 11:41:55AM +0200, Joakim Tjernlund wrote:
>> > Yes, sets would be nice. However I wonder if this case isn't a bug
>> > in any case:
>> > Consider these VLANS:
>> > =A0eth0.4042
>> > =A0eth0.4043
>> > =A0eth0.4044
>> >
>> > Add them to a bridge and the bridge will pass pkgs between them, right=
?
>> > However no real switch I know would do that because they are on
>> > the same physical interface.
>>
>> No, that's not a problem at all. =A0Any dot1q bridge would behave
>> exactly as Linux does if it supports VLAN bridging (which at least
>> Cisco, Nortel, and Juniper do in varying capcities).
>>
>> Moreover, any dot1q bridge that doesn't support VLAN bridging can
>> (be careful!) have the feature added by adding one untagged port into
>> each VLAN and cabling them to a dot1d bridge. =A0Linux just saves you
>> cables.
>>
>> The split-horizon rule is for flooding into a broadcast domain. =A0For
>> purposes of split-horizon flooding, each of your VLAN interfaces are
>> physical interfaces - a broadcast frame arrived on one of the ports
>> and needs to be flooded out all of the others.
>
> hmm, then I don't understand how Private VLAN is supposed to work over
> the interswitch port. If I understand you correctly, a Bcast pkg arriving
> on VLAN 4042 will be forwarded back over 4043 and 4044 VLANs, then the
> receiving switch will forward back these to pkgs once again and
> it never stops?

Only one switch would be configured to bridge between VLANs.

VLANs are by default (in the absence of enabling bridging) isolation barrie=
rs.

Most entry-level physical switches (basic VLAN support only) consider
all VLANs with the same ID to be members of the same bridge, there is
one such bridge for each configured VLAN.  Linux allows you to have
this operation trivially, but allows far more powerful combinations.

All this "promiscuous VLAN" stuff is just an attempt to bring some of
the features of software bridging (e.g. Linux) to hardware switches in
a standard way.
